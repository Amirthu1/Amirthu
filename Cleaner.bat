@ECHO OFF
cls
title PC-Cleaner and Optimizer
Echo Hello there, Welcome to my App
Echo.

:start
Echo =====================================================================================
Echo.
Echo Windows Optimizer by Harshvardhan Rajesh Vyas
Echo.
echo =========================================================================================================
Echo Phase 1 will mainly clean Files whereas,
Echo Phase 2 will Work upon optimizing performance -- don't worry we will change the colour to show you this
pause
echo =========================================================================================================
Echo.
echo Phase-1
Echo.
echo =====================================================================================
echo - Disk clean-up app
echo - Clean temporary files 
echo =====================================================================================
echo Disk clean-up app
Echo.
Echo Press Ok in the external app we Open for you :-)
cmd.exe /c Cleanmgr /sageset:65535 & Cleanmgr /sagerun:65535
echo =====================================================================================
echo Clean temporary files
Echo.
cd /d c:/
rd %temp% /s /q
rmdir /s /q "%localappdata%\Microsoft\Edge\User Data\Default\Cache"
del C:\Windows\Prefetch*.* /Q
del /s *.tmp
del /S *.bak
del /S *.old

Echo =====================================================================================

Call :YesNoBox "Do u continue?"
if "%YesNo%"=="7" :Exit
if /I "%c%" EQU "7" goto :exit
if "%YesNo%"=="6" :Here
Goto :choice

:YesNoBox
REM returns 6 = Yes, 7 = No. Type=4 = Yes/No
set YesNo=
set MsgType=4
set heading=%~2
set message=%~1
echo wscript.echo msgbox(WScript.Arguments(0),%MsgType%,WScript.Arguments(1)) >"%temp%\input.vbs"
for /f "tokens=* delims=" %%a in ('cscript //nologo "%temp%\input.vbs" "%message%" "%heading%"') do set YesNo=%%a

Echo =====================================================================================

:Here
Echo =====================================================================================
Echo Warning !!! & Color 4e
Echo This will take you to the second 2nd phase of this process which is optimizing your Windows PC
Echo As this will take a longer time to complete we request you to choose either of the option
Echo Y--Continue to the optimization
Echo N--Exit this app
Echo =====================================================================================

:choice
set /P c=Are you sure you want to continue[Yes(Y)/No(N)]?
if /I "%c%" EQU "Y" goto :Here2
if /I "%c%" EQU "N" goto :exit
goto :choice
Echo =====================================================================================

:Here2
echo =====================================================================================
echo -Deployment Image Servicing and Management tool
echo -System file Checker
echo -Disk checking D: drive
echo -Disk Checking D: drive
Echo -Defragment C: and D: drive
echo =====================================================================================
echo Deployment Image Servicing and Management tool
DISM /Online /Cleanup-Image /RestoreHealth
echo =====================================================================================
echo System File Checker
Sfc /scannow
echo =====================================================================================
echo Changing directory to C Drive
cd/d C:/Windows/System32
echo =====================================================================================
echo Checking C and D disk
CHKDSK C: /f & CHKDSK C: /f

Echo.
:choice
set /P c=Are you sure you want to Defrag/Not[Exit(D)/Exit(N)]?
if /I "%c%" EQU "D" goto :Defragment
if /I "%c%" EQU "N" goto :Exit
goto :choice

:Defragment
echo =====================================================================================
echo Defragment
Defrag c: & Defrag D:
echo =====================================================================================

:choice
set /P c=Are you sure you want to Exit/Repeat[Exit(E)/Repeat(R)]?
if /I "%c%" EQU "E" goto :Exit
if /I "%c%" EQU "R" goto :start
goto :choice

:Hidden
echo =====================================================================================
Echo Re-register Apps and repair them and also the choice codings here
Powershell.exe -Command "Get-AppxPackage -allusers | foreach {Add-AppxPackage -register "$($_.InstallLocation)\appxmanifest.xml" -DisableDevelopmentMode}"
:choice
set /P c=Are you sure you want to continue[Yes(Y)/No(N)]?
if /I "%c%" EQU "Y" goto :Here
if /I "%c%" EQU "N" goto :exit
goto :choice
echo =====================================================================================

Echo.
:choice
set /P c=Are you sure you want to Exit/Repeat[Exit(E)/Repeat(R)]?
if /I "%c%" EQU "E" goto :Exit
if /I "%c%" EQU "R" goto :start
goto :choice


:exit
exit
