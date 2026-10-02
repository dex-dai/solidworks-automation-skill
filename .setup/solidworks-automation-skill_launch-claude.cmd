@echo off
set "SKILL=%USERPROFILE%\.claude\skills\solidworks-automation-skill"
set "VENV=%SKILL%\.venv"
set "PY=%VENV%\Scripts\python.exe"
set "REQ=%SKILL%\requirements.txt"
set "PIP_REQUIRE_VIRTUALENV=1"

if not exist "%PY%" goto err_venv
"%PY%" -c "import sys" >nul
if errorlevel 1 goto err_venv
"%PY%" -m pip install --dry-run --no-index --disable-pip-version-check -q -r "%REQ%" >nul
if errorlevel 1 goto err_pkg
"%PY%" -c "import win32com.client, comtypes" >nul
if errorlevel 1 goto err_pkg

set "VIRTUAL_ENV=%VENV%"
set "PYTHONHOME="
set "PATH=%VENV%\Scripts;%PATH%"
pushd "%~dp0"
call claude
if errorlevel 1 goto err_claude
exit /b

:err_venv
echo [ERROR] VENV MISSING OR CANNOT START.
goto stop

:err_pkg
echo [ERROR] PACKAGES MISSING, OUTDATED OR BROKEN.
goto stop

:err_claude
echo [ERROR] CLAUDE EXITED WITH AN ERROR.

:stop
pause
exit /b 1