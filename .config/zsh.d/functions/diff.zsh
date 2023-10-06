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
