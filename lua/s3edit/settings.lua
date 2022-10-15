local M = {}

M.default_settings = {
    exclude = { ".git" },
    autocommand_events = { "BufWritePost" },
}

M.resolve = function(user_settings)
    user_settings = user_settings or {}
    local settings = vim.tbl_extend("keep", user_settings, M.default_settings)
    return settings
end

return M
