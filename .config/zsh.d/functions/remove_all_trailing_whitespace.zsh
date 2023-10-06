remove_all_trailing_whitespace() {
    # XXX this kills .git folders
    perl -pi -e 's/ +$//' **/*(.)
}
