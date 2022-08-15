########################################
# ALIASES
########################################
alias paci="yay -Sy --needed --noconfirm"
alias pacup="yay -Syu --needed --noconfirm"
alias pacrem="yay -Rsn"
alias pacsearch="yay -Ss"

#Configs
alias zconf="nvim ~/.zshrc && source ~/.zshrc"


########################################
# TERMINAL CONFIG
########################################
USE_POWERLINE="true"
HYPHEN_INSENSITIVE="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
zstyle ':omz:update' mode auto      # update automatically without asking

export ZSH="~/.oh-my-zsh"
ZSH_THEME="spaceship"

plugins=(git) # Standard plugins can be found in $ZSH/plugins/

source $ZSH/oh-my-zsh.sh

########################################
# GIT
########################################
source /usr/share/doc/git-extras/git-extras-completion.zsh


########################################
# Configs
########################################

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
  export VISUAL="vim"
else
  export EDITOR='nvim'
  export VISUAL="nvim"
fi

#######
# NVM
#######

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] \
  && printf %s "${HOME}/.nvm" \
  || printf %s "${XDG_CONFIG_HOME}/nvm")"

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm% 


