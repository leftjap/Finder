@echo off
cd /d %~dp0

echo [1/3] Building...
pyinstaller Finder.spec
if errorlevel 1 (
    echo Build failed.
    exit /b 1
)

echo [2/3] Deploying to C:\apps\Finder.pending\...
rd /s /q C:\apps\Finder.pending 2>nul
robocopy dist\Finder C:\apps\Finder.pending /E /NJH /NJS
if errorlevel 8 (
    echo Deploy failed.
    rd /s /q C:\apps\Finder.pending 2>nul
    exit /b 1
)

echo [3/3] Done. Restart Finder to apply update.
