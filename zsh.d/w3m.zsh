# set w3m as the pager and manpager if it exists
if command -v w3m > /dev/null; then
    export PAGER=w3m
    alias less='w3m'
    alias man='env COLUMNS=80 w3mman'
    compdef w3mman=man
fi
