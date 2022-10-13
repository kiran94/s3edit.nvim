local M = {}

M.get_file_extension = function(file)
    return file:match("^.+(%..+)$")
end

M.trim = function(s)
    return s:match("^%s*(.-)%s*$")
end

return M
