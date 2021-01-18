#!/bin/bash

server="/etc/terraria/TerrariaServer.bin.x86_64"
config_path="/data/configs/config.ini"
log_path="/data/logs"

pipe=/tmp/terraria.out
players=/tmp/terraria.players.out

function shutdown() {
    count=5
    # Count down to 0 using a C-style arithmetic expression inside `((...))`.
    # Note: Increment the count first so as to simplify the `while` loop.
    (( ++count )) 
    while (( --count >= 0 )); do
        terraria_cli "say Shutdown in $count seconds..."
    done
    terraria_cli "say Shutting down..."
    terraria_cli "exit"
    tmuxPid=$(pgrep tmux)
    terrariaPid=$(pgrep --parent $tmuxPid Main)
    while [ -e /proc/$terrariaPid ]; do
        sleep .5
    done
    rm $pipe
}

trap "shutdown" SIGTERM SIGINT
mkfifo $pipe
tmux new-session -d "$server -config $config_path -logpath  | tee $pipe $players" &
cat $pipe &
wait ${!}
