# dotfiles

我的开发环境配置，一键初始化新机器。

## 目录结构

```
~/.dotfiles/
├── scripts/
│   └── init-dev-env.sh     # 一键初始化脚本
└── docs/
    └── dev-setup-notes.md  # 问题记录 & 最佳实践
```

## 快速开始

```zsh
git clone git@github.com:DinoStray/dotfiles.git ~/.dotfiles
zsh ~/.dotfiles/scripts/init-dev-env.sh
source ~/.zshrc
```

## 包含配置

| 配置项 | 说明 |
|--------|------|
| `core.pager=cat` | 禁用 git pager，防止终端卡住 |
| `pager.log/diff/show/branch=false` | 各 git 子命令独立禁用 pager |
| `pull.rebase=true` | pull 时默认使用 rebase |
| `fetch.prune=true` | fetch 时自动清理已删除的远程分支 |
| `rebase.autoStash=true` | rebase 前自动 stash 本地改动 |
| `init.defaultBranch=main` | 默认分支名为 main |
| `PAGER=cat` | 全局禁用 pager（写入 ~/.zshrc） |
| `GIT_PAGER=cat` | git 专用 pager 环境变量 |

