watch () {
    local PAD
    local IN=2
    case $1 in
        -n)
            IN=$2
            shift 2
            ;;
    esac
    printf '\033c'
    local CM="$*"
    local LEFT="$(printf 'Every %.1f: %s' $IN $CM)"
    ((PAD = COLUMNS - ${#LEFT}))
    while :
    do
        echo -nE "$LEFT"
        printf "%${PAD}s\n" "$HOST $(date)"
        eval "$CM"
        sleep $IN
        printf '\033c'
    done
}
