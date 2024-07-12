# Configure oh-my-zsh to point to point to declare ZSH_CONFIG
ZSH_CONFIG_RAW="\$HOME/.config/zsh"

if [[ -z "${ZSH_CONFIG}" ]]; then
    export ZSH_CONFIG="$ZSH_CONFIG_RAW"
    CHECK_ZSH_RC=1
fi

ZSH_CUSTOM_SOURCE_CMD="source $ZSH_CONFIG_RAW/.zshrc"
ZSH_CONFIG_EXPORT_CMD="export ZSH_CONFIG=$ZSH_CONFIG_RAW"

ZSHRC="$HOME/.zshrc"
if ! [[ -f "${ZSHRC}" ]]; then
        cat <<EOF >> $ZSHRC
$ZSH_CONFIG_EXPORT_CMD
$ZSH_CUSTOM_SOURCE_CMD
EOF

    RESTART_ZSH=1

else
    if [[ -v CHECK_ZSH_RC ]]; then
        ZSH_CONFIG_PRESENT=$(cat "$ZSHRC" | grep "^$ZSH_CONFIG_EXPORT_CMD" && echo 1)
        if [[ -z "$ZSH_CONFIG_PRESENT" ]]; then
            sed -i "1s|^|$ZSH_CONFIG_EXPORT_CMD\\n|" "$ZSHRC"
        fi

        ZSH_SOURCE_PRESENT=$(cat "$ZSHRC" | grep "^$ZSH_CUSTOM_SOURCE_CMD" && echo 1)
        if [[ -z "$ZSH_SOURCE_PRESENT" ]]; then
            sed -i "s|^\(source \$ZSH/oh-my-zsh.sh\)|$ZSH_CUSTOM_SOURCE_CMD\n\1\n|" "$ZSHRC"
        fi

        RESTART_ZSH=1
    fi
fi

if [[ -v RESTART_ZSH ]]; then
    echo "Need to restart ZSH for changes to take effect"
fi
