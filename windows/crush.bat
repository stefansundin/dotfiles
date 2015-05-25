@echo off
echo pngcrush.exe -brute -rem gAMA -rem cHRM -rem iCCP -rem sRGB file.png out.png
echo pngcrush.exe -brute -rem gAMA -rem cHRM -rem iCCP -rem sRGB -d crush *.png

:start

echo.
set file=

if "%1" == "" (
	set /p file=File or dir: 
) else (
	set file=%1
)

if [%file%] == [] (
	exit /b
)

if [^%file:~0,1%] == [^"] (
	set file=%file:~1,-1%
)

if "%file:~-4,4%" == ".png" (
	echo Crushing png: %file%
	pngcrush.exe -brute -rem gAMA -rem cHRM -rem iCCP -rem sRGB "%file%" "%file%-crushed.png"
) else (
	echo Crushing dir: %file%
	pngcrush.exe -brute -rem gAMA -rem cHRM -rem iCCP -rem sRGB -d "%file%\crush" "%file%\*.png"
)

goto start
