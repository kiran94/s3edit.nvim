local M = {}
local s3 = require("s3edit.s3")

M.autogroup_name = "S3Edit"

--- Creates an Autocommand that will upload a file back to s3 upon the given command(s)
---@param command string|table a single command or list of commands
---@param bucket string the bucket on s3 to upload into
---@param key string the key on s3 to upload into
---@param target_file string the local file path to upload to s3
M.create_upload_s3_autocommand = function(command, bucket, key, target_file)
    vim.api.nvim_create_autocmd(command, {
        pattern = target_file,
        group = M.autogroup_name,
        desc = "Uploads file contents back to S3",
        callback = function()
            s3.put_object(bucket, key, target_file)
        end,
    })
end

M.create_group = function()
    vim.api.nvim_create_augroup(M.autogroup_name, {})
end

return M
