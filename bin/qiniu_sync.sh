#!/usr/bin/env bash
#
# Scripts that sync local files to QINIU Cloud.
#
# @version 1.0 2018-06-15

BIN_ROOT_PATH=$(readlink $HOME/.bin)

source $BIN_ROOT_PATH/utils/common.sh

####################### SETUP PARAMETERS
[ -z "$QINIU_SYNC_CONFIG" ] && QINIU_SYNC_CONFIG="$HOME/.qshell/upload.json"


####################### SETUP FUNCTIONS

sync_files() {
    local config_path="$1"

    msg "Trying to sync files using $config_path"

    if [ -e "$config_path" ]; then
        qshell qupload "$config_path"
        ret="$?"
        success "Successfully sync files"
    fi
}

####################### MAIN()

program_must_exist "qshell"

sync_files "$QINIU_SYNC_CONFIG"
