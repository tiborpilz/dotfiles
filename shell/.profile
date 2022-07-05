EDITOR="vim"

# Aliases
alias svim="sudo -E vim"

if command -v gbase64 &> /dev/null
then
  alias base64=gbase64
fi

if command -v greadlink &> /dev/null
then
   alias readlink=greadlink
fi

if command -v gfind &> /dev/null
then
  alias find=gfind
fi

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

if [ -e /home/tibor/.nix-profile/etc/profile.d/nix.sh ]; then . /home/tibor/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
PATH="$(bash -ec 'IFS=:; paths=($PATH); for i in ${!paths[@]}; do if [[ ${paths[i]} == "'/home/tibor/.pyenv/shims'" ]]; then unset '\''paths[i]'\''; fi; done; echo "${paths[*]}"')"
export PATH="/home/tibor/.pyenv/shims:${PATH}"
export PYENV_SHELL=zsh
command pyenv rehash 2>/dev/null
pyenv() {
  local command
  command="${1:-}"
  if [ "$#" -gt 0 ]; then
    shift
  fi

  case "$command" in
  rehash|shell)
    eval "$(pyenv "sh-$command" "$@")"
    ;;
  *)
    command pyenv "$command" "$@"
    ;;
  esac
}
