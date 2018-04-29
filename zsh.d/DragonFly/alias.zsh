if command -v gls > /dev/null; then
    alias ls='gls --color=auto --quoting-style=literal'
elif command -v colorls > /dev/null; then
    alias ls='colorls -FG'
fi

alias mutt='mutt -y'

if command -v dtpstree >& /dev/null; then
    alias pstree='dtpstree'
fi
