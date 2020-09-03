if isinst delta; then
    diff()
    {
        delta $*
        return 0
    }
    export BAT_PAGER=less
    export GIT_PAGER=delta
fi

isinst colordiff || return 0
diff()
{
    /usr/bin/diff -u $* | colordiff
}

isinst diff-highlight || return 0
diff()
{
    /usr/bin/diff -u $* | diff-highlight | colordiff
}
