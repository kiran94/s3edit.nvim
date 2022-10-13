local M = {}

--- Makes a call into the underlying operating system
--- and reads the response
---@param command string the command to run
---@return string|nil result result of the command
M.make_system_call = function(command)
    local handle = io.popen(command)
    if handle == nil then
        vim.notify("could not run command " .. command)
        return nil
    end

    local result = handle:read("*a")
    handle:close()
    return result
end

--- Creates a temporary file on the operating system
---@return string|nil the path to the file
M.make_temp_file = function()
    return M.make_system_call("mktemp")
end

return M
