local mock = require("luassert.mock")
local sys = require("s3edit.system")

describe("make_system_call", function()
    it("should call system", function()
        local mock_command = "my command"
        local mock_result = "my result"

        local mocked_handle = {
            read = function()
                return mock_result
            end,
            close = function() end,
        }

        local io_mock = mock(io, true)
        io_mock.popen.returns(mocked_handle)

        local result = sys.make_system_call(mock_command)

        assert.are.same(mock_result, result)
        assert.stub(io_mock.popen).was_called_with(mock_command)
    end)

    it("should return nil when failure", function()
        local mock_command = "my command"

        local io_mock = mock(io, true)
        io_mock.popen.returns(nil)

        local result = sys.make_system_call(mock_command)
        assert.are.same(nil, result)

        assert.stub(io_mock.popen).was_called_with(mock_command)
    end)
end)

describe("make_temp_file", function()
    it("should create temp file", function()
        local mock_result = "my result"

        local mocked_handle = {
            read = function()
                return mock_result
            end,
            close = function() end,
        }

        local io_mock = mock(io, true)
        io_mock.popen.returns(mocked_handle)

        local result = sys.make_system_call("mktemp")

        assert.are.same(mock_result, result)
        assert.stub(io_mock.popen).was_called_with("mktemp")
    end)
end)
