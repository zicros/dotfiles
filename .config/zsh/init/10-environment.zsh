if is_wsl; then
    # Add this for easier resolving paths that need the windows path
    export WIN_HOME=$(get_win_home)
fi

# This is useful for systemd services to use the same environment variables as a standard user
env > $HOME/.local/state/user.env
