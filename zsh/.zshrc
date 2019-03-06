source $HOME/.profile

# Add custom scripts to Path
PATH=$PATH:$HOME/bin

# Antigen Plugin Manager
source $HOME/.antigen/antigen.zsh
antigen use oh-my-zsh
antigen bundle git
antigen bundle bundler
antigen bundle vi-mode
antigen bundle history-substring-search
antigen apply

# Display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

source $HOME/.zsh_custom/themes/lnclt.zsh-theme

# Autocorrect
if ( type thefuck &> /dev/null ); then
	eval $(thefuck --alias)
fi

# Fix xon/xoff flow control
stty -ixon
