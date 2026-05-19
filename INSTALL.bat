@echo off

:: INSTALL.bat
:: Non toccare questo file se non per:
:: - Nuova versione
:: - Manutenzione
:: - Contribuire


:: MAIN CLI

:main
cls
echo No Open Bin Installer Manager
echo.
echo.

echo Comandi:
echo.

powershell -Command "Write-Host '- nim install' -ForegroundColor Yellow"
echo    Installa (di default per questo utente)

powershell -Command "Write-Host '- nim escape' -ForegroundColor Yellow"
echo    Esci

echo.
set /p "PROMPT=>>"

if "%PROMPT%"=="nim install" goto install_user
if "%PROMPT%"=="nim escape" exit /b

goto main

:: INSTALLAZIONE

:install_user
set "INSTDIR=%LOCALAPPDATA%\NoOpenBin"
set "INSTURL=https://github.com/DeMENIGECO/NoOpenBin/raw/refs/heads/main/bin/nob_v1.0.0_windows-64.zip"

echo.
echo Installazione NoOpenBin per questo utente...

:: Cache temporanea
set "TMPZIP=%TEMP%\nob_install.zip"

echo Download archivio...
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
"$ProgressPreference='SilentlyContinue'; Invoke-WebRequest -Uri '%INSTURL%' -OutFile '%TMPZIP%'"

if errorlevel 1 (
    echo Errore durante il download.
    pause
    goto main
)

echo Creazione cartella...
if not exist "%INSTDIR%" mkdir "%INSTDIR%"

echo Estrazione archivio...
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
"Expand-Archive -Path '%TMPZIP%' -DestinationPath '%INSTDIR%' -Force"

if errorlevel 1 (
    echo Errore durante l'estrazione.
    pause
    goto main
)

echo Configurazione PATH...

powershell -NoProfile -ExecutionPolicy Bypass -Command "$path=[Environment]::GetEnvironmentVariable('Path','User'); if($path -notlike '*%INSTDIR%*'){ [Environment]::SetEnvironmentVariable('Path',$path + ';%INSTDIR%','User') }"

:: Aggiorna PATH della sessione corrente
set "PATH=%PATH%;%INSTDIR%"

del "%TMPZIP%" >nul 2>&1

echo.
echo Installazione completata!
echo Riavvia il terminale per usare il comando.
pause
goto main

