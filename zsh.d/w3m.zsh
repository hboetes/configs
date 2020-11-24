# set w3m as the pager and manpager if it exists
[[ -e /etc/redhat-release ]] && return 0
isinpath w3m || return 0
export PAGER=w3m
alias less='w3m'
alias man='env COLUMNS=80 w3mman'
compdef w3mman=man
