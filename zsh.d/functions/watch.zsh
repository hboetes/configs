watch () {
    IN=2
    case $1 in
        -n)
            IN=$2
            shift 2
            ;;
    esac
    clear
    HN="$(hostname)"
    HD="$(printf 'Every %.1f: ' $IN)"
    CM="$*"
    # Where does that -2 come from?
    ((PAD = COLUMNS - ${#HD} - ${#CM} - ${#DT} - 2))
    while :
    do
        DT=$(date)
        printf "$HD%s%${PAD}s: %s\n\n" "$CM" "$HN" "$DT"
        eval "$CM"
        sleep $IN
        clear
    done
}
