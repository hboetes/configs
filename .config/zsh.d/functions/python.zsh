pip-update()
{
    if ! test -x ~/.local/bin/pip; then
        curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
        python3 get-pip.py --user
        rm get-pip.py
    else
        pip list --outdated --format=freeze --user | cut -d = -f 1 | xargs -r -n1 pip install -U --user
    fi
}
