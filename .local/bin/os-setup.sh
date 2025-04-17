#!/usr/bin/bash
BOOTSTRAP_SCRIPTS="$HOME/.local/lib/os/setup.d"
for file in "$BOOTSTRAP_SCRIPTS"/*; do
    if ! [ -x "$file" ]; then
        continue
    fi

    echo "Executing $file"
    ENV_FILE="$file.env"
    if [ -f "$ENV_FILE" ]; then
        echo "Sourcing $ENV_FILE"
        env $(cat $ENV_FILE | xargs) "$file"
        EXIT_CODE=$?
    else
        "$file"
        EXIT_CODE=$?
    fi

    if [ "$EXIT_CODE" != 0 ] ; then
        echo "Failed to setup OS"
        exit 1
    fi
done
