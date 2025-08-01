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
brew install openjdk@21 go fnm python3

# Create OpenJDK symbolic link
echo "📦 Creating OpenJDK symbolic link"
sudo ln -sfn $(brew --prefix)/opt/openjdk@21/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk-21.jdk

# Install Utilities
echo "📦 Installing Utilities"
brew install bat fzf eza fastfetch portal ripgrep thefuck tree zoxide zsh-autosuggestions zsh-syntax-highlighting starship neovim gitmoji dry git

# Install Cask
echo "📦 Installing Applications"
brew install --cask font-fira-code-nerd-font orbstack google-chrome notion slack raycast wezterm chatgpt postman visual-studio-code cursor webstorm intellij-idea termius another-redis-desktop-manager beekeeper-studio

# Set hushlogin
touch ~/.hushlogin

# Set Fnm and yarn before .zsh setting
eval "$(fnm env --use-on-cd)"
fnm install 20.17.0
npm install --global yarn

# FastFetch
mkdir -p ~/.config/fastfetch
cp ~/Development/mac_init_setup/fastfetch/config.jsonc ~/.config/fastfetch
cp ~/Development/mac_init_setup/fastfetch/ascii.txt ~/.config/fastfetch

# Starship
mkdir -p ~/.config/starship
cp ~/Development/mac_init_setup/starship/starship.toml ~/.config/starship

# Wezterm
cp ~/Development/mac_init_setup/wezterm/wezterm.lua ~/.wezterm.lua

# Set .zshrc
rm ~/.zshrc
touch ~/.zshrc

ZSH_CONTENT=$(cat << 'EOF'
# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Java
export JAVA_HOME=$(/usr/libexec/java_home)
export PATH="/opt/homebrew/opt/openjdk@21/bin:$PATH"

# Python
export PATH="/opt/homebrew/opt/python@3/libexec/bin:$PATH"
alias py="python3"
alias pip="pip3"

# fnm
eval "$(fnm env --use-on-cd)"

# Yarn
export PATH="$PATH:$(yarn global bin)"

# Docker
alias dps='docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Status}}"'
alias dpsp='docker ps --format "table {{.Names}}\t{{.Ports}}"'

# the Fuck
eval $(thefuck --alias fuck)

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

fastfetch
EOF
)

## .zshrc에 내용 추가
echo "$ZSH_CONTENT" >> ~/.zshrc
source ~/.zshrc

## 완료 메시지
echo "📦 Setting .zshrc Complete"
