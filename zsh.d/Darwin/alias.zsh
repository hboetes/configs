if isinst /usr/local/bin/gls; then
    alias ls='/usr/local/bin/gls --color=auto'
else
    alias ls='ls'
fi
isinst gtr && alias tr=gtr
