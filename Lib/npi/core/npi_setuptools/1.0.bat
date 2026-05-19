@echo off
setlocal EnableDelayedExpansion

set ZIPFILE=%~1
set OUTPUT=%~2
set EXECUTABLE=%~3

echo.
echo ==========================
echo NPI Setuptools 1.0
echo ==========================
echo.

:: Cartelle temporanee
set TEMP_DIR=%TEMP%\npi_build_%RANDOM%
set BUILD_DIR=%TEMP_DIR%\build

mkdir "%BUILD_DIR%"

:: Estrae ZIP
powershell -Command "Expand-Archive -Path '%ZIPFILE%' -DestinationPath '%BUILD_DIR%'"

:: Controlla eseguibile
if not exist "%BUILD_DIR%\%EXECUTABLE%" (
    echo Eseguibile non trovato.
    rmdir /s /q "%TEMP_DIR%"
    pause
    exit /b
)

:: Cartella wheel
mkdir "%TEMP_DIR%\wheel"

:: Copia eseguibile
copy "%BUILD_DIR%\%EXECUTABLE%" "%TEMP_DIR%\wheel\" >nul

:: Copia LICENSE*
for %%F in ("%BUILD_DIR%\LICENSE*") do (
    copy "%%F" "%TEMP_DIR%\wheel\" >nul
)

echo Creazione wheel...

:: Crea zip
powershell -Command ^
"Compress-Archive -Path '%TEMP_DIR%\wheel\*' -DestinationPath '%TEMP_DIR%\temp.zip'"

:: Rinomina in whl
copy "%TEMP_DIR%\temp.zip" "%CD%\%OUTPUT%" >nul

echo.
echo Wheel creato:
echo %CD%\%OUTPUT%
echo.

:: Pulizia
rmdir /s /q "%TEMP_DIR%"