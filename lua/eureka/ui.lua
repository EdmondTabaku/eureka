local M = {}

function load_notes()
    local notes = {}
    local file = io.open('./eureka_notes.txt', 'r')

    if file then
        for line in file:lines() do
            table.insert(notes, line)
        end
        file:close()
    end

    return notes
end

local function save_notes(notes)
    local file = io.open('./eureka_notes.txt', 'w')

    if file then
        for _, line in ipairs(notes) do
            file:write(line .. '\n')
        end
        file:close()
    end
end

function M.display(default_notes)

    -- Calculate the width and height of the floating window
    local width = math.floor(vim.o.columns * 0.8)
    local height = math.floor(vim.o.lines * 0.8)

    -- Calculate the window position
    local col = math.floor((vim.o.columns - width) / 2)
    local row = math.floor((vim.o.lines - height) / 2)

    -- Buffer and window options
    local buff = vim.api.nvim_create_buf(false, true)
    local win = vim.api.nvim_open_win(buff, true, {
        relative = 'editor',
        width = width,
        height = height,
        col = col,
        row = row,
        style = 'minimal',
        border = 'rounded',
    })

    lines = {}

    for _, note in ipairs(default_notes) do
        table.insert(lines, note.key .. ' ' .. note.cmd)
    end
    for _, note in ipairs(load_notes()) do
        table.insert(lines, note)
    end

    -- Set the buffer content to the list of notes
    vim.api.nvim_buf_set_lines(buff, 0, -1, false, lines)

    -- Set buffer options
    vim.api.nvim_buf_set_option(buff, 'modifiable', true)
    vim.api.nvim_buf_set_option(buff, 'bufhidden', 'wipe')

    -- Map q to close the window
    vim.api.nvim_buf_set_keymap(buff, 'n', 'q', '', {
        noremap = true,
        silent = true,
        callback = function()
            local lines = vim.api.nvim_buf_get_lines(buff, 0, -1, false)
            save_notes(lines)
            vim.api.nvim_win_close(win, true)
        end
    })
end

return M
