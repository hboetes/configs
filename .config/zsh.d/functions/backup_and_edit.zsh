backup_and_edit()
{
    if [ $# -ne 1 ]; then
        echo 'What?'
        return 1
    fi
    [[ -r "$1" && -f "$1" ]] ||
        {
            echo "${0##*/}: $1: no access to that file." >&2
            return 1
        }
    [[ ! -r "$1.orig" ]] && cp "$1{,.orig}"
    $EDITOR "$1"
}
