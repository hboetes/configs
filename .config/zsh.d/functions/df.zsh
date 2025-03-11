df() {
    case $1 in
        '')
            /bin/df -h | grep -v tmpfs
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
