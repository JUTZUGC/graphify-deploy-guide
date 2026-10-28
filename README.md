# graphify 一键安装指南

> 第三方部署指南 · 非 graphify 官方仓库。官方项目：[Graphify-Labs/graphify](https://github.com/Graphify-Labs/graphify)
> 内容来自官方文档（2026-10-28）。项目迭代快，请以[官方文档](https://docs.graphify.com)为准。

[![⚡ 一键安装](https://img.shields.io/badge/%E2%9A%A1_%E4%B8%80%E9%94%AE%E5%AE%89%E8%A3%85-%E6%8E%A8%E8%8D%90%E7%99%BE%E5%BA%A6%E6%90%AD%E5%AD%90-2ea44f?style=for-the-badge)](#一键安装推荐用百度搭子)

## 一键安装（推荐：用百度搭子）

> [!TIP]
> 不用自己拆代码结构，让百度搭子装好技能，之后一句 `/graphify .` 就把项目变成图谱。

⚠️ 需要 Python 3.10+。装的是命令行工具 + 一个 `/graphify` 技能，没有独立网页界面；生成的 `graph.html` 是本地文件，用浏览器打开。

1. **装客户端**
   打开[百度搭子官网](https://www.dumate.cn/)，下载电脑端并安装，用你的账号登录。

> [!IMPORTANT]
> **复制这一句发给百度搭子：**
>
> ```text
> 你好，帮我从 github 部署 JUTZUGC/graphify-deploy-guide 到我的电脑上
> ```

2. **发送部署指令**
   回到刚打开的对话窗口，粘贴并发送上面那句。

3. **跟着对话往下走**
   百度搭子会建好 Python 环境、装好 graphify，再把它注册成 Trae / Trae CN 的技能，按它的提示确认即可，结束时它会告诉你结果。
   （需本机已装 Git；构建依赖以官方文档为准。）



## graphify 是什么？

graphify 是开源的把代码库变成可查询知识图谱的 Agent 技能（协议：Apache-2.0，<img src="https://img.shields.io/github/stars/Graphify-Labs/graphify?style=flat-square&label=stars&color=blue" alt="GitHub stars">）。

把代码库、文档、SQL schema、配置与 PDF 解析成一张可交互的知识图谱：本地 AST 解析、每条边都有解释、不用向量库，产出可在浏览器里点击搜索的 graph.html。

- 输入：约 40 种语言的源码，加上文档、PDF、图片、音视频（可选语义通道）
- 输出：graph.html，可点击、可搜索、按社区着色
- 两种用法：助手里的 `/graphify .`，或命令行
- 安装：`pip install graphifyy` 后 `graphify install` 自动注册技能

（来源：[官方仓库](https://github.com/Graphify-Labs/graphify)）

## 优缺点

| 优点 | 说明 |
|---|---|
| 137.3k stars | Apache-2.0 开源，热度很高 |
| 本地解析 | tree-sitter AST，代码不外传 |
| 不用向量库 | 每条边有解释，结果可追溯 |
| 一键注册 | `graphify install` 自动适配 20+ 客户端 |
| 产物直观 | graph.html 可点击、可搜索 |

| 需要注意 | 说明 |
|---|---|
| 需要 Python 3.10+ | 版本不够会装不上 |
| 大仓库耗时长 | AST 解析 + 聚类可能跑很久 |
| 技能版依赖客户端 | 没有客户端就只剩命令行 |
| 非代码文件靠可选通道 | PDF / 图片要额外配置语义解析 |
| 图谱不等于理解 | 还需要自己按图去读代码 |

> 以上基于官方文档与社区反馈整理（2026-10-28），以官方最新文档为准。

## 快速部署（官方方式）

```bash
python3 -m venv .venv
.venv/bin/pip install graphifyy
.venv/bin/graphify install --platform trae
.venv/bin/graphify install --platform trae-cn
```

部署步骤来源：[https://github.com/Graphify-Labs/graphify#get-started](https://github.com/Graphify-Labs/graphify#get-started)

## 验证状态

| 场景 | 状态 |
|---|---|
| venv 安装 graphifyy 成功，graphify --help 正常输出 | 已验证 2026-10-26 |
| graphify install --platform trae 写入 ~/.trae/skills/graphify/SKILL.md | 已验证 2026-10-26 |
| MCP 服务握手与工具列表（initialize / tools/list） | 已验证 2026-10-26 |
| 非目标宿主调用被拦截（HOST_NOT_ALLOWED） | 已验证 2026-10-26 |

> 本表仅列出已在本机实际执行并成功的场景；未列出的部分按官方文档整理。

## MCP 接入

它不是 MCP server，而是把 `/graphify` 技能注册到你已有的编码助手里。本仓库的 MCP 只提供安装步骤与常见坑。

本仓库自带一个零依赖的 MCP server（`mcp-server.mjs`），读取同目录的 `guide.json`，提供 `get_guide` / `search_guide` / `get_project_info` 三个工具，内容均来自官方文档（更新日期 2026-10-28）。

**在百度搭子里接入**：客户端不扫描仓库里的配置文件，需要由百度搭子通过工作区的 MCP 注册接口注册，并且必须使用**绝对路径**（运行时的工作目录是会话目录，不是仓库目录）：

```json
{
  "type": "local",
  "command": ["node", "<仓库绝对路径>/mcp-server.mjs"]
}
```

完成后，直接在同一个对话框里说：

> 把仓库克隆到固定目录（例如 C:\Users\<你>\graphify-deploy-guide），再用绝对路径把里面的 mcp-server.mjs 注册到当前工作区的 MCP 配置里

> 注意：注册是按**工作区**生效的，换工作区要重新注册；克隆目录不要放在会话临时目录，否则目录被清理后注册项会失效。

**其它 MCP 客户端**：仓库根目录的 `.mcp.json` 只是通用写法（`command` + `args`），接入时同样要把 `args` 改成绝对路径。

> 使用范围：该 MCP 仅在百度搭子中可用；其它客户端调用会返回 `HOST_NOT_ALLOWED`，并附带下载与部署指引。

## 安装完成后：怎么用

在客户端里（先把工作目录切到项目根目录）：

```text
/graphify .
```

生成物在 `graphify-out/`：

- `graph.html`：浏览器打开，点节点看关系
- `graph.json`：原始图谱数据

增量与调整：

```text
/graphify ./docs --update          # 只重新抽取改过的文件
/graphify . --cluster-only         # 只重跑聚类
```

> 想装到单个项目而不是全局：`graphify install --project`；想指定其它客户端：`--platform codex` 之类的参数。

## 常见坑

- Python 版本不够：需要 3.10+，先 `python --version` 确认
- 命令找不到：装在 `.venv` 里，先激活或用全路径
- 注册到了错误的客户端：`graphify install --platform <名字>` 指定，`graphify uninstall` 可撤回
- 只想给当前项目装：用 `--project`，别污染全局
- 大仓库第一次很慢：先用 `--update` 增量跑，或只对子目录建图
- PDF / 图片解析不出来：语义通道是可选能力，要按官方文档单独准备
- 生成的 `graphify-out/` 别提交进仓库，按需加进 `.gitignore`

## 免责声明

本仓库为第三方指南，与 graphify 官方无隶属关系，不代表官方立场。
教程基于官方文档编写（更新日期：2026-10-28），项目迭代快，请以[官方文档](https://docs.graphify.com)为准。
因使用本教程产生的部署问题，请先在官方仓库的 issue 中检索。
