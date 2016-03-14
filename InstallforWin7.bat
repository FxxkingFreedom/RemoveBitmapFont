@echo off
echo This batch re-install MS*Gothic.
echo Origin msgothic.ttc is backuped C:\temp\FontsBackup\Original
echo Effect is applyed after reboot.
echo Please quit all software.
echo ---
pause

if not exist "C:\temp\FontsBackup\Original" (
    md "C:\temp\FontsBackup\Original"
)

if not exist "C:\temp\FontsBackup\Original\msgothic.ttc" (
    takeown /F %WINDIR%\Fonts\msgothic.ttc /A
    icacls %WINDIR%\Fonts\msgothic.ttc /grant Administrators:F
    move %WINDIR%\Fonts\msgothic.ttc C:\temp\FontsBackup\Original
    copy %HOMEPATH%\Dropbox\removeBitmap\new_msgothic.ttc C:\temp\tmpfileX
    move C:\temp\tmpfileX %WINDIR%\Fonts\msgothic.ttc
    echo ---
    echo Finished install.
    echo ---
    echo Result
    dir %WINDIR%\Fonts\ms*
    pause
    shutdown -r -t 0
) else (
    echo ---
    echo New msgothic.ttc already installed.
    echo Can not re-install.
    echo ---
    pause
)
