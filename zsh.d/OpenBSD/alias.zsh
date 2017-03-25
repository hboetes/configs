if command -v gls > /dev/null; then
    alias ls='gls --color=auto --quoting-style=literal'
elif command -v colorls > /dev/null; then
    alias ls='colorls -FG'
fi
# This looks a bit funny, I admit, what is it doing here I always wonder when I see this.
local uname_r=$(uname -r)
export PKG_PATH="http://ftp.eu.openbsd.org/pub/OpenBSD/$uname_r/packages/$(uname -m)/"
uname_r=${uname_r//./_}
alias cvsup_stable="cvs -q up -rOPENBSD_$uname_r -Pd"
# alias updatessl='cd /usr/src/lib/libssl; make cleandir; cvs -q up -rOPENBSD_$uname_r -Pd; read niks; make obj ; make -j8; sudo make install'

alias mutt='mutt -y'

if command -v dtpstree >& /dev/null; then
    alias pstree='dtpstree'
fi
