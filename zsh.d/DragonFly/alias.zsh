if isinst gls; then
    alias ls='gls --color=auto --quoting-style=literal'
elif isinst colorls; then
    alias ls='colorls -FG'
fi

alias mutt='mutt -y'

if isinst dtpstree; then
    alias pstree='dtpstree'
fi
