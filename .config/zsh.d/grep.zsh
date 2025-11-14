if isinpath rg; then
    alias grep=rg
    function zgrep() {
        search=$1
        shift
        for i in $*; do
            zcat $i| rg $search
        done
    }
fi
