command -v colordiff >& /dev/null || return 0
diff()
{
    /usr/bin/diff -u $* | colordiff
}

command -v diff-highlight >& /dev/null || return 0
diff()
{
    /usr/bin/diff -u $* | diff-highlight| colordiff
}
