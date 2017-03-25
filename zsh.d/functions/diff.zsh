command -v colordiff >& /dev/null || return 0
diff()
{
    /usr/bin/diff -u $* | colordiff
}
