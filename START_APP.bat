@echo off
chcp 65001 >nul
cd /d "%~dp0"
echo Starting SAMOOTSENKO Application...
python run_offline.py
pause
