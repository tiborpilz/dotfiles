EDITOR="vim"

# Aliases
alias svim="sudo -E vim"

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
