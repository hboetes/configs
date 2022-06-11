if isinpath w3mman; then
    man() {
        env COLUMNS=80 w3mman "$@"
    }
else
    man() {
        (($COLUMNS > 80)) && COLUMNS=80
        COLUMNS=$COLUMNS \
            LESS_TERMCAP_md=$'\e[1;36m' \
            LESS_TERMCAP_me=$'\e[0m' \
            LESS_TERMCAP_us=$'\e[1;32m' \
            LESS_TERMCAP_ue=$'\e[0m' \
            GROFF_NO_SGR=1 \
            command man "$@"
    }
fi
