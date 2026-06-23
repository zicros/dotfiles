local M = {}

M.apps = {
    terminal = "alacritty",
    file_explorer = "nautilus",
    run = "wmenu-run",
    --run = "hyprland-run",
    volume_manager = "pulsemixer",
    screenshot = "grim -g \"$(slurp)\" -t png - | swappy -f -",
}

M.monitors = {
    primary_monitor = "DP-1",
    secondary_monitor = "HDMI-A-1"
}

M.key_mod = "SUPER" -- Windows key

-- hyprland-run
-- exit

return M
