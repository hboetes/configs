uname -v | \grep -Eq '(Debian|Ubuntu)' || return

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
    # Remove old unused kernels, except for the last one.
    dpkg -l 'linux-image-4.*'|awk '/^(ii|rc)/ {print $2}' | sort -n -t- -k4 | sed -e "/$(uname -r)/,\$d" | head -n -1 | xargs -r sudo apt-get -y autoremove --purge
    if command -v apt-metalink >& /dev/null; then
        local aptgetter=apt-metalink
    else
        local aptgetter=apt-get
    fi
    local update=$(find /var/lib/apt/extended_states -mtime +0)
    if [[ ! -n $update ]]; then
        ls -l /var/lib/apt/extended_states
        echo -n "Apt cache recently updated. Press ctrl-c to exit or enter to continue."
        local nothing
        read nothing
        unset nothing
    fi
    sudo apt-get update
    sudo $aptgetter upgrade
    sudo $aptgetter dist-upgrade
    sudo apt-get autoremove --purge
    apt-removerc
    echo "debfoster?"
}
