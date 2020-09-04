if isinpath delta; then
    diff()
    {
        delta $*
        return 0
    }
    export BAT_PAGER=less
    export GIT_PAGER=delta
fi

isinpath colordiff || return 0
diff()
{
    /usr/bin/diff -u $* | colordiff
}

isinpath diff-highlight || return 0
diff()
{
    /usr/bin/diff -u $* | diff-highlight | colordiff
}
