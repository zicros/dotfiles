local config = require("configurations")

hl.bind(config.key_mod .. " + Return", hl.dsp.exec_cmd(config.apps.terminal))
hl.bind(config.key_mod .. " + d", hl.dsp.exec_cmd(config.apps.run))
hl.bind(config.key_mod .. " + e", hl.dsp.exec_cmd(config.apps.file_explorer))

hl.bind(config.key_mod .. " + p", hl.dsp.exec_cmd("exec-term -t " .. config.apps.terminal .. " -c " .. config.apps.volume_manager))

hl.bind(config.key_mod .. " + SHIFT + s", hl.dsp.exec_cmd(config.apps.screenshot))

