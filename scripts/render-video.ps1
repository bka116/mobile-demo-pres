param(
    [string]$Html = "video-1min.html",
    [double]$Duration = 60,
    [int]$Width = 1920,
    [int]$Height = 1080,
    [int]$Fps = 30,
    [int]$Crf = 18,
    [string]$Out = "renders",
    [string]$Mp4 = "video-1min.mp4"
)

$scriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$projectRoot = Split-Path -Parent $scriptRoot
$htmlPath = Join-Path $projectRoot $Html
$outPath = Join-Path $projectRoot $Out

python (Join-Path $scriptRoot "render-video.py") `
    --html $htmlPath `
    --duration $Duration `
    --width $Width `
    --height $Height `
    --fps $Fps `
    --crf $Crf `
    --out $outPath `
    --mp4 $Mp4
