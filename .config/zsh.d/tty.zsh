# Don't allow shells in terminals to persist.
if [[ $TTY == /dev/tty* ]] && [[ $TTY != /dev/ttyp* ]]; then
    TMOUT=300
fi
