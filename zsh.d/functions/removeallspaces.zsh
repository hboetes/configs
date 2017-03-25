removeallspaces()
{
    for name in *; do
        noname=${name##*/}
        ext=${noname##*.}
        [[ $noname == ${noname// /} ]] && continue
        if [[ $ext == $noname ]]; then
            namecap=${(C)noname}
        else
            noname=${noname%.*}
            namecap=${(C)noname}.$ext
        fi
        namewos=${namecap// /}
        [[ $namewos != $noname ]] &&
            [[ $namecap != $namewos ]] &&
            mv -i -- $name $namewos
    done
}
