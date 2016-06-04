@echo off
echo This batch uninstall MS*Gothic.
echo Effect is applyed after reboot.
echo Please quit all software.
echo ---
pause

set /p fontSelect="1: msgothic.ttc / 2: meiryo.ttc? [1/2] "

if "%fontSelect%"=="1" (
    set oldFont=msgothic.ttc
) else if "%fontSelect%"=="2" (
    set oldFont=meiryo.ttc
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
    shutdown -r -t 5
)
