# Set/unset shell options.
setopt \
    no_check_jobs autocd autolist autopushd autoresume \
    cdablevars extendedglob globdots longlistjobs \
    clobber notify pushdminus pushdsilent \
    pushdtohome rcquotes recexact sunkeyboardhack \
    complete_in_word brace_ccl no_hup

# setopt autocd correct correctall
unsetopt bgnice autoparamslash cdablevars

setopt noautoremoveslash

# Enable completion
autoload -Uz compinit && compinit

# Group completions by type
zstyle ':completion:*' group-name ''
zstyle ':completion:*' format '%B%d%b'

# Disable multios
setopt NO_MULTIOS

# Disable flow control
setopt NO_FLOW_CONTROL

# Enable completion
autoload -Uz compinit && compinit

# Group completions by type
zstyle ':completion:*' group-name ''
zstyle ':completion:*' format '%B%d%b'

SAVEHIST=500

# Recognize comments on the command line
setopt INTERACTIVE_COMMENTS
