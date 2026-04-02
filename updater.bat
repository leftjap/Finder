@echo off
:: Finder 자가 업데이트 스크립트
:: main.py가 pending 감지 시 이 스크립트를 독립 실행 후 종료한다.
:: 1초 대기 → 기존 폴더 교체 → 새 exe 실행

timeout /t 1 /nobreak >nul

set APP_DIR=C:\apps\Finder
set OLD_DIR=C:\apps\Finder.old
set PENDING_DIR=C:\apps\Finder.pending

rd /s /q "%OLD_DIR%" 2>nul
ren "%APP_DIR%" Finder.old
if errorlevel 1 (
    echo Update failed: could not rename app folder.
    rd /s /q "%PENDING_DIR%" 2>nul
    exit /b 1
)
ren "%PENDING_DIR%" Finder
if errorlevel 1 (
    echo Update failed: could not rename pending folder. Rolling back...
    ren "%OLD_DIR%" Finder 2>nul
    exit /b 1
)
rd /s /q "%OLD_DIR%" 2>nul

start "" "%APP_DIR%\Finder.exe"
