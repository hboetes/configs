if command -v /usr/local/bin/gls >& /dev/null; then
    alias ls='/usr/local/bin/gls --color=auto'
else
    alias ls='ls'
fi
alias tr=gtr
