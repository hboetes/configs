if isinpath /usr/local/bin/gls; then
    alias ls='/usr/local/bin/gls --color=auto'
else
    alias ls='ls'
fi
isinpath gtr && alias tr=gtr
