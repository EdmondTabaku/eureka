local M = {}

local default_config = {
    default_notes = {
        "gg - Go to file start",
    },
    close_key = "q",
}

local user_config = {}

function M.set(config)
    user_config = vim.tbl_deep_extend("force", {}, default_config, config)
end

function M.get_notes()
    return user_config.default_notes
end

function M.get_close_key()
    return user_config.close_key
end

return M
