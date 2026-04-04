@echo off
:: Finder 자가 업데이트 스크립트
:: finder-updater.bat 로 프로젝트 루트에 복사되어 실행됨

set ROOT=C:\dev\apps\finder
set APP_DIR=%ROOT%\bin
set OLD_DIR=%ROOT%\bin.old
set PENDING_DIR=%ROOT%\bin.pending
set FAILED_DIR=%ROOT%\bin.failed
set LOG=%ROOT%\update.log

echo [%date% %time%] Update started >> "%LOG%"

:: 기존 실패 폴더 정리
rd /s /q "%FAILED_DIR%" 2>nul

:: exe 종료 대기 (5초)
timeout /t 5 /nobreak >nul

:: bin → bin.old rename (최대 3회 재시도)
set RETRY=0

:retry_rename
rd /s /q "%OLD_DIR%" 2>nul
ren "%APP_DIR%" bin.old
if not errorlevel 1 goto :rename_ok

set /a RETRY+=1
echo [%date% %time%] Rename attempt %RETRY% failed >> "%LOG%"
if %RETRY% GEQ 3 goto :rename_fail
timeout /t 3 /nobreak >nul
goto :retry_rename

:rename_fail
echo [%date% %time%] Update failed: could not rename bin after 3 attempts >> "%LOG%"
ren "%PENDING_DIR%" bin.failed 2>nul
echo [%date% %time%] bin.pending renamed to bin.failed >> "%LOG%"
goto :cleanup

:rename_ok
ren "%PENDING_DIR%" bin
if errorlevel 1 (
    echo [%date% %time%] Update failed: could not rename pending. Rolling back >> "%LOG%"
    ren "%OLD_DIR%" bin 2>nul
    goto :cleanup
)
rd /s /q "%OLD_DIR%" 2>nul
echo [%date% %time%] Update successful >> "%LOG%"

start "" "%APP_DIR%\Finder.exe"

:cleanup
del /f "%~f0" 2>nul
