if command -v ag > /dev/null; then
    alias ag='ACK_PAGER_COLOR="less -x4SRFX" ag --nonumbers --noaffinity'
    alias grep=ag
    alias zgrep='ag -z'
elif command -v ack > /dev/null; then
    alias ack='ACK_PAGER_COLOR="less -x4SRFX" ack'
    alias grep=ack
fi
