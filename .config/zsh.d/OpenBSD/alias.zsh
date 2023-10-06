if isinpath gls; then
    alias ls='gls --color=auto --quoting-style=literal'
elif isinpath colorls; then
    alias ls='colorls -FG'
fi

local uname_r=$(uname -r)
uname_r=${uname_r//./_}
alias cvsup_stable="cvs -q up -rOPENBSD_$uname_r -Pd"

isinpath mutt && alias mutt='mutt -y'

if isinpath dtpstree; then
    alias pstree='dtpstree'
fi
