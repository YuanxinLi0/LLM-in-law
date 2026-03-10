#!/bin/bash
# 法律文本理解与咨询系统 - 训练脚本 (Linux/Mac)

set -e

echo "========================================"
echo "  法律文本理解与咨询系统 - 训练脚本"
echo "========================================"
echo

cd "$(dirname "$0")/.."

echo "[1/2] 检查环境..."
if ! pip show llamafactory > /dev/null 2>&1; then
    echo "正在安装 LLaMA Factory..."
    pip install -e "LLaMA-Factory[torch,metrics]"
fi

echo
echo "[2/2] 开始训练..."
llamafactory-cli train configs/train_lora_sft.yaml

echo
echo "训练完成！"
