# Setup macOS Dock
defaults write com.apple.dock autohide-time-modifier -float 0.4
defaults write com.apple.dock autohide-delay -float 0
killall Dock

# Install homebrew
echo "📦 Installing Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"

# Install Programming Languages
echo "📦 Installing Programming Languages"
brew install fnm pyenv

# Install Utilities
echo "📦 Installing Utilities"
brew install bat fzf eza ripgrep tree zoxide zsh-autosuggestions zsh-syntax-highlighting starship neovim git pyenv-virtualenv tmux

# Install Database Client (PostgreSQL client tools: psql 등)
echo "📦 Installing Database Client"
brew install libpq

# Install Cask
echo "📦 Installing Applications"
brew install --cask font-fira-code-nerd-font font-d2coding-nerd-font orbstack google-chrome notion obsidian slack raycast wezterm chatgpt claude postman visual-studio-code cursor another-redis-desktop-manager beekeeper-studio

# Set hushlogin
touch ~/.hushlogin

# Set Fnm and yarn before .zsh setting
eval "$(fnm env --use-on-cd)"
fnm install --lts
fnm default lts-latest
npm install --global yarn

# Install Claude Code (공식 설치 스크립트, ~/.local/bin에 설치됨)
echo "📦 Installing Claude Code"
curl -fsSL https://claude.ai/install.sh | bash

# Install Bun (claude-mem 플러그인 실행에 필요, ~/.bun에 설치됨)
echo "📦 Installing Bun"
curl -fsSL https://bun.sh/install | bash
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Starship
mkdir -p ~/.config/starship
cp ~/Development/mac_init_setup/starship/starship.toml ~/.config/starship

# Wezterm
cp ~/Development/mac_init_setup/wezterm/wezterm.lua ~/.wezterm.lua

# tmux
cp ~/Development/mac_init_setup/tmux/tmux.conf ~/.tmux.conf

# nvim
mkdir -p ~/.config/nvim
cp ~/Development/mac_init_setup/nvim/init.lua ~/.config/nvim/init.lua

# Set .zshrc
rm ~/.zshrc
touch ~/.zshrc

ZSH_CONTENT=$(cat << 'EOF'
# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# PYENV
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

alias py="python"

# fnm
eval "$(fnm env --use-on-cd)"

# Yarn
export PATH="$PATH:$(yarn global bin)"

# Docker
alias dps='docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Status}}"'
alias dpsp='docker ps --format "table {{.Names}}\t{{.Ports}}"'

# custom alias
alias ls="eza --color=always --long --no-filesize --icons=always"
alias lsf="eza -alf --color=always --sort=size | grep -v /"
alias ld="eza -lD"
alias lf="eza -lf --color=always | grep -v /"
alias lh="eza -dl .* --group-directories-first"
alias ll="eza -al --group-directories-first"
alias lt="eza -al --sort=modified"
alias l="ll"

# Zoxide
eval "$(zoxide init zsh)"

# OrbStack command-line tools
source ~/.orbstack/shell/init.zsh 2>/dev/null || :

# zsh plugins
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Starship
eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/.config/starship/starship.toml

# FZF
if [ -n "$ZSH_VERSION" ]; then
  source <(fzf --zsh)
fi
export FZF_DEFAULT_OPTS="--preview 'bat --color=always {}'"

# git command custom
git() {
  if [[ $1 == "lg" ]]; then
    command git log --date=short --pretty=format:"%C(yellow)%h%Creset - %C(cyan)%an%Creset, %C(green)%ad%Creset : %C(magenta)%s%Creset %C(auto)%d%Creset"
  elif [[ $1 == "br" ]]; then
    command git branch "${@:2}"
  elif [[ $1 == "co" ]]; then
    command git checkout "${@:2}"
  elif [[ $1 == "st" ]]; then
    command git status
  else
    command git "$@"
  fi
}

# Claude code
export PATH="$HOME/.local/bin:$PATH"
alias claude-auto="claude --permission-mode auto"
alias claude-safe="claude"
alias claude-danger="claude --dangerously-skip-permissions"
alias claude-bypass="claude --permission-mode bypassPermissions"

# Bun (claude-mem 등에서 사용)
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# PostgreSQL
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
EOF
)

## .zshrc에 내용 추가
echo "$ZSH_CONTENT" >> ~/.zshrc
source ~/.zshrc

## 완료 메시지
echo "📦 Setting .zshrc Complete"
