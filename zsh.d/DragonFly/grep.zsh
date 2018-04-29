if command -v ag > /dev/null; then
    alias ag='ACK_PAGER_COLOR="w3m" ag --nonumbers'
    alias grep=ag
    alias zgrep='ag -z'
elif command -v ack > /dev/null; then
    alias ack='ACK_PAGER_COLOR="w3m" ack'
    alias grep=ack
fi
