
export PATH=$HOME/.local/bin:/usr/local/bin:$PATH

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

PATH="$HOME/.node/bin:$PATH"  
NODE_PATH="$HOME/.node/lib/node_modules:$NODE_PATH"  
MANPATH="$HOME/.node/share/man:$MANPATH"
source "$HOME/.cargo/env"
