doit()
{
    doithome=~/.doit
    if [ ! -d $doithome ]; then
        mkdir $doithome
    fi

    if isinst greadlink; then
        PWD_REAL=$(greadlink -f $PWD)
    else
        PWD_REAL=$(readlink -f $PWD)
    fi

    PWD_underscore=${PWD_REAL//\//_}
    unset doit_subdir
    for i in $doithome/*_SUBDIR(N); do
        h=${i#$doithome/}
        j=${h%_SUBDIR}
        if [[ ${PWD_underscore#$j} != $PWD_underscore ]]; then
            PWD_underscore=$h
            break
        fi
    done
    case $1 in
        delete)
            echo 'Removing the doit for this dir'
            rm -f $doithome/$PWD_underscore
            ;;
        edit)
            $EDITOR $doithome/$PWD_underscore
            ;;
        show)
            cat $doithome/$PWD_underscore
            ;;
        add)
            shift
            if [[ -z $1 ]]; then
                echo 'add requires an argument.'
                return 1
            fi
            echo "$@" >>! $doithome/$PWD_underscore
            ;;
        replace)
            shift
            if [[ -z $1 ]]; then
                echo 'add requires an argument.'
                return 1
            fi
            echo "$@" >! $doithome/$PWD_underscore
            ;;
        subdir)
            if [[ -e $doithome/$PWD_underscore ]]; then
                print "
$doithome/$PWD_underscore already exists, just use the normal doit
commands here.

"
            else
                PWD_underscore=${PWD_underscore}_SUBDIR
                echo 'What do you want to do in these subdirs? ;)'
                $EDITOR $doithome/$PWD_underscore
                echo 'Yes, lets doit again! :D'
            fi
            ;;
        help)
            print "
doit [edit|subdir|show|add|replace|delete|help] [your_doit_options]

doit creates a script which performs all the tasks you alway have
to perform in this specific directory or directorytree

"
            ;;
        *)
            if [[ -e $doithome/$PWD_underscore ]]; then
                echo 'Yes, lets do it! :)'
                # zsh error detection and follow up.
                TRAPZERR()
                {
                    echo 'Bah! >:(' >&2
                    return 1
                }
                case $1 in
                    log)
                        source $doithome/$PWD_underscore $@ |& tee .doit_logfile
                        ;;
                    *)
                        source $doithome/$PWD_underscore $@
                        ;;
                esac
                [[ $? -eq 0 ]] && echo 'Hurray! :D'
                TRAPZERR() {}
            else
                echo 'What do you want to do in this dir? ;)'
                $EDITOR $doithome/$PWD_underscore
                echo 'Yes, lets doit again! :D'
            fi
            ;;
    esac
}
