if isinpath delta; then
    diff()
    {
        delta $*
        return 0
    }
    export GIT_PAGER=delta
    export BAT_PAGER=less
    export BAT_THEME=base16
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
