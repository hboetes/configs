pg()
{
    if pid=$(pgrep -f -d ',' $1 2> /dev/null); then
        ps uww -p $pid
    else
        echo 'No matching process found.' >&2
        return 1
    fi
}
