pg()
{
    if pid=$(pgrep -f -d ',' $1 2> /dev/null); then
        ps -o user,ppid,pid,ni,%cpu,%mem,tty,stat,start,time,args -p $pid
    else
        echo 'No matching process found.' >&2
        return 1
    fi
}
