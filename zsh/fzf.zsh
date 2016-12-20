# Setup fzf
# ---------
if [[ ! "$PATH" == */usr/local/Cellar/fzf/0.15.9/bin* ]]; then
  export PATH="$PATH:/usr/local/Cellar/fzf/0.15.9/bin"
fi

# Man path
# --------
if [[ ! "$MANPATH" == */usr/local/Cellar/fzf/0.15.9/man* && -d "/usr/local/Cellar/fzf/0.15.9/man" ]]; then
  export MANPATH="$MANPATH:/usr/local/Cellar/fzf/0.15.9/man"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/usr/local/Cellar/fzf/0.15.9/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/usr/local/Cellar/fzf/0.15.9/shell/key-bindings.zsh"

