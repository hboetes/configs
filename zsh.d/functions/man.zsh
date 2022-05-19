[[ $TERM != xterm-256color ]] && return
man() {
    LESS_TERMCAP_md=$'\e[1;36m' \
                   LESS_TERMCAP_me=$'\e[0m' \
                   LESS_TERMCAP_us=$'\e[1;32m' \
                   LESS_TERMCAP_ue=$'\e[0m' \
                   GROFF_NO_SGR=1 \
                   command man "$@"
}
