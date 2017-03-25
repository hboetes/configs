# OpenBSD doesn't have the sed -i option, no problem, we make it
# while you are watching.
sed-i()
{
    local TMP1=$(mktemp -t sed-i.XXXXXXXXXX) || return 1
    REGEX="$1"
    shift
    for i in $*; do
        sed -e "$REGEX" "$i" >! $TMP1
        # Preserve permissions etc.
        cat $TMP1 >! "$i"
    done
    rm $TMP1
}
