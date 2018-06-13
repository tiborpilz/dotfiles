# Defaults
export EDITOR="vim"

# Path stuff
if [ -d "$HOME/.bin" ] ; then
	PATH="$HOME/.yarn/bin:$HOME/.bin:$PATH"
fi

PATH="$PATH:$(ruby -e 'print Gem.user_dir')/bin"
PATH="$PATH:$HOME/.local/bin"

# Load terminal colorscheme, if it exists
# if [ -f ~/.cache/wal/sequences ]; then
# 	(cat ~/.cache/wal/sequences &)
# fi

# if [ -f ~/.cache/wal/colors-tty.sh ]; then
# 	source ~/.cache/wal/colors-tty.sh
# fi

export PATH="/home/tibor/QuantumWise/VNL-ATK-2017.2/bin:$PATH"

export PATH="/home/tibor/QuantumWise/VNL-ATK-2017.2/bin:$PATH"

export PATH="/home/tibor/QuantumWise/VNL-ATK-2017.2/bin:$PATH"
