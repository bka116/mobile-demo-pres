@echo off
setlocal
powershell -ExecutionPolicy Bypass -File "%~dp0render-video.ps1" %*
pause
endlocal
