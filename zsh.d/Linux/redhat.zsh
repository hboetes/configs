[[ -e /etc/redhat-release ]] || return

alias allrpms='rpm -qa --qf "%{NAME}\n"|sort'
