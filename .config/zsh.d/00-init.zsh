local hostname=$(hostname -s)
# hostname -d doesn't work on OpenBSD
local DOMAIN=$(hostname|sed -e "s|^$(hostname -s)\.||")

# I do this about 100 times so let's create a function for it.
isinpath() {
    command -v $1 >& /dev/null
}
