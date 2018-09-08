# Defaults
export EDITOR="vim"

# Path stuff
if [ -d "$HOME/.bin" ] ; then
	PATH="$HOME/.yarn/bin:$HOME/.bin:$PATH"
fi

# Ruby
PATH="$PATH:$(ruby -e 'print Gem.user_dir')/bin"
PATH="$PATH:$HOME/.local/bin"

# Anaconda
PATH="$PATH:/opt/anaconda/bin"

# ogs
PATH="$PATH:/opt/ogs6/bin"

export TERM=rxvt
