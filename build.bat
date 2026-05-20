@echo off
set "JAVA_HOME=C:\Program Files\Java\jdk-17"
set "PATH=%JAVA_HOME%\bin;C:\ProgramData\chocolatey\lib\maven\apache-maven-3.9.15\bin;%PATH%"

echo Building iMediXCare ERP...
call mvn clean package

if %ERRORLEVEL% EQU 0 (
    echo.
    echo [SUCCESS] Build completed!
    echo [INFO] Your file is here: D:\productions\internship\target\imedixcare.war
    echo [INFO] Copy it to C:\Tomcat\webapps to deploy.
) else (
    echo.
    echo [ERROR] Build failed. Please check the logs above.
)
pause
