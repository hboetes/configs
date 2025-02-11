if isinpath ag; then
    alias ag="ACK_PAGER_COLOR='less -x4SRFX' ag --nonumbers --noaffinity"
    # alias grep=ag
    function zgrep() {
        search=$1
        shift
        for i in $*; do
            zcat $i| ag $search
        done
    }
fi
