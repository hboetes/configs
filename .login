unset  HISTFILE
umask  022
ulimit -c 0

export PATH=$HOME/bin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
export EDITOR=mg

if type -p printf > /dev/null 2>&1; then
    red=$(printf '\e[31m')
    export PS1='\[\e[0;36m\]\w\[\e[01m\]\[\e[30m\]$([ $? -eq 0 ]||printf $red)\$\[\e[0m\] '
else
    export PS1='\[\e[0;36m\]\w\[\e[01m\]\[\e[30m\]\$\[\e[0m\] '
fi

export TMP="$HOME/.tmp"  # /tmp isn't mounted in single-user mode on my system.

export HOME TERM


bind   ^I=complete-list

alias  l='ls -lA'
alias  e=$EDITOR
alias  c='cd;clear'

set -o emacs-usemeta
alias r='. ~/.profile'
