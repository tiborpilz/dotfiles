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

# Aliasesses/Functions
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
