keybase_home := "/keybase/private/songjaehak"
home_dir := env_var('HOME')

up: (
    _up-home ".ssh/config") (
    _up-home ".ssh/authorized_keys") (
    _up-home ".aws/credentials") (
    _up-home ".aws/config") (
    _up-home ".kube/config") (
    _up-home ".zsh_history")

down: (
    _down-home ".ssh/config") (
    _down-home ".ssh/authorized_keys") (
    _down-home ".aws/credentials") (
    _down-home ".aws/config") (
    _down-home ".kube/config") (
    _down-home ".zsh_history")


_up-home path:
    #!/usr/bin/env bash
    DIR=`dirname "{{path}}"`
    KEYBASE_DIR="{{keybase_home}}/$DIR"
    KEYBASE_PATH="{{keybase_home}}/{{path}}"
    LOCAL_PATH="{{home_dir}}/{{path}}"

    if ! (keybase fs ls $KEYBASE_DIR) &> /dev/null; then
        keybase fs mkdir $KEYBASE_DIR
    fi

    if (keybase fs stat $KEYBASE_PATH) &> /dev/null; then
        if  [ "`keybase fs read $KEYBASE_PATH | sha256sum 2>/dev/null`" != "`cat $LOCAL_PATH | sha256sum 2>/dev/null`" ]; then
            keybase fs mv "$KEYBASE_PATH" "$KEYBASE_PATH.$(date +%Y%m%d-%H%M%S)"
            echo "upload from $LOCAL_PATH to $KEYBASE_PATH"
            keybase fs cp -r -f "$LOCAL_PATH" "$KEYBASE_PATH"
        fi
    else 
        echo "upload from $LOCAL_PATH to $KEYBASE_PATH"
        keybase fs cp -r -f "$LOCAL_PATH" "$KEYBASE_PATH"
    fi

_down-home path:
    #!/usr/bin/env bash
    LOCAL_PATH="{{home_dir}}/{{path}}"
    LOCAL_DIR=`dirname "$LOCAL_PATH"`
    KEYBASE_PATH="{{keybase_home}}/{{path}}"

    if ! [ -d $LOCAL_DIR ]; then
        mkdir -p $LOCAL_DIR
    fi

    if [ -d $LOCAL_PATH ] || [ -f $LOCAL_PATH ]; then 
        if  [ "`keybase fs read $KEYBASE_PATH | sha256sum 2>/dev/null`" != "`cat $LOCAL_PATH | sha256sum 2>/dev/null`" ]; then
            mv "$LOCAL_PATH" "$LOCAL_PATH.$(date +%Y%m%d-%H%M%S)"
            echo "download from $KEYBASE_PATH to $LOCAL_PATH"
            keybase fs cp -r -f "$KEYBASE_PATH" "$LOCAL_PATH"
        fi
    else
        echo "download from $KEYBASE_PATH to $LOCAL_PATH"
        keybase fs cp -r -f "$KEYBASE_PATH" "$LOCAL_PATH"
    fi
    
