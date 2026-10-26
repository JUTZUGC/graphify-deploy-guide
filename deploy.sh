#!/usr/bin/env bash
set -euo pipefail
# graphify 一键安装脚本（第三方指南）——按官方文档封装
# 官方文档：https://docs.graphify.com
# 更新日期：2026-10-26
# 类型：script
cd "$(dirname "${BASH_SOURCE[0]}")"

command -v git >/dev/null 2>&1 || { echo "需要先安装 Git"; exit 1; }
command -v python3 >/dev/null 2>&1 || command -v python >/dev/null 2>&1 || { echo "需要先安装 Python 3"; exit 1; }

mkdir -p .download
cd .download

python3 -m venv .venv
.venv/bin/pip install graphifyy
.venv/bin/graphify install --platform trae
.venv/bin/graphify install --platform trae-cn

echo ""

echo "安装完成：重启客户端，在项目目录里输入 /graphify . 生成图谱；产物在 graphify-out/graph.html"
echo "若结果异常或需要改配置，请参考官方文档：https://docs.graphify.com"
