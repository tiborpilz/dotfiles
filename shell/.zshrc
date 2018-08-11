# Profile defaults
source $HOME/.profile

# FZF config
export FZF_DEFAULT_COMMANG='rg --files --no-ignore --hidden --follow --glob "!.git/*'

# Use Antigen
source $HOME/.antigen/antigen.zsh

# Oh-My-Zsh library
antigen use oh-my-zsh

# Various plugins
antigen bundle git
antigen bundle bundler
antigen bundle vi-mode
antigen bundle history-substring-search
antigen bundle virtualenv
antigen bundle rake
antigen bundle rbenv
antigen bundle ruby
antigen bundle tmuxinator
antigen bundle thefuck

antigen bundle lukechilds/zsh-nvm

# Other themes
antigen theme robbyrussell

# Antigen done
antigen apply


# Command auto-correction.
# ENABLE_CORRECTION="true"

# Display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Disable marking untracked files under VCS as dirty.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Aliases
alias svim="sudo -E vim"

# Disable beep
setopt NO_BEEP
