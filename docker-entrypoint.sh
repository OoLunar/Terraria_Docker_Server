#!/bin/bash

server="/terraria/TerrariaServer.bin.x86_64"
server_config="/terraria/config/config.txt"

pipe=/tmp/terraria.out
players=/tmp/terraria.players.out

function shutdown() {
  terraria_cli "say Server is shutting down NOW!"
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
tmux new-session -d "$server -config $server_config | tee $pipe $players" &
cat $pipe &
wait ${!}
