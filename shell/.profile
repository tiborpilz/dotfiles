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
