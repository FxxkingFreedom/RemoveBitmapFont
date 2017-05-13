@echo off
echo Effect is applyed after reboot.
echo Please quit all software.
echo ---
pause

set /p fontSelect="1: msgothic / 2: meiryo / 3: meiryob ? [1/2/3] "

if "%fontSelect%"=="1" (
    set oldFont=msgothic.ttc
    set newFont=msgothic.ttc
) else if "%fontSelect%"=="2" (
    set oldFont=meiryo.ttc
    set newFont=meiryo.ttc
) else if "%fontSelect%"=="3" (
    set oldFont=meiryob.ttc
    set newFont=meiryob.ttc
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
    echo Finished install.
    echo Result
    dir %WINDIR%\Fonts\%oldFont%
    pause
    REM shutdown -r -t 5
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
    REM shutdown -r -t 5
)
