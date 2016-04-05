@echo off
echo Effect is applyed after reboot.
echo Please quit all software.
echo ---
pause

set /p fontSelect="1:msgothic.ttc 2:meiryo.ttc? [1/2]"

if "%fontSelect%"=="1" (
    oldFont="msgothic.ttc"
    newFont="new_msgothic.ttc"
) else if "%fontSelect%"=="2" (
    oldFont="meiryo.ttc"
    newFont="new_meiryo.ttc"
)

if not exist "C:\temp\FontsBackup\Original" (
    md "C:\temp\FontsBackup\Original"
)

if not exist "C:\temp\FontsBackup\Original\%oldFont%" (
    takeown /F %WINDIR%\Fonts\%oldFont% /A
    icacls %WINDIR%\Fonts\%oldFont% /grant Administrators:F
    move %WINDIR%\Fonts\%oldFont% C:\temp\FontsBackup\Original
    copy %HOMEPATH%\Dropbox\removeBitmap\%newFont% C:\temp\tmpfileX
    move C:\temp\tmpfileX %WINDIR%\Fonts\%oldFont%
    echo ---
    echo Finished install.
    echo ---
    echo Result
    dir %WINDIR%\Fonts\%oldFont%
    pause
    shutdown -r -t 0
) else (
    takeown /F %WINDIR%\Fonts\%oldFont% /A
    icacls %WINDIR%\Fonts\%oldFont% /grant Administrators:F
    move %WINDIR%\Fonts\%oldFont% C:\temp\tmpfileX1
    copy %HOMEPATH%\Dropbox\removeBitmap\%newFont% C:\temp\tmpfileX
    move C:\temp\tmpfileX %WINDIR%\Fonts\%oldFont%
    echo ---
    echo Finished re-install font.
    echo ---
    echo Result
    dir %WINDIR%\Fonts\%oldFont%
    pause
    shutdown -r -t 0
)
