#!/bin/bash

server="/etc/terraria/TerrariaServer.bin.x86_64"
config_path="/data/configs/config.ini"
log_path="/data/logs"

pipe=/tmp/terraria.out

function shutdown() {
    count=5
    # Count down to 0 using a C-style arithmetic expression inside `((...))`.
    # Note: Increment the count first so as to simplify the `while` loop.
    (( ++count )) 
    while (( --count >= 0 )); do
        echo "Shutdown in $count seconds..."
        terraria_cli "say Shutdown in $count seconds..."
    done
    echo "Shutting down..."
    terraria_cli "say Shutting down..."
    terraria_cli "exit"
    rm $pipe
}

trap "shutdown" SIGTERM SIGINT
mkfifo $pipe
tmux new-session -d "$server -config $config_path -logerrors -logfile $log_path | tee $pipe" &
cat $pipe &
wait ${!}