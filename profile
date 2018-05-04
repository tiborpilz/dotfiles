# Defaults
export EDITOR="vim"

# Path stuff
if [ -d "$HOME/.bin" ] ; then
	PATH="$HOME/.yarn/bin:$HOME/.bin:$PATH"
fi

# Load terminal colorscheme, if it exists
# if [ -f ~/.cache/wal/sequences ]; then
# 	(cat ~/.cache/wal/sequences &)
# fi

# if [ -f ~/.cache/wal/colors-tty.sh ]; then
# 	source ~/.cache/wal/colors-tty.sh
# fi
