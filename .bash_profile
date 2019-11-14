# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

PATH=$PATH:$HOME/bin

export PATH

source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
