local M = {}

local default_config = {
    default_notes = {
        {key = 'gg', cmd = 'Go to top of the file'},
    }
}

local user_config = {}

function M.set(config)
    user_config = vim.tbl_deep_extend('force', {}, default_config, config)
end

function M.get_default_notes()
    return user_config.default_notes
end

return M
