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
antigen bundle thefuck
antigen bundle history-substring-search

# Themes
antigen theme minimal

# Antigen done
antigen apply

# Display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Disable marking untracked files under VCS as dirty.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

eval $(thefuck --alias)
