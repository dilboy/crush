# Crush Docker 部署

[Crush](https://github.com/charmbracelet/crush) 是一个终端 AI 编程助手，支持多种 LLM 提供商。

## 快速开始

### 1. 配置 API Key

复制环境变量模板并填入你的 API key：

```bash
cp .env.example .env
# 编辑 .env 文件，取消注释并填入你的 API key
```

### 2. 使用预构建镜像运行

```bash
docker compose up -d

# 交互式使用
docker compose run --rm crush
```

镜像会自动从 GitHub Container Registry 拉取：`ghcr.io/dilboy/crush:main`

## 目录结构

```
crush/
├── config/          # 配置文件目录 (持久化)
├── data/            # 数据目录 (持久化)
├── workspace/       # 工作目录 (你的代码)
├── docker-compose.yml
├── .env.example     # 环境变量模板
└── .github/workflows/docker.yml  # CI/CD 自动构建
```

## Unraid 部署

### 方法一：使用 docker-compose (推荐)

1. 将以下文件复制到 Unraid：
   - `docker-compose.yml`
   - `.env.example` (重命名为 `.env` 并填入 API key)
   - 创建 `config/`、`data/`、`workspace/` 目录

2. 运行：
```bash
docker compose up -d
```

### 方法二：使用 Unraid 模板

在 Unraid 的 Docker 页面添加容器：

- **Repository**: `ghcr.io/dilboy/crush:main`
- **Console**: `Interactive`
- **Volumes**:
  - `/mnt/user/appdata/crush/config:/root/.config/crush`
  - `/mnt/user/appdata/crush/data:/root/.local/share/crush`
  - `/mnt/user/your-code:/workspace`
- **Environment**:
  - `ANTHROPIC_API_KEY=your-key-here`

## 自动构建

每次推送到 `main` 分支或创建 `v*` tag 时，GitHub Actions 会自动构建并推送 Docker 镜像到：

```
ghcr.io/dilboy/crush:main       # main 分支最新
ghcr.io/dilboy/crush:v1.0.0     # 版本 tag
ghcr.io/dilboy/crush:sha-abc123 # commit SHA
```

## 支持的 LLM 提供商

| 环境变量 | 提供商 |
|---------|--------|
| `ANTHROPIC_API_KEY` | Anthropic (Claude) |
| `OPENAI_API_KEY` | OpenAI |
| `GEMINI_API_KEY` | Google Gemini |
| `GROQ_API_KEY` | Groq |
| `OPENROUTER_API_KEY` | OpenRouter |

完整列表见 [README](README.md)
