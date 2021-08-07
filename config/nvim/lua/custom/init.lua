local M = {}

-- If the current file has been opened before, try to jump to the
-- last cursor position the editor was at. If there are fewer
-- lines than remembered, it jumps to the end instead
function M.jump_to_last_position()
    local previous_position = vim.fn.line("'\"")

    if previous_position > 0 then
        local max_line_nr = vim.fn.line("$")

        if previous_position < max_line_nr then
            vim.cmd("normal '\"")
        else
            vim.cmd("normal $")
        end
    end
end

-- It's very inconvenient to use the ^ motion (first non blank)
-- in a intl keyboard with dead keys. This functions acts as
-- a "smart" wrapper that flip-flops between ^ or 0, depending
-- on the cursor position.
function M.caret_or_zero()
    -- select what's between the cursor and the beginning of the line
    local linepart = vim.fn.strpart(vim.fn.getline('.'), -1, vim.fn.col('.'))

    -- Are there only whitespace characters in it?
    if string.match(linepart, "^%s+$") then
        vim.cmd("normal! 0")
    else
        vim.cmd("normal! ^")
    end
end


return M
