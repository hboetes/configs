# set w3m as the pager and manpager if it exists
[[ -e /etc/redhat-release ]] && return 0
isinpath w3m || return 0
alias man='env PAGER=w3m COLUMNS=80 w3mman'
compdef w3mman=man
