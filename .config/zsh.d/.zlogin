# If we're in the console, the "real" one we set these vars. Otherwise
# stuff goes foobar on the zsh prompt etc.
case $(uname) in
    Linux)
        export SSH_AUTH_SOCK="/run/user/$(id -u)/ssh-agent.socket"
        # export SSH_AUTH_SOCK="/run/user/$(id -u)/keyring/ssh"
        ;;
    *)
        export SSH_AUTH_SOCK="$HOME/.ssh/auth_socket"
        ;;
esac

if ! pgrep -u $USER ssh-agent >& /dev/null; then
    rm -f $SSH_AUTH_SOCK
    ssh-agent -a $SSH_AUTH_SOCK >& /dev/null
fi

#return

#if [[ $TTY == /dev/tty2 ]]; then
#    exec .wsession
#    # Don't even think of joining a running tmux session, so bail out now.
#    exit 0
#fi

# Don't join a tmux session if we're already in it or if none is running.
# if [[ -z $TMUX ]] && [[ -n $TERM ]] && tmux list-sessions >& /dev/null; then
#     echo -n 'Joining the running tmux session in '
#     for ((i = 30; i >= 0; i--)); do
#         if ((($i % 10) == 0)); then
#             printf $(($i / 10));
#         else
#             printf .
#         fi
#         sleep 0.1
#     done
#     tmux -2 -u attach -d
#     exit
# fi
