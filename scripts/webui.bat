@echo off
chcp 65001 >nul
echo ========================================
echo   法律文本理解与咨询系统 - WebUI
echo ========================================
echo.

cd /d "%~dp0.."

echo 启动 WebUI 界面...
llamafactory-cli webui
