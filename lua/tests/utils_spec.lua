local utils = require("s3edit.utils")

describe("get_file_extensions", function()
    local get_file_extension_cases = {
        ["hello.json"] = ".json",
        ["something_else.json"] = ".json",
        ["with.dot.json"] = ".json",
        ["hello.csv"] = ".csv",
        ["hello.txt"] = ".txt",
        ["hello.html"] = ".html",
        ["path/jelly.json"] = ".json",
        ["/path/jelly.json"] = ".json",
    }

    for filename, ext in pairs(get_file_extension_cases) do
        it("should get the file extension " .. filename, function()
            local result = utils.get_file_extension(filename)
            assert.are.same(ext, result)
        end)
    end
end)

describe("trim", function()
    local trim_cases = {
        ["temp.json "] = "temp.json",
        [" temp.json"] = "temp.json",
        [" temp.json "] = "temp.json",
        ["/path/temp.json"] = "/path/temp.json",
        [" /path/temp.json"] = "/path/temp.json",
        [" /path/temp.json "] = "/path/temp.json",
    }

    for input, output in pairs(trim_cases) do
        it("should trim whitespace: " .. input, function()
            local actual = utils.trim(input)
            assert.are.same(output, actual)
        end)
    end
end)
