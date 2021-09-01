local hostname=$(hostname -s)
local DOMAIN=$(hostname -d)

# I do this about 100 times so let's create a function for it.
isinpath() {
    command -v $1 >& /dev/null
}
