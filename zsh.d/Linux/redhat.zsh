[[ -e /etc/redhat-release ]] || return

alias allrpms='rpm -qa --qf "%{NAME}\n"|sort'

packages_by_size() {
    rpm -qa --queryformat '%{SIZE} %{NAME} \n' | sort -n
}
