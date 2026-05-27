#!/usr/bin/env zsh
# =============================================================================
# init-dev-env.sh — macOS 开发环境初始化脚本
# 作者: liyulin
# 用法: zsh init-dev-env.sh
# =============================================================================

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

log()  { echo "${GREEN}[✓]${NC} $1"; }
info() { echo "${YELLOW}[…]${NC} $1"; }

# =============================================================================
# 1. Git 全局配置 — 禁用 Pager（防止 AI/脚本中终端卡住）
# =============================================================================
info "配置 Git pager..."
git config --global core.pager cat
git config --global pager.log    false
git config --global pager.diff   false
git config --global pager.show   false
git config --global pager.branch false
log "Git pager 已禁用"

# =============================================================================
# 2. Git 基础配置
# =============================================================================
info "配置 Git 基础信息..."
# git config --global user.name  "liyulin"       # 按需取消注释
# git config --global user.email "your@email.com" # 按需取消注释
git config --global init.defaultBranch main
git config --global pull.rebase true
git config --global fetch.prune true
git config --global rebase.autoStash true
log "Git 基础配置完成"

# =============================================================================
# 3. npm/npx 配置 — 自动确认安装（防止 AI/脚本中卡住）
# =============================================================================
info "配置 npm/npx..."
# npx 运行时如需下载包，自动确认（不等待 Y/n 交互提示）
npm config set yes true 2>/dev/null || true
log "npm 已配置 (yes=true)"

# =============================================================================
# 4. Shell 环境变量 — 写入 ~/.zshrc（幂等，重复运行安全）
# =============================================================================
ZSHRC="$HOME/.zshrc"
MARKER="# >>> init-dev-env managed block >>>"
MARKER_END="# <<< init-dev-env managed block <<<"

if grep -q "$MARKER" "$ZSHRC" 2>/dev/null; then
  info "更新 ~/.zshrc 托管块..."
  sed -i '' "/$MARKER/,/$MARKER_END/d" "$ZSHRC"
fi

info "向 ~/.zshrc 写入环境变量..."
cat >> "$ZSHRC" << 'ZSHBLOCK'

# >>> init-dev-env managed block >>>
# Disable pager — prevents terminal from hanging in non-interactive/AI sessions
export PAGER=cat
export GIT_PAGER=cat

# npm/npx — auto-confirm package installs (prevents hanging on Y/n prompt)
export npm_config_yes=true

# Better default for less (if ever used directly)
export LESS="-R --quit-if-one-screen"
# <<< init-dev-env managed block <<<
ZSHBLOCK
log "~/.zshrc 已更新"

# =============================================================================
# 5. 完成提示
# =============================================================================
echo ""
echo "════════════════════════════════════════"
log "初始化完成！请执行以下命令使配置立即生效："
echo "  source ~/.zshrc"
echo "════════════════════════════════════════"
