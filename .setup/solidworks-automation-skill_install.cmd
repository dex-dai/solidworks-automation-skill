@echo off
if not exist "%USERPROFILE%\.skills" mkdir "%USERPROFILE%\.skills"
cd /d "%USERPROFILE%\.skills"
git clone https://github.com/wzyn20051216/solidworks-automation-skill.git
cd /d "%USERPROFILE%\.skills\solidworks-automation-skill"
python -m venv .venv
.venv\Scripts\python.exe -m pip install --upgrade pip setuptools wheel
.venv\Scripts\python.exe -m pip install -r requirements.txt
pause