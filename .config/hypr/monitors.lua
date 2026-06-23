-- Use `hyprctl monitors all` to get all monitor info
hl.monitor({
    output = "DP-1",
    mode = "3840x2160@60.00",
    scale = 1.2
})

hl.monitor({
    output = "HDMI-A-1",
    mode = "1920x1080@60.00",
    scale = 1,
    position = "auto-left"
})
