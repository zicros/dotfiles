if ! $(which fzf 2>&1 > /dev/null); then
    return
fi

source <(fzf --zsh)
