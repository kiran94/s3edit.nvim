local mock = require("luassert.mock")

describe("s3edit_select_object", function()
    local s3 = require("s3edit.s3")
    local auto = require("s3edit.autocommand")
    local sys = require("s3edit.system")
    local plugin_settings = require("s3edit.settings")

    local s3edit = require("s3edit")

    it("downloads an object to a temp file and opens for edit", function()
        local selected_bucket = "my_bucket"
        local selected_object = "my_object.json"
        local mock_temp_file = "/tmp/tmp.K8WbznR4yS"

        local mock_sys = mock(sys, true)
        mock_sys.make_temp_file.returns(mock_temp_file)

        local mock_s3 = mock(s3, true)
        mock_s3.download_object.returns({})

        local mock_auto = mock(auto, true)
        mock_auto.create_upload_s3_autocommand.returns({})

        s3edit.setup({ autocommand_events = { "DUMMY" } })
        s3edit._select_object(selected_bucket, selected_object)

        local mocked_temp_file = mock_temp_file .. ".json"

        assert.stub(mock_s3.download_object).was_called_with(selected_bucket, selected_object, mocked_temp_file)

        assert
            .stub(mock_auto.create_upload_s3_autocommand)
            .was_called_with({ "DUMMY" }, selected_bucket, selected_object, mocked_temp_file)
    end)
end)
