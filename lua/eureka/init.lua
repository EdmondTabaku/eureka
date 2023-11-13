-- NOTE: This file is called whenever require("eureka") is called. No need for a init.lua on the top level
local config = require("eureka.config")
local ui = require("eureka.ui")

local M = {}

M._notes = {}

M.setup = function(user_config)
    config.set(user_config)
end

M.show_notes = function()
    M._notes = {}
    -- TODO: This creates a copy of the notes
    for _, v in ipairs(config.get_notes()) do
        table.insert(M._notes, v)
    end
    local close_key = config.get_close_key()
    ui.display(M._notes, close_key)
end

return M
