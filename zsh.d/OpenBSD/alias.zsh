if isinst gls; then
    alias ls='gls --color=auto --quoting-style=literal'
elif isinst colorls; then
    alias ls='colorls -FG'
fi

local uname_r=$(uname -r)
uname_r=${uname_r//./_}
alias cvsup_stable="cvs -q up -rOPENBSD_$uname_r -Pd"

isinst mutt && alias mutt='mutt -y'

if isinst dtpstree; then
    alias pstree='dtpstree'
fi
