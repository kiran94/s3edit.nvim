local M = {}

local s3 = require("s3edit.s3")
local auto = require("s3edit.autocommand")
local utils = require("s3edit.utils")
local sys = require("s3edit.system")
local plugin_settings = require("s3edit.settings")

local settings = {}

M.setup = function(user_settings)
    settings = plugin_settings.resolve(user_settings)
    auto.create_group()
    vim.cmd([[ command! S3Edit lua require('s3edit').edit() ]])
end

M._select_object = function(selected_bucket, selected_object)
    local temp_file = sys.make_temp_file()
    local ext = utils.get_file_extension(selected_object)

    ext = utils.trim(ext)
    temp_file = utils.trim(temp_file)

    temp_file = temp_file .. ext

    vim.notify("Downloading " .. selected_bucket .. "/" .. selected_object)
    s3.download_object(selected_bucket, selected_object, temp_file)

    vim.api.nvim_command("edit" .. temp_file)

    -- TODO: delete the temp files whenever nvim is closed?
    auto.create_upload_s3_autocommand(settings.autocommand_events, selected_bucket, selected_object, temp_file)
end

M.edit = function()
    local names = s3.get_bucket_names()

    vim.ui.select(names, { prompt = "select bucket" }, function(selected_bucket)
        local objects = s3.get_objects(selected_bucket)
        vim.ui.select(objects, { prompt = "select object" }, function(selected_object)
            M._select_object(selected_bucket, selected_object)
        end)
    end)
end

return M

-- -- TODO: Add configuration option for blacklisting files (exclude files)
-- vim.tbl_filter(function(o)
--     -- if o matches any of the patterns in settings.exclude then filter out
-- end, objects)
