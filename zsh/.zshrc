# Oh-My-Zsh overrides
#ZSH_CUSTOM=$home/.zsh_custom
#ZSH_THEME="lnclt"

# Profile defaults
source $HOME/.profile

# Use Antigen
source $HOME/.antigen/antigen.zsh

# Oh-My-Zsh library
antigen use oh-my-zsh

# Various plugins from oh-my-zsh
antigen bundle git
antigen bundle bundler
antigen bundle vi-mode
antigen bundle history-substring-search

# Antigen done
antigen apply

# Display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

source $HOME/.zsh_custom/themes/lnclt.zsh-theme

# Autocorrect
if ( type thefuck &> /dev/null ); then
	eval $(thefuck --alias)
fi

#autoload -Uz compinit
#compinit
# Completion for kitty
#kitty + complete setup zsh | source /dev/stdin

# create a global per-pane variable that holds the pane's PWD
#export PS1=$PS1'$( [ -n $TMUX ] && tmux setenv -g TMUX_PWD_$(tmux display -p "#D" | tr -d %) $PWD)'
