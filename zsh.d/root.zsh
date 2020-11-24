# These settings are only important for root
[ $USER != root ] && return
# Log out after $TMOUT seconds of inactivity
export TMOUT=600
