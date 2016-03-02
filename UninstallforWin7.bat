@echo off
echo This batch uninstall MS*Gothic.
echo Effect is applyed after reboot.
echo Please quit all software.
echo ---
pause

if exist "C:\temp\FontsBackup\Original\msgothic.ttc" (
    takeown /F %WINDIR%\Fonts\msgothic.ttc /A
    icacls %WINDIR%\Fonts\msgothic.ttc /grant Administrators:F
    move %WINDIR%\Fonts\msgothic.ttc C:\temp\tmpfileX
    del C:\temp\tmpfileX
    move C:\temp\FontsBackup\Original\msgothic.ttc %WINDIR%\Fonts\msgothic.ttc
    echo ---
    echo Finished uninstall.
    echo Please reboot Windows.
    echo ---
    pause
)

echo ---
echo Result
dir %WINDIR%\Fonts\ms*

echo ---
pause
