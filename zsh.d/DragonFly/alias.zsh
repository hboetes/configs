if isinpath gls; then
    alias ls='gls --color=auto --quoting-style=literal'
elif isinpath colorls; then
    alias ls='colorls -FG'
fi

alias mutt='mutt -y'

if isinpath dtpstree; then
    alias pstree='dtpstree'
fi
