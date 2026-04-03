@echo off
:: Finder 자가 업데이트 스크립트
:: finder-updater.bat 로 프로젝트 루트에 복사되어 실행됨

timeout /t 3 /nobreak >nul

set ROOT=C:\dev\apps\finder
set APP_DIR=%ROOT%\bin
set OLD_DIR=%ROOT%\bin.old
set PENDING_DIR=%ROOT%\bin.pending

if not exist "%PENDING_DIR%" (
    echo No pending update found.
    goto :cleanup
)

rd /s /q "%OLD_DIR%" 2>nul
ren "%APP_DIR%" bin.old
if errorlevel 1 (
    echo Update failed: could not rename bin directory.
    goto :cleanup
)
ren "%PENDING_DIR%" bin
if errorlevel 1 (
    echo Update failed: could not rename pending directory. Rolling back...
    ren "%OLD_DIR%" bin 2>nul
    goto :cleanup
)
rd /s /q "%OLD_DIR%" 2>nul

start "" "%APP_DIR%\Finder.exe"

:cleanup
del /f "%~f0" 2>nul
