#! /usr/bin/env bash

SCRIPT_DIR=$(dirname "$0")

mkdir -p ~/.config/qualia-shell
touch ~/.config/qualia-shell/settings.json

if [ ! -f ~/.config/qualia-shell/theme.json ]; then
    cp $SCRIPT_DIR/../theme.json ~/.config/qualia-shell/theme.json
fi

qs -p $SCRIPT_DIR/../shell.qml
