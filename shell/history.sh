export HISTSIZE=1000000
export SAVEHIST=$HISTSIZE
if [ -n "$ZSH_NAME" ]; then
	export HISTFILE=$HOME/.zsh_history
	setopt inc_append_history
else
	export HISTFILE="$HOME/.history"
fi
