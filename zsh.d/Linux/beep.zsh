beep()
{
    keep=$?
    if (($keep == 0)); then
        espeak "job finished succesfully" >& /dev/null
        else
            espeak "job failed" >& /dev/null

    fi
    return $keep
}
