uname -v | \grep -Eq ' (Debian|Ubuntu|PVE) ' || return

export DEBFULLNAME="Han Boetes"
export DEBEMAIL="hboetes@gmail.com"

if command -v quilt >& /dev/null; then
    alias dquilt="quilt --quiltrc=${HOME}/.quiltrc-dpkg"
fi

packages_by_size()
{
    dpkg-query -W --showformat='${Installed-Size;10}\t${Package}\n' | sort -k1,1n
}

orphaner()
{
    set -- $(deborphan)
    if [ $# -gt 0 ]; then
        sudo apt-get autoremove --purge $*
    fi
}

apt-removerc()
{
    dpkg -l |awk '/^rc/ {print $2}'|xargs -r sudo dpkg --purge
}

apt-upgrade()
{
    if command -v apt-metalink >& /dev/null; then
        local aptgetter=apt-metalink
    else
        local aptgetter=apt
    fi

    # Remove old unused kernels, except for the latest one and the running one.
    case $(uname -r) in
        *pve)
            SS='pve-kernel-4.*pve'
            SC=3
            ;;
        *)
            SS='linux-image-4.*'
            SC=4
            ;;
    esac

    remove_kernels=$(dpkg -l "$SS" | awk '/^(ii|rc)/ {print $2}' | sort -n -t- -k$SC | sed -e "/$(uname -r)/,\$d" | head -n -1)
    if [[ ${=remove_kernels} != "" ]]; then
        sudo $aptgetter autoremove --purge ${=remove_kernels}
    fi

    local update=$(find /var/lib/apt/extended_states -mtime +0)
    if [[ ! -n $update ]]; then
        ls -l /var/lib/apt/extended_states
        echo -n "Apt cache recently updated. Press ctrl-c to exit or the any key to continue."
        local nothing
        read -sk1 nothing
        unset nothing
    fi

    sudo apt update
    sudo $aptgetter upgrade
    sudo $aptgetter dist-upgrade
    sudo $aptgetter autoremove --purge
    apt-removerc
    echo "debfoster?"
}
