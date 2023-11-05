[[ -e /etc/redhat-release ]] || return

alias allrpms='rpm -qa --qf "%{NAME}\n"|sort'

packages_by_size() {
    rpm -qa --queryformat '%{SIZE} %{NAME} \n' | sort -n
}

cleanup() {
    sudo dnf autoremove
    sudo package-cleanup --leaves
    sudo package-cleanup --orphans
    sudo dnf repoquery --extras
    sudo dnf repoquery --unneeded
}
