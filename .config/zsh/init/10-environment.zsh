if is_wsl; then
    # Add this for easier resolving paths that need the windows path
    export WIN_HOME=$(get_win_home)
fi
