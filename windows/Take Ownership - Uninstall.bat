@echo off
@echo.
echo If you see "ERROR: Access is denied." then you need to right click and use "Run as Administrator".
@echo.
echo Removing "Take ownership" context menu...
@echo.

reg delete HKCR\*\shell\runas /f
reg delete HKCR\Directory\shell\runas /f

@echo.
pause
