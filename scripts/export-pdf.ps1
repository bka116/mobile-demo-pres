param(
    [string]$InputPath = (Join-Path $PSScriptRoot "..\\demo4.html"),
    [string]$OutputPath = (Join-Path $PSScriptRoot "..\\demo4.pdf")
)

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
if (-not $browser) {
    $browser = $chromeCandidates | Select-Object -First 1
}

if (-not $browser) {
    throw "Could not find Microsoft Edge or Google Chrome."
}

& $browser --headless --disable-gpu --no-first-run --disable-extensions --print-to-pdf="$resolvedOutput" $uri

if (-not (Test-Path $resolvedOutput)) {
    throw "PDF export failed: $resolvedOutput"
}

Write-Host "PDF created: $resolvedOutput"
