::update for Unifi As a Service::

@echo off

set SRVVAR="UniFi Network Application"

echo.
echo This script will close unifi cleanly and allow you to update unifi as a service.
echo.

timeout /t 1 /nobreak >nul
cls
echo !!!STOP!!!
echo.
echo.
set /p var=Have you created and saved a backup of your configs??[y/n]:
if /I %var%== Y goto :start
if /I %var%== N goto :illwait

:illwait
echo.
echo OK, lets do that now.  I'll Wait...
echo.
timeout /t 5 /nobreak >nul
echo.
set /p var=Have you created and saved a backup of your configs??[y/n]:
if /I %var%== Y goto :start
if /I %var%== N goto :illwait

:start
echo.
echo GREAT! Lets go ahead and shut down the controller
echo.
timeout /t 1 /nobreak >nul
echo Hold on a second...
echo.
echo Im going to assume your controller is named "UniFi Network Application".  
echo If this isnt the case you will need to open the Script and change the service to the name of your controller at the top of the script.
pause
net stop %SRVVAR%
echo.
echo ok now we are going to uninstall the service...
echo. 
cd "%userprofile%\Ubiquiti UniFi\"
java -jar lib\ace.jar uninstallsvc

echo.
echo.
cls
set /p var=Have you downloaded the new controller[y/n]:
if /I %var%== Y goto :start1
if /I %var%== N goto :illwait1

:illwait1
echo.
echo OK, lets do that now.  I'll Wait...
echo.
timeout /t 5 /nobreak >nul
echo.
set /p var=Have you downloaded the new controller?[y/n]:
if /I %var%== Y goto :start1
if /I %var%== N goto :illwait1

:start1
echo.
echo Great! Please install it now...
echo.
echo Let me know when you're ready...
pause
echo.
echo Stopping to allow controller to finish...
timeout /t 5 /nobreak >nul 
echo.
echo If the controller is open please close it now.
pause

cls
echo.
echo reinstalling service...
cd "%UserProfile%\Ubiquiti UniFi\"
java -jar lib\ace.jar installsvc
echo.
timeout /t 2 /nobreak >nul
echo Waiting for install to finish
echo.
timeout /t 2 /nobreak >nul
echo starting Unifi Controller
net start %SRVVAR%
echo.
cls
REM del "%userprofile%\desktop\unifi.*" >nul
echo Getting rid of the evidence...
echo.
echo We're done here..bye bye

pause