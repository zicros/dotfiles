#!/usr/bin/bash
BOOTSTRAP_SCRIPTS="$HOME/.local/lib/os/setup.d"

usage()
{
    echo "Usage $0 [-n] [-f FILTER] "
    exit 1
}

while getopts ":nf:" OPT; do
    case $OPT in
        n)
            NOOP="1"
            ;;
        f)
            FILTER=$OPTARG
            ;;
        :)
            usage
            ;;
    esac
done

FILTER="${FILTER:-*}"

for file in "$BOOTSTRAP_SCRIPTS"/$FILTER; do
    if ! [ -x "$file" ]; then
        continue
    fi

    EXIT_CODE=0

    ENV_FILE="$file.env"
    if [ -f "$ENV_FILE" ]; then
        echo "Sourcing $ENV_FILE"
        ENV_VARS=$(cat $ENV_FILE | xargs)
    fi

    ENV_VARS="${ENV_VARS:-_NOENV=1}"

    echo "Executing $file"
    if [ "$NOOP" ]; then
        continue
    fi

    env "${ENV_VARS}" "$file"
    EXIT_CODE=$?

    if [ "$EXIT_CODE" != 0 ] ; then
        echo "Failed to setup OS"
        exit 1
    fi
done
