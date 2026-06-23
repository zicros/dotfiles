hl.config({
    decoration = {
        blur = { enabled = false },
        shadow = { enabled = false }
    }
})

-- Apply to all windows
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.workspace_rule({
        workspace = i,
        no_rounding = true,
        decorate = true,
        gaps_in = 0,
        gaps_out = 0,
    })
end

hl.animation({ leaf = "fade", enabled = false, })
hl.animation({ leaf = "windows", enabled = false, })
