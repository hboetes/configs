pip-update()
{
    pip freeze --local | cut -d = -f 1 | xargs -n1 pip install -U --user
}
