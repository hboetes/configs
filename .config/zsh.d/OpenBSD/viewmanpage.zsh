viewmanpage()
{
    nroff -mandoc $1 | w3m
}
