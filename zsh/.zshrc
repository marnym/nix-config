autoload -U colors && colors

# History in cache directory
HISTSIZE=10000
SAVEHIST=10000
HISTFILE="$HOME/.cache/zsh/history"
setopt SHARE_HISTORY

autoload -U compinit
zstyle ":completion:*" menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

# Use vim keys in tab complete menu
bindkey -M menuselect "h" vi-backward-char
bindkey -M menuselect "k" vi-up-line-or-history
bindkey -M menuselect "l" vi-forward-char
bindkey -M menuselect "j" vi-down-line-or-history
bindkey "^e" end-of-line
bindkey -s "^o" ". ranger\n"


# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
 else
   export EDITOR='nvim'
 fi

alias ls="ls --color=auto"
alias zshconfig="nvim ~/.zshrc"
alias stow="stow --no-folding -vSt ~"
alias a="ansible"
alias k="kubectl"
alias p="project.sh"

case `uname` in
  Darwin)
    bindkey "^[^[[D" forward-word
    bindkey "^[^[[C" backward-word
    unsetopt correctall
    unsetopt nomatch
    set rtp+=/usr/local/opt/fzf

    export NVM_DIR=~/.nvm
    source $(brew --prefix nvm)/nvm.sh
    alias iso='echo "new Date().toISOString()" | deno | tail -1 | tr -d \" | sed -e $"s/\x1b\[[0-9;]*m//g" | pbcopy'
    export PATH="$PATH:/Applications/WezTerm.app/Contents/MacOS"
  ;;
  Linux)
    bindkey "^[[1;5C" forward-word
    bindkey "^[[1;5D" backward-word
    source /usr/share/nvm/init-nvm.sh
    export QT_QPA_PLATFORM=wayland
    export QT_STYLE_OVERRIDE=kvantum
    export CLUTTER_BACKEND=wayland
    export GDK_SCALE=1
  ;;
esac

[ -f $HOME/.fzf.zsh ] && source ~/.fzf.zsh

export PATH="$PATH:$HOME/.local/share/coursier/bin"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.deno/bin:$PATH"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$HOME/apps:$PATH"

export GOPATH=$HOME/go
export XDG_CONFIG_HOME=$HOME/.config

export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

source $HOME/.dotfiles/zsh/.zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOME/.dotfiles/zsh/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

eval "$(starship init zsh)"
