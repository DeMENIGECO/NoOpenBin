@echo off
setlocal EnableDelayedExpansion

echo =============================
echo             NPI
echo =============================

set /p "PACKAGE=Inserisci il pacchetto da installare: "
set /p "VERSION=Inserisci la versione del pacchetto: "

echo raccogliendo %PACKAGE%...

set "BASE=https://github.com/DeMENIGECO/NoOpenBin/raw/refs/heads/main/npi/%PACKAGE%"

set "WHL_FILE=%PACKAGE%_%VERSION%-AnyWheel.whl"
set "NOPKG_FILE=%PACKAGE%_%VERSION%-AnyWheel.nopkg"

set "WHL_URL=%BASE%/%WHL_FILE%"
set "NOPKG_URL=%BASE%/%NOPKG_FILE%"

set "CACHE=%TEMP%\npi_cache"
mkdir "%CACHE%" >nul 2>nul

:: =========================
:: DECISIONE FORMATO
:: =========================

set "FINAL_FILE=%NOPKG_FILE%"
set "FINAL_URL=%NOPKG_URL%"

curl -s -I -L "%WHL_URL%" | findstr "200" >nul

if %ERRORLEVEL%==0 (
    set "FINAL_FILE=%WHL_FILE%"
    set "FINAL_URL=%WHL_URL%"
)

:: =========================
:: DOWNLOAD
:: =========================

echo download %PACKAGE%...

set "DOWNLOADED=%CACHE%\package.zip"

curl -s -L -f -o "%DOWNLOADED%" "%FINAL_URL%" >nul 2>nul

:: =========================
:: INSTALLAZIONE
:: =========================

echo installazione...

set "EXTRACT=%CACHE%\extract_%RANDOM%"
mkdir "%EXTRACT%" >nul 2>nul

powershell -NoProfile -Command "Expand-Archive -Force '%DOWNLOADED%' '%EXTRACT%' > $null"

set "DEST=%~dp0..\..\..\..\Lib\%PACKAGE%"
mkdir "%DEST%" >nul 2>nul

xcopy "%EXTRACT%\*" "%DEST%" /E /Y /I >nul

:: =========================
:: FINE
:: =========================

echo.
echo Il pacchetto e' stato installato!

rmdir /s /q "%EXTRACT%"
del "%DOWNLOADED%"

pause 