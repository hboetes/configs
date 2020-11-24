# Don't allow shells in terminals to persist.
if [[ $TTY == /dev/tty* ]]; then
    export TMOUT=300
fi
