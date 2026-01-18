param(
    [string]$InputPath = (Join-Path $PSScriptRoot "..\\demo4.html"),
    [string]$OutputPath = (Join-Path $PSScriptRoot "..\\demo4.pdf"),
    [double]$Scale = 0.85,
    [int]$ViewportWidth = 1920,
    [int]$ViewportHeight = 1080
)

$scaleValue = [Math]::Round($Scale, 2)
if ($scaleValue -le 0) {
    throw "Scale must be greater than 0."
}

$resolvedInput = Resolve-Path -Path $InputPath -ErrorAction Stop
$outputDir = Resolve-Path -Path (Split-Path $OutputPath -Parent) -ErrorAction Stop
$resolvedOutput = Join-Path $outputDir (Split-Path $OutputPath -Leaf)
$uri = (New-Object System.Uri($resolvedInput.Path)).AbsoluteUri

$edgeCandidates = @(
    (Get-Command msedge -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Source -ErrorAction SilentlyContinue),
    "C:\\Program Files\\Microsoft\\Edge\\Application\\msedge.exe",
    "C:\\Program Files (x86)\\Microsoft\\Edge\\Application\\msedge.exe"
) | Where-Object { $_ -and (Test-Path $_) } | Select-Object -Unique

$chromeCandidates = @(
    (Get-Command chrome -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Source -ErrorAction SilentlyContinue),
    "C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe",
    "C:\\Program Files (x86)\\Google\\Chrome\\Application\\chrome.exe"
) | Where-Object { $_ -and (Test-Path $_) } | Select-Object -Unique

$browser = $edgeCandidates | Select-Object -First 1
if (-not $browser -and -not $chromeCandidates) {
    throw "Could not find Microsoft Edge or Google Chrome."
}

function Invoke-PdfExport {
    param(
        [string]$BrowserPath
    )

    & $BrowserPath --headless --disable-gpu --no-first-run --disable-extensions `
        --window-size="$ViewportWidth,$ViewportHeight" `
        --force-device-scale-factor="$scaleValue" `
        --print-to-pdf-no-header --print-to-pdf="$resolvedOutput" $uri

    return Test-Path $resolvedOutput
}

$tried = @()
if ($browser) {
    $tried += $browser
    if (Invoke-PdfExport -BrowserPath $browser) {
        Write-Host "PDF created: $resolvedOutput (scale $scaleValue)"
        return
    }
}

$fallback = $chromeCandidates | Select-Object -First 1
if ($fallback -and -not (Test-Path $resolvedOutput)) {
    $tried += $fallback
    if (Invoke-PdfExport -BrowserPath $fallback) {
        Write-Host "PDF created: $resolvedOutput (scale $scaleValue)"
        return
    }
}

$triedList = ($tried | ForEach-Object { Split-Path $_ -Leaf }) -join ", "
throw "PDF export failed: $resolvedOutput (tried: $triedList)"
