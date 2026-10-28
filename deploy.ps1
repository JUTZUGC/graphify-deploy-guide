# graphify 一键安装脚本（第三方指南）——按官方文档封装
# 官方文档：https://docs.graphify.com
# 更新日期：2026-10-28
# 类型：script
$ErrorActionPreference = 'Stop'
Set-Location -Path $PSScriptRoot

if (-not (Get-Command git -ErrorAction SilentlyContinue)) { throw '需要先安装 Git' }
if (-not (Get-Command python -ErrorAction SilentlyContinue)) { throw '需要先安装 Python 3' }

New-Item -ItemType Directory -Force -Path .download | Out-Null
Set-Location -Path .download

python -m venv .venv
.venv\Scripts\python.exe -m pip install graphifyy ; if ($LASTEXITCODE -ne 0) { throw '安装失败，请查看上面的输出' }
.venv\Scripts\graphify.exe install --platform trae
.venv\Scripts\graphify.exe install --platform trae-cn

Write-Host ''

Write-Host '安装完成：重启客户端，在项目目录里输入 /graphify . 生成图谱；产物在 graphify-out/graph.html'
Write-Host '若结果异常或需要改配置，请参考官方文档：https://docs.graphify.com'
