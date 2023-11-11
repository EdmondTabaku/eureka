local M = {}
local Popup = require('plenary.popup')

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
    local save = false

    if file then
        for _, line in ipairs(notes) do
            if save then
                file:write(line .. '\n')
            elseif line == '--------------------------------------------------------------------' then
                save = true
            end
        end
        file:close()
    end
end

function M.display(default_notes, close_key)

    closer_key = close_key or 'q'

    -- Calculate the width and height of the floating window
    local width = math.floor(vim.o.columns * 0.6)
    local height = math.floor(vim.o.lines * 0.6)

    -- Calculate the window position
    local col = math.floor((vim.o.columns - width) / 2)
    local row = math.floor((vim.o.lines - height) / 2)

    -- Buffer and window options
    local buff = vim.api.nvim_create_buf(false, true)

    -- Set up default notes buffer
    local lines = {}
    for _, note in ipairs(default_notes) do
        table.insert(lines, note)
    end

    -- Set up user notes buffer
    table.insert(lines, '--------------------------------------------------------------------')

    for _, note in ipairs(load_notes()) do
        table.insert(lines, note)
    end

    vim.api.nvim_buf_set_lines(buff, 0, -1, false, lines)
    vim.api.nvim_buf_set_option(buff, 'modifiable', true)

    local win_id, win = Popup.create(lines, {
        title = "Eureka", -- Title of the window
        line = math.floor((vim.o.lines - height) / 2), -- Center the window
        col = math.floor((vim.o.columns - width) / 2),
        minwidth = width,
        minheight = height,
        borderchars = {
            '─', '│', '─', '│', '╭', '╮', '╯', '╰'
        },
    })

    local buff = vim.api.nvim_win_get_buf(win_id)
    vim.api.nvim_buf_set_option(buff, 'modifiable', true)

    -- Set cursor position to the last line
    vim.api.nvim_win_set_cursor(win_id, {#lines, 0})

    -- Map 'q' to close the window
    vim.api.nvim_buf_set_keymap(buff, 'n', close_key, '', {
        noremap = true,
        silent = true,
        callback = function()
            save_notes(vim.api.nvim_buf_get_lines(buff, 1, -1, false))
            vim.api.nvim_win_close(win_id, true)
        end
    })
end

return M
