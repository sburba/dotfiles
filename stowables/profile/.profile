export PATH=$HOME/.local/bin:/usr/local/bin:$PATH

if [ "$0" = "/etc/gdm/Xsession" -a "$DESKTOP_SESSION" = "i3" ]; then
    export $(gnome-keyring-daemon --start)
    # SSH_AGENT_PID required to stop xinitrc-common from starting ssh-agent
    export SSH_AGENT_PID=${GNOME_KEYRING_PID:-gnome}
fi

PATH="$HOME/.node/bin:$PATH"  
NODE_PATH="$HOME/.node/lib/node_modules:$NODE_PATH"  
MANPATH="$HOME/.node/share/man:$MANPATH"
export _JAVA_AWT_WM_NONREPARENTING="1"
