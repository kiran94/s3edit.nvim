local M = {}

M.get_file_extension = function(file)
    return file:match("^.+(%..+)$")
end

M.trim = function(s)
    if s == nil then
        return ""
    end

    return s:match("^%s*(.-)%s*$")
end

--- Filters the passed items with any of the expressions passed in excludes
M.filter = function(items, excludes)
    return vim.tbl_filter(function(o)
        for _, token in ipairs(excludes) do
            if o:match(token) then
                return false
            end
        end

        return true
    end, items)
end

return M
