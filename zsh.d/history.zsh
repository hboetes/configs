export HISTDIR=~/.history
[[ ! -d ${HISTDIR} ]] && mkdir -m700 ${HISTDIR}
export HISTSIZE=5000
export HISTFILE=${HISTDIR}/$HOST
unset HISTDIR
export SAVEHIST=4000
setopt APPEND_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_NO_FUNCTIONS
setopt HIST_NO_STORE
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt INC_APPEND_HISTORY
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt NO_SHARE_HISTORY
