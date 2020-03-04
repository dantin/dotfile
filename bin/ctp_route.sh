#!/usr/bin/env bash

BIN_ROOT_PATH=$(readlink $HOME/.bin)

source $BIN_ROOT_PATH/utils/common.sh

# "jira, 3.239.244/22" \
# "o365, 10.69.144/22" \
# "github, 10.152.32/22" \
# "printer, 10.166.248/22" \
ROUTE_TABLE=( \
    "proxy, 3.20.128.0/22" \
    "github, 10.152.32.0/22" \
)

DEVICE_IF="enp0s25"
GATEWAY_ADDR="192.168.0.1"

############################ SETUP FUNCTIONS
setup_route() {
    msg "Setup customized route table."

    for i in "${!ROUTE_TABLE[@]}"; do
        IFS=', ' read -r -a entry <<< "${ROUTE_TABLE[i]}"
        sudo ip route add "${entry[1]}" via ${GATEWAY_ADDR} dev ${DEVICE_IF}

        ret="$?"
        success "Successfully created route entry ${entry[0]}"
    done

    ret="$?"
    success "Successfully setup route table"
}

reset_route() {
    msg "Reset customized route table\n"

    sudo ip route del default via $GATEWAY_ADDR dev $DEVICE_IF
    ret="$?"
    success "Delete route entry default"

    for i in "${!ROUTE_TABLE[@]}"; do
        IFS=', ' read -r -a entry <<< "${ROUTE_TABLE[i]}"
        sudo ip route del "${entry[1]}" via ${GATEWAY_ADDR} dev ${DEVICE_IF}

        ret="$?"
        success "Delete route entry ${entry[0]}"
    done

    ret="$?"
    success "Successfully reset route table."
}

show_route() {
    local route_table=$(netstat -rnf inet)

    msg "\nSystem Route Table\n"
    msg "$route_table"

    msg "\nCustomized Route Rule\n"
    msg "Name\tIP Range\tGateway\t\tIface"
    for i in "${!ROUTE_TABLE[@]}"; do
        IFS=', ' read -r -a entry <<< "${ROUTE_TABLE[i]}"

        msg "${entry[0]}\t${entry[1]}\t$GATEWAY_ADDR\t$DEVICE_IF"

    done

    ret="$?"
    success "Successfully show route table."
}

############################ MAIN()

case "$1" in
    set)
        setup_route
        ;;
    reset)
        reset_route
        ;;
    show)
        show_route
        ;;
    *)
        error "You must define [set|show|reset] as command line parameter."
        ;;
esac
