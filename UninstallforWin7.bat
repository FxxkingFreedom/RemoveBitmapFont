@echo off
echo This batch uninstall MS*Gothic.
echo Effect is applyed after reboot.
echo Please quit all software.
echo ---
pause

set /p fontSelect="1: msgothic / 2: meiryo / 3: meiryob ? [1/2/3] "

if "%fontSelect%"=="1" (
    set oldFont=msgothic.ttc
) else if "%fontSelect%"=="2" (
    set oldFont=meiryo.ttc
) else if "%fontSelect%"=="3" (
    set oldFont=meiryob.ttc
)

if exist "C:\temp\FontsBackup\Original\%oldFont%" (
    takeown /F %WINDIR%\Fonts\%oldFont% /A
    icacls %WINDIR%\Fonts\%oldFont% /grant Administrators:F
    move %WINDIR%\Fonts\%oldFont% C:\temp\tmpfileX
    del C:\temp\tmpfileX
    move C:\temp\FontsBackup\Original\%oldFont% %WINDIR%\Fonts\%oldFont%
    echo ---
    echo Finished uninstall.
    echo ---
    echo Result
    dir %WINDIR%\Fonts\%oldFont%
    pause
    REM shutdown -r -t 5
)
