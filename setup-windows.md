Save list of all files on drive:
> `dir /S /B /OGN > C:\files-S.txt`

Find out what last woke the computer:
> `powercfg -lastwake`

Startup dir:
> Win+R → `shell:startup`

Install Windows without a Microsoft account:
> Click 'Create a new account', then click 'Sign in without a Microsoft account'.

After install:

1. Disable HDD spindown in Power Options.
1. Disable system sounds.
1. Make Windows use UTC as the hardware timer (to make the clock compatible with dual-booting Linux):

   ```
   cmd /C reg add HKLM\SYSTEM\CurrentControlSet\Control\TimeZoneInformation /v RealTimeIsUniversal /t REG_DWORD /d 1 /f & pause
   ```

1. Disable Windows Update waking computer from sleep:

   ```
   cmd /C reg add HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU /v AUPowerManagement /t REG_DWORD /d 0 /f & reg add HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU /v NoAutoRebootWithLoggedOnUsers /t REG_DWORD /d 1 /f & pause
   ```

1. Prevent Windows Update from hijacking sleep button:

   ```
   cmd /C reg add HKCU\Software\Policies\Microsoft\Windows\WindowsUpdate\AU /v NoAUAsDefaultShutdownOption /t REG_DWORD /d 1 /f & pause
   ```

1. Disable Windows 8 update notification:

   ```
   cmd /C reg add HKLM\SYSTEM\Setup\UpgradeNotification /v UpgradeAvailable /t REG_DWORD /d 0 /f & pause
   ```

1. Make Windows 10 ask before installing updates:

   ```
   cmd /C reg add HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU /v AUOptions /t REG_DWORD /d 2 /f & pause
   ```

   Also available through `gpedit.msc` → Computer Configuration → Administrative Templates → Windows Components → Windows Update → Configure Automatic Updates.

1. Disable Windows Defender in Windows 10:

   > Win+R → `gpedit.msc` → Computer Configuration → Administrative Templates → Windows Components → Windows Defender → Turn off Windows Defender → `(x) Enabled`

1. Disable beep:

   ```
   cmd /C reg add "HKCU\Control Panel\Sound" /v Beep /t REG_SZ /d no /f & pause
   net stop beep
   sc config beep start= disabled
   ```

1. Disable Windows 8 lock screen (go directly to password):

   > Win+R → `gpedit.msc` → Computer Configuration → Administrative Templates → Control Panel → Personalization → Do not display the lock screen → `(x) Enabled`

1. Disable zone information (warning for downloaded files):

   > Win+R → `gpedit.msc` → User Configuration → Administrative Templates → Windows Components → Attachment Manager → Do not preserve zone information in file attachments → `(x) Enabled`

1. Disable stupid automatic wake from sleep at 2:00:

   > Action Center → Maintenance → Change maintenance settings → `[ ] Allow scheduled maintenance to wake my computer at the scheduled time` → `[OK]`

   ```
   powercfg -waketimers
   ```

1. Disallow mouse from waking the computer:

   > Device Manager → Mice and other pointing devices → Razer DeathAdder → Power Management → `[ ] Allow this device to wake the computer` → `OK`

1. Taskbar buttons, never combine and hide labels:

   > Right-click taskbar → Properties → Taskbar buttons: `Never combine` → `OK`

   ```
   cmd /C reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v MinWidth /t REG_SZ /d 54 /f & pause
   ```
   > For smaller buttons, use `38`. The new size will be used the next time you log in.

1. Remove Windows Media Player from right click menu:

   > Control Panel → Default Programs → Set Program Access and Computer Defaults → Expand `Custom` → Navigate to `Choose a default media player`. Select `Use my current media player` and untick `Enable access to this program` (on the right).

1. Disable Win+Enter shortcut to bring up Narrator:

   ```
   cmd /C reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Narrator.exe" /v Debugger /t REG_SZ /d "%1" /f & pause
   ```

1. Disable Win+- shortcut to bring up Magnifier:

   ```
   takeown /f C:\Windows\System32\Magnify.exe
   cacls C:\Windows\System32\Magnify.exe /G stefan:F
   rename C:\Windows\System32\Magnify.exe Magnify_disabled.exe
   ```

