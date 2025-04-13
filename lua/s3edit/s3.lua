local M = {}
local sys = require("s3edit.system")

--- Gets the Bucket Names from S3
---@return table a list of bucket names
M.get_bucket_names = function()
    local result = sys.make_system_call("aws s3api list-buckets --output json")
    if result == nil then
        return {}
    end

    result = vim.fn.json_decode(result)

    local names = {}
    for _, bucket in ipairs(result["Buckets"]) do
        table.insert(names, bucket["Name"])
    end

    return names
end

--- Gets the objects under the provided `bucket`
---@param bucket string the bucket to search
---@return table a list of objects
M.get_objects = function(bucket)
    local result = sys.make_system_call("aws s3api list-objects --bucket " .. bucket .. " --output json")
    if result == nil then
        return {}
    end

    if result == '' then
        vim.notify("No objects found within s3://" .. bucket)
        return {}
    end

    result = vim.fn.json_decode(result)

    local objects = {}
    for _, current_object in ipairs(result["Contents"]) do
        table.insert(objects, current_object["Key"])
    end

    return objects
end

M.download_object = function(bucket, key, outfile)
    return sys.make_system_call("aws s3api get-object --bucket " .. bucket .. " --key " .. key .. " " .. outfile)
end

local function get_content_type(bucket, key)
    local cmd = "aws s3api head-object --bucket " .. bucket .. " --key " .. key .. " --query ContentType --output text"
    local handle = io.popen(cmd)
    if not handle then return nil end

    local content_type = handle:read("*a")
    handle:close()

    return content_type:gsub("^%s+", ""):gsub("%s+$", "")
end

M.put_object = function(bucket, key, infile)
    local content_type = get_content_type(bucket, key)
    if not content_type or content_type == "" then
        vim.notify("Failed to retrieve Content-Type; aborting put-object.")
        return false
    end

    local cmd = "aws s3api put-object --bucket " .. bucket ..
                " --key " .. key ..
                " --body " .. infile ..
                " --content-type '" .. content_type .. "'"

    return sys.make_system_call(cmd)
end

return M
