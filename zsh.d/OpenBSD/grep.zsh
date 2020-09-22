if isinpath rg; then
    alias grep=rg
    alias zgrep='rg -z'
elif isinpath ag; then
    alias ag='ACK_PAGER_COLOR="w3m" ag --nonumbers'
    alias grep=ag
    function zgrep() {
        search=$1
        shift
        for i in $*; do
            zcat $i| ag $search
        done
    }
elif isinpath ack; then
    alias ack='ACK_PAGER_COLOR="w3m" ack'
    alias grep=ack
fi
