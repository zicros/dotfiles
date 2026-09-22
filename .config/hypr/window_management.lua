local config = require("configurations")

hl.config({
    dwindle = {
        preserve_split = true
    }
})

-- Mouse resizing
hl.bind(config.key_mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })    -- LMB: Move a window
hl.bind(config.key_mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })  -- RMB: Resize a window

hl.bind(config.key_mod .. " + SHIFT + q",  hl.dsp.window.close())

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(config.key_mod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(config.key_mod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

-- Cycling through workspaces. Mainly for controller use
-- -- Cycle to the next workspace (r for absolute, m for only occupied)
hl.bind("SUPER + bracketright", hl.dsp.focus({ workspace = "m+1" }))

-- Cycle to the previous workspace (r for absolute, m for only occupied)
hl.bind("SUPER + bracketleft", hl.dsp.focus({ workspace = "m-1" }))

-- Moving workspaces to different monitors
-- Move the active workspace to the NEXT monitor
hl.bind(config.key_mod .. " + SHIFT + period", hl.dsp.workspace.move({ monitor = "r" }))

-- Move the active workspace to the PREVIOUS monitor
hl.bind(config.key_mod .. " + SHIFT + comma", hl.dsp.workspace.move({ monitor = "l" }))

-- Move the active workspace to a SPECIFIC monitor
hl.bind(config.key_mod .. " + SHIFT + p", hl.dsp.workspace.move({ monitor = config.monitors.primary_monitor }))
hl.bind(config.key_mod .. " + SHIFT + n", hl.dsp.workspace.move({ monitor = config.monitors.secondary_monitor }))

-- Window focus movement
hl.bind(config.key_mod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(config.key_mod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(config.key_mod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(config.key_mod .. " + j", hl.dsp.focus({ direction = "down" }))

-- Window movement
hl.bind(config.key_mod .. " + SHIFT + h", hl.dsp.window.swap({ direction = "left" }))
hl.bind(config.key_mod .. " + SHIFT + l", hl.dsp.window.swap({ direction = "right" }))
hl.bind(config.key_mod .. " + SHIFT + k", hl.dsp.window.swap({ direction = "up" }))
hl.bind(config.key_mod .. " + SHIFT + j", hl.dsp.window.swap({ direction = "down" }))

-- Window sizing
hl.bind(config.key_mod .. " + f", hl.dsp.window.fullscreen(true))

-- Floating window
hl.bind(config.key_mod .. " + SHIFT + f", hl.dsp.window.float({ action = "toggle" }))

-- Scratchpad
hl.bind(config.key_mod .. " + minus", hl.dsp.workspace.toggle_special("scratch"))

-- Toggle window in and out of scratchpad while syncing workspace view
hl.bind(config.key_mod .. " + SHIFT + minus", function()
    local win = hl.get_active_window()
    local current_ws = hl.get_active_workspace()
    
    if win then
        if string.sub(win.workspace.name, 1, 8) == "special:" then
            -- 1. Move window to the active tiled workspace
            hl.dispatch(hl.dsp.window.move({ workspace = current_ws.id }))
        else
            -- 1. Send window to the designated scratchpad
            hl.dispatch(hl.dsp.window.move({ workspace = "special:scratch" }))
        end
    end
end)


hl.bind(config.key_mod .. " + v", hl.dsp.layout("swapsplit"))
hl.bind(config.key_mod .. " + s", hl.dsp.layout("togglesplit"))
