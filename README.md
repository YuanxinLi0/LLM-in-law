# ⚖️ 法律文本理解与咨询系统 (Qwen-3B)

<div align="center">

**基于 Qwen2.5-3B 的垂直领域智能法律咨询平台**

[![Python](https://img.shields.io/badge/Python-3.8%2B-blue)](https://www.python.org/)
[![PyTorch](https://img.shields.io/badge/PyTorch-2.0%2B-orange)](https://pytorch.org/)
[![License](https://img.shields.io/badge/License-MIT-green)](LICENSE)

</div>

---

## 📋 项目简介

针对垂直领域智能问答需求，独立搭建交互式法律咨询平台。通过构建专有语料对 **Qwen2.5-3B** 进行微调，强化模型在法律场景下的上下文理解与流式响应能力。

## ✨ 项目亮点

### 🔧 数据清洗与语料构建
制定针对开源法律数据的去重及质量评估规则，产出 **20k 条高质量微调语料**，业务覆盖：
- 📜 民事法律
- ⚖️ 刑事法律  
- 💼 商事法律
- 👨‍👩‍👧‍👦 婚姻家庭
- 🏠 房产纠纷

### 🚀 模型优化与效果验证
应用 **LoRA 高效微调** Qwen2.5-3B，并引入**余弦退火学习率策略**：

| 指标 | 微调前 | 微调后 | 提升幅度 |
|:----:|:------:|:------:|:--------:|
| 困惑度 (PPL) | 2.9 | 2.1 | ↓ 27.6% |
| 指令遵循准确率 | 基准 | +37% | ↑ 37% |

### 💻 系统落地与前端交互
使用 **Gradio** 开发交互式 Web 咨询界面，打通多轮对话链路：
- ⚡ 平均响应延迟：**< 1.5 秒**
- 🔄 流式输出支持
- 📱 响应式界面设计

---

## 🏗️ 技术架构

```
┌─────────────────────────────────────────────────────────────────┐
│                        法律文本理解与咨询系统                       │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ┌──────────────┐    ┌──────────────┐    ┌──────────────┐      │
│  │   数据层      │    │   模型层      │    │   应用层      │      │
│  ├──────────────┤    ├──────────────┤    ├──────────────┤      │
│  │              │    │              │    │              │      │
│  │ DISC-Law-SFT │───▶│ Qwen2.5-3B   │───▶│   Gradio     │      │
│  │   20k语料     │    │   + LoRA     │    │   WebUI      │      │
│  │              │    │              │    │              │      │
│  └──────────────┘    └──────────────┘    └──────────────┘      │
│         │                   │                   │               │
│         ▼                   ▼                   ▼               │
│  ┌──────────────┐    ┌──────────────┐    ┌──────────────┐      │
│  │  数据预处理   │    │ LLaMA-Factory│    │   用户交互    │      │
│  │  质量评估     │    │   训练框架    │    │   多轮对话    │      │
│  └──────────────┘    └──────────────┘    └──────────────┘      │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

---

## 📁 目录结构

```
法律文本理解与咨询系统/
├── 📂 configs/                     # 配置文件
│   ├── train_lora_sft.yaml         # 训练配置
│   └── inference_lora_sft.yaml     # 推理配置
├── 📂 scripts/                     # 运行脚本
│   ├── preprocess_data.py          # 数据预处理
│   ├── train.bat / train.sh        # 训练脚本
│   ├── chat.bat / chat.sh          # 推理脚本
│   └── webui.bat                   # WebUI 启动
├── 📂 LLaMA-Factory/               # 训练框架
│   └── data/
│       ├── DISC_small.json         # 数据集
│       └── dataset_info.json       # 数据集配置
├── 📄 DISC-Law-SFT-Pair-QA-released.jsonl  # 原始数据
├── 📊 train loss.png               # 训练损失曲线
└── 📖 README.md
```

---

## 📊 训练效果

### Loss 曲线

<div align="center">
<img src="train loss.png" alt="训练损失曲线" width="700">

*训练损失曲线：蓝色曲线为 A800 训练结果，暗红色为 A10 训练结果*
</div>

### 关键指标

```
📈 训练配置
├── 基座模型: Qwen2.5-3B-Instruct
├── 微调方式: LoRA (rank=8)
├── 学习率策略: Cosine Annealing
├── 训练轮数: 3 epochs
└── 批次大小: 16 (4 × 4)
```

---

## 🚀 快速开始

### 1️⃣ 克隆项目

```bash
git clone https://github.com/YuanxinLi0/LLM-in-law.git
cd LLM-in-law
```

### 2️⃣ 安装依赖

```bash
# 安装 LLaMA Factory
cd LLaMA-Factory
pip install -e ".[torch,metrics]"
cd ..

# 安装 Gradio（用于 Web 界面）
pip install gradio
```

### 3️⃣ 下载模型

```bash
# 使用 ModelScope 下载
modelscope download --model Qwen/Qwen2.5-3B-Instruct --local_dir qwen2.5-3b-instruct
```

### 4️⃣ 开始训练

```bash
# Windows
scripts\train.bat

# Linux/Mac
bash scripts/train.sh
```

### 5️⃣ 启动服务

```bash
# 启动 WebUI
llamafactory-cli webui

# 或启动对话界面
llamafactory-cli webchat configs/inference_lora_sft.yaml
```

---

## ⚙️ 配置说明

### 训练超参数

| 参数 | 值 | 说明 |
|:-----|:---|:-----|
| `model_name_or_path` | qwen2.5-3b-instruct | 模型路径 |
| `finetuning_type` | lora | 微调方式 |
| `lora_rank` | 8 | LoRA 秩 |
| `lora_target` | all | 目标模块 |
| `learning_rate` | 1.0e-4 | 学习率 |
| `num_train_epochs` | 3.0 | 训练轮数 |
| `lr_scheduler_type` | cosine | 余弦退火 |
| `warmup_ratio` | 0.1 | 预热比例 |
| `bf16` | true | 混合精度 |

---

## 💡 效果展示

### 法律问答示例

```
👤 用户: 违章停车与违法停车是否有区别？

🤖 助手: 对违反道路交通安全法律、法规关于机动车停放、临时停车规定的，
可以指出违法行为，并予以口头警告，令其立即驶离。机动车驾驶人不在现场
或者虽在现场但拒绝立即驶离，妨碍其他车辆、行人通行的处二十元以上二百元
以下罚款。现在人们大多是称作违法停车，因此在法律责任上也会更多一些...
```

```
👤 用户: 诈骗罪量刑标准是什么?

🤖 助手: 诈骗罪指的是以非法占有为目的，使用欺骗方法，骗取数额较大的
公私财物的行为。根据《刑法》第二百六十六条的规定，诈骗公私财物，数额
较大的，处三年以下有期徒刑、拘役或者管制，并处或者单处罚金...
```

---

## 🔗 资源链接

| 资源 | 链接 |
|:-----|:-----|
| 📊 数据集 | [DISC-Law-SFT](https://huggingface.co/datasets/ShengbinYue/DISC-Law-SFT) |
| 🛠️ 训练框架 | [LLaMA-Factory](https://github.com/hiyouga/LLaMA-Factory) |
| 🤖 基座模型 | [Qwen2.5-3B-Instruct](https://modelscope.cn/models/Qwen/Qwen2.5-3B-Instruct) |

---

## 📄 许可证

本项目仅供学习研究使用，请遵守相关数据集和模型的使用协议。

---

<div align="center">

**⭐ 如果这个项目对你有帮助，欢迎 Star! ⭐**

</div>