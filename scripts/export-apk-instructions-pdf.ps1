param(
    [double]$Scale = 0.9,
    [int]$ViewportWidth = 1920,
    [int]$ViewportHeight = 1080
)

$scriptPath = Join-Path $PSScriptRoot "export-pdf.ps1"
$inputPath = Join-Path $PSScriptRoot "..\\apk-instructions-pdf.html"
$outputPath = Join-Path $PSScriptRoot "..\\apk-instructions.pdf"

& $scriptPath `
    -InputPath $inputPath `
    -OutputPath $outputPath `
    -Scale $Scale `
    -ViewportWidth $ViewportWidth `
    -ViewportHeight $ViewportHeight
