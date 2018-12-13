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

antigen theme minimal
# Antigen done
antigen apply

# Display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

source $HOME/.zsh_custom/themes/lnclt.zsh-theme

# I'm not using the antigen/oh-my-zsh thefuck plugin because I don't want to
# be nagged on systems where 'thefuck' isn't installed.
if ( type thefuck &> /dev/null ); then
	eval $(thefuck --alias)
fi
