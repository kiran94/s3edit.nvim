local M = {}

local s3 = require("s3edit.s3")
local auto = require("s3edit.autocommand")
local utils = require("s3edit.utils")
local system = require("s3edit.system")

local settings = {}
local default_settings = {
    exclude = { ".git" },
    autocommand_events = { "BufWritePost" },
}

local resolve_settings = function(user_settings)
    user_settings = user_settings or {}
    settings = vim.tbl_extend("keep", user_settings, default_settings)
    return settings
end

M.setup = function(user_settings)
    settings = resolve_settings(user_settings)
    auto.create_group()
end

M.edit = function()
    local names = s3.get_bucket_names()

    vim.ui.select(names, { prompt = "select bucket" }, function(selected_bucket)
        local objects = s3.get_objects(selected_bucket)

        -- TODO: Add configuration option for blacklisting files (exclude files)
        -- for _, current_pattern in ipairs(settings.exclude) do
        --     for _, current_object in ipairs(objects) do
        --         -- if current_pattern matches current_object then skip from the output
        --     end
        -- end

        vim.tbl_filter(function(o)
            -- if o matches any of the patterns in settings.exclude then filter out
        end, objects)

        vim.ui.select(objects, { prompt = "select object" }, function(selected_object)
            local temp_file = system.make_temp_file()
            local ext = utils.get_file_extension(selected_object)

            ext = utils.trim(ext)
            temp_file = utils.trim(temp_file)
            temp_file = temp_file .. ext

            -- print("Downloading " .. selected_bucket .. "/" .. selected_object .. " -> " .. temp_file)

            s3.download_object(selected_bucket, selected_object, temp_file)

            vim.api.nvim_command("edit" .. temp_file)

            auto.create_upload_s3_autocommand(settings.autocommand_events, selected_bucket, selected_object, temp_file)
        end)
    end)
end

return M
