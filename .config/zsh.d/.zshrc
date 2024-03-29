#!/bin/zsh

# Source all configs in a given directory.
sourcepath()
{
    local dir sourcefile
    for dir in $*; do
        [[ -d $dir ]] || continue
        # (N) is null_glob; ie do not return *.zsh if nothing is found.
        for sourcefile in $dir/*.zsh(N); do
            # echo sourcing $sourcefile
            source $sourcefile
        done
    done
}

# These are the pathnames that will be sourced. The latter files can override things.
sourcepath \
    $ZDOTDIR \
    $ZDOTDIR/functions \
    $ZDOTDIR/$(uname) \
    $ZDOTDIR/$(uname -n) \
    $ZDOTDIR/$(uname -m) \
    $ZDOTDIR/${USER}_$(uname -n)

# Enable mortal users to set their own local settings. Sourced at the
# very last.
[[ -f ~/.zlocal ]] && source ~/.zlocal
# True!
:
