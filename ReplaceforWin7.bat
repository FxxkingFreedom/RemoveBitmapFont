@echo off
echo Effect is applyed after reboot.
echo Please quit all software.
echo ---
pause

if exist "C:\temp\FontsBackup\Original\msgothic.ttc" (
    takeown /F %WINDIR%\Fonts\msgothic.ttc /A
    icacls %WINDIR%\Fonts\msgothic.ttc /grant Administrators:F
    move %WINDIR%\Fonts\msgothic.ttc C:\temp\tmpfileX1
    copy %HOMEPATH%\Dropbox\removeBitmap\new_msgothic.ttc C:\temp\tmpfileX
    move C:\temp\tmpfileX %WINDIR%\Fonts\msgothic.ttc
    echo ---
    echo Finished re-install font.
    echo ---
    pause
)

echo ---
echo Result
dir %WINDIR%\Fonts\ms*

echo ---
pause
REM reboot
