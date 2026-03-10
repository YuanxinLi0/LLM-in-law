#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
数据预处理脚本
从 DISC-Law-SFT-Pair-QA-released.jsonl 提取指定数量的数据
"""

import json
import argparse


def preprocess_data(input_file: str, output_file: str, num_samples: int):
    """
    从原始数据集提取指定数量的样本
    
    Args:
        input_file: 输入文件路径
        output_file: 输出文件路径
        num_samples: 提取的样本数量
    """
    json_objects = []
    
    with open(input_file, 'r', encoding='utf-8') as f:
        for i, line in enumerate(f):
            if i >= num_samples:
                break
            json_objects.append(json.loads(line))
    
    with open(output_file, 'w', encoding='utf-8') as f:
        json.dump(json_objects, f, indent=4, ensure_ascii=False)
    
    print(f"成功提取 {len(json_objects)} 条数据到 {output_file}")


def main():
    parser = argparse.ArgumentParser(description='法律问答数据预处理')
    parser.add_argument('--input', type=str, default='DISC-Law-SFT-Pair-QA-released.jsonl',
                        help='输入文件路径')
    parser.add_argument('--output', type=str, default='DISC_small.json',
                        help='输出文件路径')
    parser.add_argument('--num_samples', type=int, default=8000,
                        help='提取的样本数量')
    
    args = parser.parse_args()
    preprocess_data(args.input, args.output, args.num_samples)


if __name__ == '__main__':
    main()
