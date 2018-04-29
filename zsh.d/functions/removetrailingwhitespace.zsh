removetrailingwhitespace()
{
    sed -i 's/[[:space:]]*$//' "$@"
    # sed -e :a -e '/^\n*$/{$d;N;};/\n$/ba'
}
