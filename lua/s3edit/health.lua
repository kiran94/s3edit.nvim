local M = {}

M.check = function()
    vim.health.report_start("s3edit.nvim")

    local executable = "aws"
    local is_executable = vim.fn.executable(executable) > 0

    if is_executable then
        vim.health.report_ok(executable .. " found!")
        vim.health.report_info("make sure it is configured. You can check this by running: aws s3 ls")
    else
        vim.health.report_error(executable .. " is either not installed or is not within path")
    end
end

return M
