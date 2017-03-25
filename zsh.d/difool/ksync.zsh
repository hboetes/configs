ksync()
{
    if [[ -z $1 ]]; then
        source="."
    else
        source="$@"
    fi
    rsync -avP --exclude '*.torrent' --exclude '*.meta' --exclude '*.aria2' --exclude '*.filelist' --exclude '.*' --rsync-path=/opt/bin/rsync "$source" kluizenaar:/volume1/downloads
}

fsync()
{
    if [[ -z $1 ]]; then
        source="."
    else
        source="$@"
    fi
    find "$source" -type f \( -name '*.flac' -o -name '*.cue' \) -print0 | rsync -avP0 --files-from=- --rsync-path=/opt/bin/rsync . kluizenaar:/volume1/music/todo
}
