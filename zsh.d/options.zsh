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
