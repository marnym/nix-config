# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
 else
   export EDITOR='nvim'
 fi

set -o emacs

alias zshconfig="nvim ~/.zshrc"
alias stow="stow --no-folding -vSt ~"
alias a="ansible"
alias k="kubectl"

case `uname` in
  Darwin)
    unsetopt correctall
    unsetopt nomatch
    set rtp+=/usr/local/opt/fzf

    export NVM_DIR=~/.nvm
    source $(brew --prefix nvm)/nvm.sh
  ;;
  Linux)
    source /usr/share/nvm/init-nvm.sh
  ;;
esac

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[ -f $HOME/.p10k.zsh ] && source ~/.p10k.zsh
[ -f $HOME/.fzf.zsh ] && source ~/.fzf.zsh

autoload -Uz compinit && compinit

export PATH="$PATH:$HOME/.local/share/coursier/bin"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.deno/bin:$PATH"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

export GOPATH=$HOME/go
export XDG_CONFIG_HOME=$HOME/.config

export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

source $HOME/.dotfiles/zsh/.zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOME/.dotfiles/zsh/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $HOME/.dotfiles/zsh/.powerlevel10k/powerlevel10k.zsh-theme
