#!/bin/bash
# 法律文本理解与咨询系统 - 推理脚本 (Linux/Mac)

set -e

echo "========================================"
echo "  法律文本理解与咨询系统 - 推理脚本"
echo "========================================"
echo

cd "$(dirname "$0")/.."

echo "启动 WebChat 界面..."
llamafactory-cli webchat configs/inference_lora_sft.yaml
