@echo off
title VFO Studio Adaptive V2.1 - Flashing

echo.
echo ================================================
echo   VFO Studio Adaptive V2.1
echo   ESP32-S3 Firmware Flash
echo ================================================
echo.

set "PORT=COM9"
set "BAUD=921600"
set "BIN=VFO_STUDIO_ADAPTIVE_V2_1.merged.bin"

echo Firmware: %BIN%
echo Port:     %PORT%
echo Baud:     %BAUD%
echo.

if not exist "esptool.exe" (
    echo ERROR: esptool.exe was not found.
    echo Put esptool.exe in the same folder as this BAT file.
    echo.
    pause
    exit /b 1
)

if not exist "%BIN%" (
    echo ERROR: Firmware file was not found:
    echo %BIN%
    echo.
    pause
    exit /b 1
)

echo Put the ESP32-S3 into download/boot mode if required.
echo.
pause

echo.
echo Erasing flash...
esptool.exe --chip esp32s3 --port %PORT% erase-flash

if errorlevel 1 (
    echo.
    echo ERROR: Flash erase failed.
    echo Check the COM port and USB connection.
    pause
    exit /b 1
)

echo.
echo Flashing VFO Studio Adaptive V2.1...
esptool.exe --chip esp32s3 --port %PORT% --baud %BAUD% write-flash 0x0 "%BIN%"

if errorlevel 1 (
    echo.
    echo ================================================
    echo   FLASH FAILED
    echo ================================================
    echo.
    pause
    exit /b 1
)

echo.
echo ================================================
echo   FLASH COMPLETE
echo ================================================
echo.
echo VFO Studio Adaptive V2.1 is now installed.
echo.
pause
