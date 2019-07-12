source $HOME/.profile

# Add custom scripts to Path
PATH=$PATH:$HOME/bin

PATH=$PATH:$HOME/.npm-global/bin

PATH=$PATH:$HOME/go/bin

# Node Version Manager
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion


# Antige nPlugin Manager
source $HOME/.antigen/antigen.zsh

antigen use oh-my-zsh

# Touchbar goodies
antigen theme https://github.com/iam4x/zsh-iterm-touchbar

antigen bundle bundler
antigen bundle vi-mode
antigen bundle history-substring-search

antigen bundle wfxr/forgit
antigen bundle git

antigen bundle soimort/translate-shell

# Colorful stuff
antigen bundle zsh-users/zsh-syntax-highlighting

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

# Functions
python-init() {

# Init python venv in current dir if no argument given
projectPath=${PWD##*/}

if [ -n "$1" ]
then
  echo "$1"
  export project="$1"
  mkdir "$1"
else
  export project=${PWD##*/}
fi

export projectPath="./${project}"

# Create .venv folder with project folder name as prompt
python -m venv "$projectPath/.venv" --prompt "$project"
source "${projectPath}/.venv/bin/activate"

# Activate venv and instal kernelspec for jupyter
pip install ipykernel
python -m ipykernel install --user --name "$project"
pip install jupyter
}
export TAICHI_NUM_THREADS=8
export TAICHI_REPO_DIR=/home/tibor/Code/taichi
export PYTHONPATH=$TAICHI_REPO_DIR/python/:$PYTHONPATH
export PATH=$TAICHI_REPO_DIR/bin/:$PATH
export PATH="/usr/local/sbin:$PATH"
