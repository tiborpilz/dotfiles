EDITOR="vim"

# Aliases
alias svim="sudo -E vim"
alias base64=gbase64
alias readlink=greadlink

# Disable beep
setopt NO_BEEP

# Check whether we're on a local session

if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ] || [ -n "$SSH_CONNECTION" ]; then
	SESSION_TYPE=remote/ssh
else
	case $(ps -o comm= -p $PPID) in
		sshd|/*sshd) SESSION_TYPE=remote/ssh;;
	esac
fi

# ???
export PATH="$PATH:/usr/local/bin"

# Scripts
export PATH="$PATH:$HOME/.bin"

# Rust
export PATH="$PATH:$HOME/.cargo/bin"

# Miniconda3
export PATH="$PATH:$HOME/miniconda3/bin"
export CONDA_USERNAME="tiborpilz"

# GO
export GOPATH="${HOME}/go"
export GOBIN="${GOPATH}/bin"
export PATH="${PATH}:${GOBIN}"

# Terraform
export PATH="${HOME}/.tfenv/bin:${PATH}"

export PATH="$HOME/.cargo/bin:$PATH"

# XServer Clipboard
alias xclip="xclip -selection c"
# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
  [ -s "$BASE16_SHELL/profile_helper.sh" ] &&
  eval "$("$BASE16_SHELL/profile_helper.sh")"
if [ -e /Users/tibor.pilz/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/tibor.pilz/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