1. Disable _This program might not have installed correctly_ prompts:

   > Disable the service `Program Compatibility Assistant Service` and prevent it from starting automatically.

   ```
   net stop pcasvc
   sc config pcasvc start= disabled
   ```

1. Disable error reporting:

   > Action Center → Change Action Center settings → Problem reporting settings → `(x) Never check for solutions`

1. Uninstall Skype app:

   ```
   dism /online /Remove-ProvisionedAppxPackage /PackageName:Microsoft.WindowsAlarms_2013.1204.852.3011_neutral_~_8wekyb3d8bbwe
   dism /online /Get-ProvisionedAppxPackages
   ```

1. Remove most ads from Skype:

   > Control Panel → Internet Options → Security tab → Restricted sites → `Sites` → Add `https://apps.skype.com` → `Close` → Restart Skype

1. Remove ads from Spotify:

   > Add to C:\Windows\System32\drivers\etc\hosts:
   > ```
   > 0.0.0.0 a.scorecardresearch.com
   > 0.0.0.0 b.scorecardresearch.com
   > 0.0.0.0 adxpose.tmrg.akadns.net
   > 0.0.0.0 pubads.g.doubleclick.net
   > 0.0.0.0 securepubads.g.doubleclick.net
   > 0.0.0.0 partnerad.l.doubleclick.net
   > 0.0.0.0 ad.doubleclick.net
   > 0.0.0.0 dart.l.doubleclick.net
   > ```

1. Show all audio devices (e.g. Stereo Mix):

   ```
   reg add HKCU\Software\Microsoft\Multimedia\Audio\DeviceCpl /v ShowHiddenDevices /t REG_DWORD /d 1 /f & reg add HKCU\Software\Microsoft\Multimedia\Audio\DeviceCpl /v ShowDisconnectedDevices /t REG_DWORD /d 1 /f & pause
   ```

1. TrueCrypt auto-mount:

   ```
   "C:\Program Files\TrueCrypt\TrueCrypt.exe" /a favorites /q background
   ```

