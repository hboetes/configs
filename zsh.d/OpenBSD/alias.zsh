if command -v gls > /dev/null; then
    alias ls='gls --color=auto --quoting-style=literal'
elif command -v colorls > /dev/null; then
    alias ls='colorls -FG'
fi

local uname_r=$(uname -r)
uname_r=${uname_r//./_}
alias cvsup_stable="cvs -q up -rOPENBSD_$uname_r -Pd"

alias mutt='mutt -y'

if command -v dtpstree >& /dev/null; then
    alias pstree='dtpstree'
fi
