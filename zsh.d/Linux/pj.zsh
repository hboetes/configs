pj()
{
    if [[ -n $1 ]]; then
        COLUMNS=1000 ps jf -u $1
    else
        COLUMNS=1000 ps jf
    fi
}
