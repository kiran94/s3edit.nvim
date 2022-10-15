local mock = require("luassert.mock")
local autocommands = require("s3edit.autocommand")

describe("create_upload_s3_autocommand", function()
    it("should create an autocommand", function()
        local command = "BufWritePost"
        local bucket = "my_bucket"
        local key = "my_key"
        local target_file = "target_file"

        autocommands.create_group()
        autocommands.create_upload_s3_autocommand(command, bucket, key, target_file)

        local cmds = vim.api.nvim_get_autocmds({ group = autocommands.autogroup_name })

        assert.are.same("BufWritePost", cmds[1]["event"])
        assert.are.same(autocommands.autogroup_name, cmds[1]["group_name"])
        assert.are.same(target_file, cmds[1]["pattern"])
    end)
end)
