# 开发环境初始化笔记

> 文件位置：`~/.dotfiles/docs/dev-setup-notes.md`
> 初始化脚本：`~/.dotfiles/scripts/init-dev-env.sh`

---

## 快速初始化（新机器 / 重装系统后）

```zsh
zsh ~/.dotfiles/scripts/init-dev-env.sh
source ~/.zshrc
```

---

## 问题 & 解决方案记录

### ⚠️ 终端命令卡住不退出（AI/脚本场景）

**现象**：执行 `git log`、`git diff` 等命令时，有输出但不退出，AI 一直等待，最终超时。

**根因**：git 默认使用 `less` 作为 pager，在非交互式终端中等待用户按 `q`。

**解决方案**：

```zsh
# 方式一：git 全局配置（推荐）
git config --global core.pager cat
git config --global pager.log    false
git config --global pager.diff   false
git config --global pager.show   false
git config --global pager.branch false

# 方式二：环境变量（写入 ~/.zshrc，覆盖所有工具）
export PAGER=cat
export GIT_PAGER=cat
```

**临时用法**（单次命令，不改配置）：
```zsh
git --no-pager log --oneline -10
git log --oneline -10 | cat
```

**验证配置**：
```zsh
git config --global --list | grep pager
```

---

## 最佳实践总结

### Git 命令

| 场景 | 推荐写法 |
|------|---------|
| 查看日志 | `git --no-pager log --oneline -N` |
| 查看差异 | `git --no-pager diff` |
| 查看分支 | `git --no-pager branch -v` |
| 配置了全局 cat | 直接用，无需 `--no-pager` |

### Shell 脚本 / AI 辅助开发

- 任何可能触发 pager 的命令，末尾加 `| cat`
- 或在脚本开头 `export PAGER=cat`
- `man` 命令：`man git | cat` 或 `MANPAGER=cat man git`

---

## dotfiles 目录结构

```
~/.dotfiles/
├── scripts/
│   └── init-dev-env.sh   # 一键初始化脚本
└── docs/
    └── dev-setup-notes.md  # 本文件
```

### 建议：纳入 Git 版本管理

```zsh
cd ~/.dotfiles
git init
git add .
git commit -m "init: dev environment setup"
# 推送到私有仓库备份
git remote add origin git@github.com:DinoStray/dotfiles.git
git push -u origin main
```

---

*最后更新：2026-05-16*

