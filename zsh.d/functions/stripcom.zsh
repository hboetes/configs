stripcom()
{
    local file="$1"
    [ -z $file ] && file="/dev/stdin"
    local line
    {
        while read line ; do
            line=${line%%'#'*}
            [[ -z "$line" ]] && continue
            print -r -- "$line"
        done
    } < $file
}
