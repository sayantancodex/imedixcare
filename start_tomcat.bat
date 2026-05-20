@echo off
set "JRE_HOME=C:\Program Files\Java\jdk-17"
set "JAVA_HOME=C:\Program Files\Java\jdk-17"
set "PATH=%JAVA_HOME%\bin;%PATH%"

echo Starting Tomcat 11 with JDK 17...
cd /d "C:\Tomcat\bin"
call startup.bat

echo.
echo [INFO] Tomcat is starting in a new window.
echo [INFO] Once it's up, visit http://localhost:8080/imedixcare/
pause
