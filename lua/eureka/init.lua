local config = require("eureka.config")
local ui = require("eureka.ui")

local function setup(user_config)
    config.set(user_config)
    vim.api.nvim_set_keymap("n", "<C-u>", ":lua require('eureka').show_notes()<CR>", { noremap = true, silent = true })
end

local function show_notes()
    local default_notes = config.get_default_notes()
    local close_key = config.get_close_key()
    ui.display(default_notes, close_key)
end

return {
    setup = setup,
    show_notes = show_notes,
}

