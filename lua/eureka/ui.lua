local M = {}
local Popup = require("plenary.popup")

-- NOTE: The user notes shouldn't just sit in the home folder or whereever nvim is opened.
local filename = vim.fn.stdpath("data") .. "/eureka_notes.txt"

local function load_notes()
    local notes = {}
    local file = io.open(filename, "r")

    if file then
        for line in file:lines() do
            table.insert(notes, line)
        end
        file:close()
    end

    return notes
end

local function save_notes(notes)
    local file = io.open(filename, "w")
    local save = false

    -- TODO: The user defined notes should be contained in a variable, e.g. M._user_notes
    -- so there is no need for this separator
    if file then
        for _, line in ipairs(notes) do
            if save then
                file:write(line .. "\n")
            elseif line == "--------------------------------------------------------------------" then
                save = true
            end
        end
        file:close()
    end
    -- vim.print(vim.g.eureka_user_notes)
end

function M.display(notes, close_key)
    -- Calculate the width and height of the floating window
    local width = math.floor(vim.o.columns * 0.6)
    local height = math.floor(vim.o.lines * 0.6)

    -- Set up default notes
    local popup_contents = notes

    -- Set up user notes
    table.insert(popup_contents, "--------------------------------------------------------------------")
    for _, note in ipairs(load_notes()) do
        table.insert(popup_contents, note)
    end

    local win_id, _ = Popup.create(popup_contents, {
        title = "Eureka", -- Title of the window
        line = math.floor((vim.o.lines - height) / 2), -- Center the window
        col = math.floor((vim.o.columns - width) / 2),
        minwidth = width,
        minheight = height,
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    })

    local buff = vim.api.nvim_win_get_buf(win_id)
    vim.api.nvim_set_option_value("modifiable", true, { buf = buff })

    -- Set cursor position to the last line
    vim.api.nvim_win_set_cursor(win_id, { #popup_contents, 0 })

    -- Map 'q' to close the window
    vim.api.nvim_buf_set_keymap(buff, "n", close_key, "", {
        noremap = true,
        silent = true,
        callback = function()
            save_notes(vim.api.nvim_buf_get_lines(buff, 1, -1, false))
            vim.api.nvim_win_close(win_id, true)
        end,
    })
end

return M
