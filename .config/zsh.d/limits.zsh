# Limits.
# ulimit unlimited
# limit stack 8192
# Disable core dumps
limit | \grep -q coredumpsize && limit core 0
