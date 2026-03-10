@echo off
chcp 65001 >nul
echo ========================================
echo   法律文本理解与咨询系统 - 训练脚本
echo ========================================
echo.

cd /d "%~dp0.."

echo [1/2] 检查环境...
pip show llamafactory >nul 2>&1
if errorlevel 1 (
    echo 正在安装 LLaMA Factory...
    pip install -e "LLaMA-Factory[torch,metrics]"
)

echo.
echo [2/2] 开始训练...
llamafactory-cli train configs/train_lora_sft.yaml

echo.
echo 训练完成！
pause
