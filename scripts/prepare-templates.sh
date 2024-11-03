#!/bin/sh

VERSION=$1

TARGET=~/.local/share/godot/templates/${VERSION}.stable

if [ -f "$TARGET" ]; then
    echo "Templates already installed"
    exit
fi

mkdir -v -p ~/.local/share/godot/templates
mv /root/.local/share/godot/templates/${VERSION}.stable $TARGET
echo "Installed templates for Godot $VERSION"

echo "Root templates"
ls /root/.local/share/godot/templates

echo "Installed templates"
ls ~/.local/share/godot/templates