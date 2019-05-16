if command -v ag > /dev/null; then
    alias ag='ACK_PAGER_COLOR="w3m" ag --nonumbers'
    alias grep=ag
    function zgrep() {
        search=$1
        shift
        for i in $*; do
            zcat $i| ag $search
        done
    }
elif command -v ack > /dev/null; then
    alias ack='ACK_PAGER_COLOR="w3m" ack'
    alias grep=ack
fi
