cal() {
    local now=$(date +%d)
    =cal -m |sed "s/ $now /$(printf " \033[1;30;44m$now\033[0m ")/"
}
