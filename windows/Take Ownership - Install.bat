@echo off
@echo.
echo If you see "ERROR: Access is denied." then you need to right click and use "Run as Administrator".
@echo.
echo Registering "Take ownership" context menu...
@echo.

reg add HKCR\*\shell\runas /ve /t REG_SZ /d "Take ownership" /f
reg add HKCR\*\shell\runas /v HasLUAShield /t REG_SZ /d "" /f
reg add HKCR\*\shell\runas /v NoWorkingDirectory /t REG_SZ /d "" /f
reg add HKCR\*\shell\runas\command /ve /t REG_SZ /d "cmd.exe /c takeown /f \"%%1\" && icacls \"%%1\" /grant administrators:F" /f
reg add HKCR\*\shell\runas\command /v IsolatedCommand /t REG_SZ /d "cmd.exe /c takeown /f \"%%1\" && icacls \"%%1\" /grant administrators:F" /f

reg add HKCR\Directory\shell\runas /ve /t REG_SZ /d "Take ownership" /f
reg add HKCR\Directory\shell\runas /v HasLUAShield /t REG_SZ /d "" /f
reg add HKCR\Directory\shell\runas /v NoWorkingDirectory /t REG_SZ /d "" /f
reg add HKCR\Directory\shell\runas\command /ve /t REG_SZ /d "cmd.exe /c takeown /f \"%%1\" /r /d y && icacls \"%%1\" /grant administrators:F" /f
reg add HKCR\Directory\shell\runas\command /v IsolatedCommand /t REG_SZ /d "cmd.exe /c takeown /f \"%%1\" /r /d y && icacls \"%%1\" /grant administrators:F" /f

@echo.
pause
