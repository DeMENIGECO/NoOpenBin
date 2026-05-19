@echo off
setlocal EnableDelayedExpansion

echo ==========================
echo     NPI Wheel Builder
echo ==========================
echo.

:: Chiede il file zip
set /p ZIPFILE=Percorso file ZIP: (senza virgolette) 
set /p FILEFORMAT=Formato (whl/nopkg) [default nopkg]: 


if not exist "%ZIPFILE%" (
    echo File non trovato.
    pause
    exit /b
)

if "%FILEFORMAT%"=="" set FILEFORMAT=nopkg

:: normalizza lowercase
for %%A in (%FILEFORMAT%) do set FILEFORMAT=%%A

:: Cartella temporanea
set TEMP_DIR=%TEMP%\npi_extract_%RANDOM%

mkdir "%TEMP_DIR%"

:: Estrae la zip
powershell -NoProfile -Command "Expand-Archive -LiteralPath '%ZIPFILE%' -DestinationPath '%TEMP_DIR%'"

:: Controlla manifest.json
if not exist "%TEMP_DIR%\manifest.json" (
    echo manifest.json non trovato.
    rmdir /s /q "%TEMP_DIR%"
    pause
    exit /b
)

echo Manifest trovato.
echo.

:: Legge valori dal JSON
for /f "tokens=2 delims=:" %%A in ('findstr /i "\"name\"" "%TEMP_DIR%\manifest.json"') do (
    set NAME=%%A
)

for /f "tokens=2 delims=:" %%A in ('findstr /i "\"version\"" "%TEMP_DIR%\manifest.json"') do (
    set VERSION=%%A
)

for /f "tokens=2 delims=:" %%A in ('findstr /i "\"eseguible\"" "%TEMP_DIR%\manifest.json"') do (
    set ESEGUIBILE=%%A
)

for /f "tokens=2 delims=:" %%A in ('findstr /i "\"setuptools\"" "%TEMP_DIR%\manifest.json"') do (
    set SETUPTOOLS=%%A
)

:: Pulisce virgolette e virgole
set NAME=%NAME:"=%
set NAME=%NAME:,=%

set VERSION=%VERSION:"=%
set VERSION=%VERSION:,=%

set ESEGUIBILE=%ESEGUIBILE:"=%
set ESEGUIBILE=%ESEGUIBILE:,=%

set SETUPTOOLS=%SETUPTOOLS:"=%
set SETUPTOOLS=%SETUPTOOLS:,=%

:: Rimuove spazi iniziali e finali
for /f "tokens=* delims= " %%A in ("%NAME%") do set "NAME=%%A"
for /l %%# in (1,1,100) do if "!NAME:~-1!"==" " set "NAME=!NAME:~0,-1!"

for /f "tokens=* delims= " %%A in ("%VERSION%") do set "VERSION=%%A"
for /l %%# in (1,1,100) do if "!VERSION:~-1!"==" " set "VERSION=!VERSION:~0,-1!"

for /f "tokens=* delims= " %%A in ("%ESEGUIBILE%") do set "ESEGUIBILE=%%A"
for /l %%# in (1,1,100) do if "!ESEGUIBILE:~-1!"==" " set "ESEGUIBILE=!ESEGUIBILE:~0,-1!"

for /f "tokens=* delims= " %%A in ("%SETUPTOOLS%") do set "SETUPTOOLS=%%A"
for /l %%# in (1,1,100) do if "!SETUPTOOLS:~-1!"==" " set "SETUPTOOLS=!SETUPTOOLS:~0,-1!"

echo ==========================
echo Name: %NAME%
echo Version: %VERSION%
echo Executable: %ESEGUIBILE%
echo Setuptools: %SETUPTOOLS%
echo ==========================
echo.

:: Lancia builder
call "%~dp0..\npi_setuptools\%SETUPTOOLS%.bat" "%ZIPFILE%" "%NAME%_%VERSION%-AnyWheel.%FILEFORMAT%" "%ESEGUIBILE%"

:: Pulizia
rmdir /s /q "%TEMP_DIR%"

pause