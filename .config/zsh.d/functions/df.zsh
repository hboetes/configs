df() {
    case $1 in
        '')
            /bin/df -h
            ;;
        /*)
            /bin/df -h "${1}"
            ;;
        *)
            shift
            /bin/df "${@}"
            ;;
    esac
}
