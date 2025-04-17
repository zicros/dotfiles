#!/usr/bin/bash
PACKAGES_PATH=${PACKAGES_PATH:=$HOME/.config/os/packages}
if ! [ -f $PACKAGES_PATH ]; then
    echo "Package file doesn't exist: $PACKAGES_PATH"
    exit 0
fi

PACKAGES=$(cat "$PACKAGES_PATH")
if command -v pacman &> /dev/null; then
    # Arch install
    echo "Arch based install"
    sudo pacman --noconfirm -S $PACKAGES
elif command -v apt-get &> /dev/null; then
    # Debian based install
    echo "Debian based install"
    sudo apt-get install -y $PACKAGES
else
    echo "Unrecognized OS type"
    exit 1
fi

