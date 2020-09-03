beep()
{
    keep=$?
    if ! isinst espeak; then
        echo install espeak
        return $keep
    fi
    if (($keep == 0)); then
        espeak "job finished succesfully" >& /dev/null
    else
        espeak "job failed" >& /dev/null
    fi
    return $keep
}
