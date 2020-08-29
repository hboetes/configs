local fqdn=$(hostname)
local hostname=$(hostname -s)
if [[ $fqdn != $hostname ]]; then
    DOMAIN=${fqdn#*.}
    export DOMAIN
fi
