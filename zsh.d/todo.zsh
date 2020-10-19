# Show the TODO file if it exists
if [ -e ~/TODO ]; then
    if isinpath bat; then
        bat -p ~/TODO
    else
        cat ~/TODO
    fi
fi
