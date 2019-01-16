#!/usr/bin/env bash

BIN_ROOT_PATH=$(readlink $HOME/.bin)

source $BIN_ROOT_PATH/utils/common.sh

####################### SETUP FUNCTIONS
# $ free -m
#              total       used       free     shared    buffers     cached
# Mem:          7976       6459       1517          0        865       2248
# -/+ buffers/cache:       3344       4631
# Swap:         1951          0       1951
show_memory() {
    msg "Memory Usage"

    free | grep Mem | awk '{ printf("use: %.4f%, free: %.4f%\n", $3/$2 * 100.0, $4/$2 * 100.0) }'
    ret="$?"
    success "Done"
}


####################### MAIN()
show_memory
