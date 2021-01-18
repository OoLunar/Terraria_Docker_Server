#!/bin/bash

# See wiki for server console commands
# https://terraria.gamepedia.com/Server#List_of_console_commands

# Checking for world file
# If not exist -> exit
ls /data/worlds/*.wld >/dev/null || exit

tmux send-keys "$1" Enter