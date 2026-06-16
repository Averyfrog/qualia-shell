#! /usr/bin/env bash

SCRIPT_DIR=$(dirname "$0")

mkdir -p ~/.config/qualia-shell
touch ~/.config/qualia-shell/settings.json

qs -p $SCRIPT_DIR/../shell.qml
