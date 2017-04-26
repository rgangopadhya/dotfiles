export NETRC="$HOME/.netrc"

function heroku-current() {
    if [ -f "$NETRC" ]
    then
        cat $NETRC | grep login | uniq | sed -E s/login// | xargs
    else
        echo ""
    fi
}

function heroku-login() {
    if [ -f "$NETRC" ]
    then
        mv $NETRC $NETRC.bak
    fi
    heroku login
    if [ $? -eq 0 ]
    then
        rm -f $NETRC.bak
        NAME=$1
        if [ -z "$NAME" ]
        then
            cp $NETRC $NETRC.$USER
        else
            cp $NETRC $NETRC.$NAME
        fi
        heroku-list
    else
        if [ -f "$NETRC.bak" ]
        then
            mv $NETRC.bak $NETRC
        fi
    fi
}

function heroku-switch() {
    TO_NETRC="$NETRC.$1"
    if [ -f "$TO_NETRC" ] 
    then
        cp $TO_NETRC $NETRC
        heroku-list
    else
        echo "Cannot find $TO_NETRC, try running 'heroku-account login $1'"
    fi
}

function heroku-list() {
    PREFIX=$HOME/.netrc.
    for f in $PREFIX*
    do
        if [[ "$f" == *"*"* ]]
        then
            echo "Could not find anything like $NETRC.*, try running 'heroku-account login'"
        else
            NAME=$(echo $f | sed s#$PREFIX## | xargs)
            LOGIN=$(cat $f | grep login | uniq | sed -E s/login// | xargs)
            CURRENT=$(heroku-current)
            if [[ "$CURRENT" == "$LOGIN" ]]
            then
                IS_CURRENT="[*]"
            else
                IS_CURRENT=""
            fi
            echo $IS_CURRENT $NAME ":" $LOGIN
        fi
    done
}

function heroku-account() {
    if [ -z "$1" ] 
    then
        heroku-list
    else
        if [ "$1" = "login" ]
        then
            heroku-login $2
        else
            heroku-switch $1
        fi
    fi
}

alias ha=heroku-account
