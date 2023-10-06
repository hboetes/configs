pg()
{
    if pid=($(pgrep -f $1 2> /dev/null))
    then
        ps -o user,pid,%cpu,%mem,ni,tty,stat,start,time,args -p $pid[1]
        pid[1]=()
        while [[ "$pid" ]]
        do
            ps -o user=,pid=,%cpu=,%mem=,ni=,tty=,stat=,start=,time=,args= -p $pid[1]
            pid[1]=()
        done
    else
        echo 'No matching process found.' >&2
        return 1
    fi
}
