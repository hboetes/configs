if isinpath rg; then
    alias rg='rg --no-ignore-dot'
    alias grep='rg'
    alias zgrep='rg -z'
elif isinpath ag; then
    alias ag="ACK_PAGER_COLOR='less -x4SRFX' ag --nonumbers --noaffinity"
    alias grep=ag
    function zgrep() {
        search=$1
        shift
        for i in $*; do
            zcat $i| ag $search
        done
    }
elif isinpath ack; then
    alias ack='ACK_PAGER_COLOR="less -x4SRFX" ack'
    alias grep=ack
fi
