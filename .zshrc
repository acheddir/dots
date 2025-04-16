# Add deno completions to search path
if [[ ":$FPATH:" != *":/home/acheddir/.zsh/completions:"* ]]; then export FPATH="/home/acheddir/.zsh/completions:$FPATH"; fi
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

# Set the GPG_TTY to be the same the TTY, either via the env var
# or via the tty command.
if [ -n "$TTY" ]; then
  export GPG_TTY=$(tty)
else
  export GPG_TTY="$TTY"
fi

# You may need to manually set your language environment
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
	mkdir -p "$(dirname $ZINIT_HOME)"
	git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in Powerlevel10k
# zinit ice depth=1; zinit light romkatv/powerlevel10k
# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::azure
zinit snippet OMZP::command-not-found

# Load completions
autoload -U compinit && compinit

zinit cdreplay -q

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Oh-my-posh
eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/omp.toml)"

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview "ls --color $realpath"
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview "ls --color $realpath"

# Aliases
alias ls="lsd"
alias l="lsd -l"
alias ll="lsd -l --git"
alias la="lsd -l --all --git"
alias c='clear'
alias cat='bat'
alias d='docker'
alias vi='nvim'
alias vim='nvim'
alias ompu='sudo oh-my-posh upgrade'

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

# fnm
FNM_PATH="/home/acheddir/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="/home/acheddir/.local/share/fnm:$PATH"
  eval "`fnm env`"
fi

# dotnet
export DOTNET_ROOT=$HOME/.dotnet
export PATH=$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# go
# export GOPATH=$HOME/.go
# export PATH=$PATH:$GOPATH/bin
export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"
eval "$(goenv init -)"
export PATH="$GOENV_ROOT/shims:$PATH" 

export GPG_TTY=$(tty)
eval "$(ssh-agent -s)" > /dev/null 2>&1
ssh-add ~/.ssh/github_id_ed25519 > /dev/null 2>&1
ssh-add ~/.ssh/azure_devops_rsa> /dev/null 2>&1

. "/home/acheddir/.deno/env"

# Load Angular CLI autocompletion.
source <(ng completion script)

# Exclude /mnt/c executables from PATH
# export PATH=`echo $PATH | tr ':' '\n' | awk '($0!~/mnt\/c/) {print} ' | tr '\n' ':'`

# pnpm
export PNPM_HOME="/home/acheddir/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

