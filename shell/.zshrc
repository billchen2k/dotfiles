[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
export EDITOR='vim'
export ZSH_TMUX_UNICODE=true

# These files are synced with the dotfiles repo
source ~/.zshalias
source ~/.zshfunc

# These are local files.
source ~/.zshalias.local
source ~/.zshfunc.local
