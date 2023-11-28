# It's not called the backward slash for nothing.
bs() {
    echo "${@//\\//}"
}
