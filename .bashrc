# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions

__git_ps1 () 
{ 
    local b="$(git symbolic-ref HEAD 2>/dev/null)";
    if [ -n "$b" ]; then
        printf " (%s)" "${b##refs/heads/}";
    fi
}

function __git_dirty {
  git diff --quiet HEAD &>/dev/null 
  [ $? == 1 ] && echo "!"
}

function __ocm_env {
  local e="$(ocm config get url 2>/dev/null)";
  case $e in
    "https://api.openshift.com")
      echo "P"
    ;;
    "https://api.stage.openshift.com")
      echo "S"
    ;;
    "https://api.integration.openshift.com")
      echo "I"
    ;;
    "http://localhost:9000")
      echo "L"
    ;;
    *)
    echo "?"
  esac
}

function __git_branch {
  __git_ps1 " %s"
}

bash_prompt() {
  local NONE="\[\033[0m\]"    # unsets color to term's fg color

  # regular colors
  local K="\[\033[0;30m\]"    # black
  local R="\[\033[0;31m\]"    # red
  local G="\[\033[0;32m\]"    # green
  local Y="\[\033[0;33m\]"    # yellow
  local B="\[\033[0;34m\]"    # blue
  local M="\[\033[0;35m\]"    # magenta
  local C="\[\033[0;36m\]"    # cyan
  local W="\[\033[0;37m\]"    # white

  # emphasized (bolded) colors
  local EMK="\[\033[1;30m\]"
  local EMR="\[\033[1;31m\]"
  local EMG="\[\033[1;32m\]"
  local EMY="\[\033[1;33m\]"
  local EMB="\[\033[1;34m\]"
  local EMM="\[\033[1;35m\]"
  local EMC="\[\033[1;36m\]"
  local EMW="\[\033[1;37m\]"

  # background colors
  local BGK="\[\033[40m\]"
  local BGR="\[\033[41m\]"
  local BGG="\[\033[42m\]"
  local BGY="\[\033[43m\]"
  local BGB="\[\033[44m\]"
  local BGM="\[\033[45m\]"
  local BGC="\[\033[46m\]"
  local BGW="\[\033[47m\]"

  local UC=$W                 # user's color
  [ $UID -eq "0" ] && UC=$R   # root's color

  PS1="$EMY\w$EMW\$(__git_branch)$EMY\$(__git_dirty) $EMR\$(__ocm_env)$NONE $ "
}

bash_prompt
unset bash_prompt
alias g='git'
alias gi='git'
alias ocm-local='ocm config set url http://localhost:9000'
alias ocm-int='ocm config set url https://api.integration.openshift.com'
alias ocm-stage='ocm config set url https://api.stage.openshift.com'
alias ocm-prod='ocm config set url https://api.openshift.com'

stty -ixon

eval "$(direnv hook bash)"