1. Resolve .local (Bonjour) addresses:

   > Install [Bonjour Print Services for Windows](http://support.apple.com/kb/DL999) from Apple.

1. Autologin:

   > Run `control userpasswords2`
   >
   > Uncheck `Users must enter a user name and password to use this computer.`
   >
   > The selected user can have an empty password.

1. Guest network login:

   > Guest account must be enabled to have no login when accessing network share.

1. GPG in Windows:

   > 1. Download [Gpg4Win Vanilla](http://gpg4win.org/download.html).
   > 1. Add `C:\Program Files (x86)\GNU\GnuPG\pub` to `PATH`.

1. cmd.exe startup commands:

   ```
   reg add "HKCU\Software\Microsoft\Command Processor" /v Autorun /t REG_SZ /d "C:\Users\stefan\bin\cmd_autorun.bat" /f & pause
   ```

1. Open bat file with low priority in context menu:

   ```
   reg add HKCR\batfile\shell\openlow /ve /t REG_SZ /d "Open (Low priority)" /f & reg add HKCR\batfile\shell\openlow\command /ve /t REG_SZ /d "cmd /C start \"Low priority cmd\" /low \"%1\" %*" /f & pause
   ```

1. Open files without extension with Notepad:

   ```
   reg add HKCR\.\shell\open\command /ve /t REG_SZ /d "notepad.exe %1" /f & pause
   ```

1. Open pngcrush to .png context menu:

   ```
   reg add HKCR\pngfile\shell\1pngcrush /ve /t REG_SZ /d "pngcrush" /f & reg add HKCR\pngfile\shell\1pngcrush\command /ve /t REG_SZ /d "C:\Users\stefan\bin\pngcrush.exe -brute -rem gAMA -rem cHRM -rem iCCP -rem sRGB \"%1\" \"%1-crushed.png\"" /f & reg add HKCR\pngfile\shell\1pngcrushdir /ve /t REG_SZ /d "pngcrush to dir" /f & reg add HKCR\pngfile\shell\1pngcrushdir\command /ve /t REG_SZ /d "C:\Users\stefan\bin\pngcrush.exe -brute -rem gAMA -rem cHRM -rem iCCP -rem sRGB -d crush \"%1\"" /f & pause
   ```

1. Add "Open with Sublime Text" to directory context menu:

   ```
   reg add HKCR\Directory\shell\1subl /ve /t REG_SZ /d "Open with Sublime Text" /f & reg add HKCR\Directory\shell\1subl\command /ve /t REG_SZ /d "subl \"%V\"" /f & reg add HKCR\Directory\Background\shell\1subl /ve /t REG_SZ /d "Open with Sublime Text" /f & reg add HKCR\Directory\Background\shell\1subl\command /ve /t REG_SZ /d "subl \"%V\"" /f & pause
   ```

1. Add "Open with cmd" to directory context menu:

   ```
   reg add HKCR\Directory\shell\1cmd /ve /t REG_SZ /d "Open with cmd" /f & reg add HKCR\Directory\shell\1cmd\command /ve /t REG_SZ /d "cmd.exe /s /k pushd \"%V\"" /f & reg add HKCR\Directory\Background\shell\1cmd /ve /t REG_SZ /d "Open with cmd" /f & reg add HKCR\Directory\Background\shell\1cmd\command /ve /t REG_SZ /d "cmd.exe /s /k pushd \"%V\"" /f & pause
   ```

1. Set `PATH`:

   ```
   C:\Users\stefan\bin;C:\Users\stefan\AppData\Local\Android\sdk\platform-tools;C:\Users\stefan\AppData\Roaming\npm;C:\Users\stefan\AppData\Local\atom\bin;C:\Python34\Scripts;C:\redis;C:\Program Files\TrueCrypt;C:\Program Files\ffmpeg\bin;C:\Program Files\ImageMagick-6.8.9-Q16;C:\Program Files (x86)\GNU\GnuPG\pub;C:\Program Files (x86)\nginx;C:\Program Files (x86)\nginx\php;C:\Program Files\Sublime Text 3;C:\Program Files (x86)\NSIS\Unicode;C:\Program Files (x86)\FLAC
   ```


Python argument problem:
> ```
> reg add HKCR\Applications\python.exe\shell\open\command /ve /t REG_SZ /d "\"C:\Python33\python.exe\" \"%1\" %*" /f
> ```

Remove HomeGroup icon from desktop:
> ```
> rundll32 shell32.dll,Control_RunDLL desk.cpl,,0
> ```
> Enable Network and disable again.

Record-what-you-hear with Audacity:
> Install sound driver. Make sure you don't plug in headphones in the front jack. Go to recording devices, enable Stereo Mix (right click and show disabled devices). Do **not** check `Listen to this device` in the settings.
>
> Disable `Software Playthrough` in Audacity Preferences → Recording. Make sure to set the levels good so the waveform doesn't clip. Don't accidentally adjust the system volume during recording!!

App Paths:
> Does not work in cmd.exe.
> ```
> cmd /C reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\SuperF4.exe" /ve /t REG_SZ /d "C:\Program Files\SuperF4\SuperF4.exe" /f & pause
> ```


Bitlocker without TPM:
> Win+R → `gpedit.msc` → Computer Configuration → Administrative Templates → Windows Components → BitLocker Drive Encryption → Operating System Drives
>
> Double-click `Require additional authentication at startup` → Make sure `Allow BitLocker without a compatible TPM` is checked. → `Ok`
>
> Use `manage-bde` to add a TPM later. Password must be deleted though.

Re-generate recovery key:
> ```
> manage-bde -protectors -disable C:
> manage-bde -protectors -delete C: -type RecoveryPassword
> manage-bde -protectors -add C: -RecoveryPassword
> manage-bde -protectors -enable C:
> ```

Re-add TPM after it stops working due to e.g. BIOS update:
> ```
> manage-bde -protectors -get C:
> manage-bde -protectors -delete C: -t TPMAndPIN
> manage-bde -protectors -add C: -TPMAndPIN
> ```
