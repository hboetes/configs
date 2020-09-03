local fqdn=$(hostname)
local hostname=$(hostname -s)
if [[ $fqdn != $hostname ]]; then
    DOMAIN=${fqdn#*.}
    export DOMAIN
fi

# I do this about 100 times so let's create a function for it.
isinst() {
    command -v $1 >& /dev/null
}
