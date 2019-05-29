# If we're in the console, the "real" one we set these vars. Otherwise
# stuff goes foobar on the zsh prompt etc.
case $(uname) in
    Linux)
        export SSH_AUTH_SOCK="/run/user/$(id -u)/ssh-agent.socket"
        ;;
    OpenBSD)
        export SSH_AUTH_SOCK="$HOME/.ssh/auth_socket"
        ;;
esac

if [ "${TTY#/dev/ttyC}" != "$TTY" ]; then
    # export TERM=xterm
    export TMOUT=300
elif [ -z "$TMUX" ]; then
    if ! pgrep -u $USER ssh-agent >& /dev/null; then
        rm -f $SSH_AUTH_SOCK
        ssh-agent -a $SSH_AUTH_SOCK > /dev/null 2>&1
    fi
    # Don't join a tmux session if we're already in it or if none is running.
    if [[ $TERM != screen* ]] && tmux list-sessions > /dev/null 2>&1; then
        # Give us a chance not to go into tmux.
        for ((i = 30; i >= 0; i--)); do
            if ((($i % 10) == 0)); then
                printf $(($i / 10));
            else
                printf .
            fi
            sleep 0.1
        done
        echo " Starting tmux session..."
        tmux -2 -u attach -d
        exit
    fi
fi
