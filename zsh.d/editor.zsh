# Set the editor.
editors=(Emacs emacs jmacs qemacs qe mg mcedit nano vim vi)
if [ $UID -eq 0 ]; then
    editors=(emacs mg vim vi)
fi

for editor in $editors; do
    if isinpath $editor; then
        export EDITOR==$editor
        export VISUAL=$EDITOR
        export GIT_EDITOR=$EDITOR
        alias e=$EDITOR
        break
    fi
done
[[ -z $EDITOR ]] && echo 'No suitable editor found. Use tramp. :-}'
