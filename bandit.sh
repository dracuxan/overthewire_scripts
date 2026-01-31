#!/bin/bash

LEVEL=0
CLEARED=false
CONFIG_DIR="$HOME/.config/bandit"
CONFIG_FILE="$CONFIG_DIR/bandit_level.conf"

create_level_config() {
    mkdir -p "$CONFIG_DIR"
    cp ./bandit_level.conf.template "$CONFIG_FILE"
    echo "created bandit level config at $CONFIG_FILE!"
}

read_level_config() {
    if [[ ! -f "$CONFIG_FILE" ]]; then
        echo "config file not found!"
        read -p "create new config? (y/n): " choice
        [[ $choice =~ ^[yY]$ ]] || exit 1
        create_level_config
    fi

    source "$CONFIG_FILE"
    LEVEL=${BANDIT_LEVEL:-0}
    CLEARED=${LEVEL_CLEARED:-false}
}

write_level_config() {
    {
        echo "BANDIT_LEVEL=$LEVEL"
        echo "LEVEL_CLEARED=$CLEARED"
    } >"$CONFIG_FILE"
}

start_level() {
    USER="bandit$LEVEL"
    echo "loading level $LEVEL..."
    ssh "$USER@bandit.labs.overthewire.org" -p 2220

    read -p "did you clear the level? (y/n): " choice
    if [[ $choice =~ ^[yY]$ ]]; then
        CLEARED=true
    else
        CLEARED=false
    fi

    write_level_config
}

main() {
    while true; do
        read_level_config

        if [[ $CLEARED == true ]]; then
            read -p "level $LEVEL cleared. start next level? (y/n): " choice
            [[ $choice =~ ^[yY]$ ]] || exit 0
            ((LEVEL++))
            CLEARED=false
            write_level_config
        else
            read -p "level $LEVEL not cleared. restart level? (y/n): " choice
            [[ $choice =~ ^[yY]$ ]] || exit 0
        fi

        start_level
    done
}

main
