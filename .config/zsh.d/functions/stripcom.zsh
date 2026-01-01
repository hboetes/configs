stripcom () {
        local file="$1"
        [ -z $file ] && file="/dev/stdin"
        local line
        {
                while IFS= read -r line
                do
                        local stripped=${line%%'#'*}
                        [[ -z "${stripped// /}" ]] && continue
                        print -r -- "$stripped"
                done
        } < $file
}
