stripcom()
{
    local file="$1"
    [ -z $file ] && file="/dev/stdin"
    local line
    {
        while read line ; do
            line=${line%%'#'*}
            [ -z "$line" ] && continue
            echo $line
        done
    } < $file
}
