split()
{
    mkdir -p tmp
    shnsplit -d tmp -o flac -f *cue -t '%p - %a - %n - %t' *.(flac|ape)
    rm -f tmp/*00*pregap* || :
}
