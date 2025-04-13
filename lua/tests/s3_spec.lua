local mock = require("luassert.mock")
local sys = require("s3edit.system")
local s3 = require("s3edit.s3")

describe("get_bucket_names", function()
    it("should return empty when list buckets fails", function()
        local mock_sys = mock(sys, true)
        mock_sys.make_system_call.returns(nil)

        local result = s3.get_bucket_names()

        assert.are.same({}, result)
        assert.stub(mock_sys.make_system_call).was_called_with("aws s3api list-buckets --output json")
    end)

    it("should parse the bucket names", function()
        local mock_list_bucket_result = [[
        {
            "Buckets": [
                {
                    "Name": "bucket1",
                    "CreationDate": "2021-05-28T19:58:23.000Z"
                },
                {
                    "Name": "bucket2",
                    "CreationDate": "2021-05-28T19:58:24.000Z"
                }
            ],
            "Owner": {
                "ID": "id"
            }
        }
        ]]

        local mock_sys = mock(sys, true)
        mock_sys.make_system_call.returns(mock_list_bucket_result)

        local result = s3.get_bucket_names()

        assert.are.same("bucket1", result[1])
        assert.are.same("bucket2", result[2])
        assert.stub(mock_sys.make_system_call).was_called_with("aws s3api list-buckets --output json")
    end)
end)

describe("get_objects", function()
    it("should return empty when get objects fails", function()
        local mock_sys = mock(sys, true)
        mock_sys.make_system_call.returns(nil)

        local result = s3.get_objects("my_bucket")

        assert.are.same({}, result)
        assert.stub(mock_sys.make_system_call).was_called_with("aws s3api list-objects --bucket my_bucket --output json")
    end)

    it("should parse the objects", function()
        local mock_list_object_result = [[
        {
            "Contents": [
                {
                    "Key": "key1",
                    "LastModified": "2022-01-22T17:48:21.000Z",
                    "ETag": "etag",
                    "Size": 228,
                    "StorageClass": "STANDARD",
                    "Owner": {
                        "ID": "id"
                    }
                },
                {
                    "Key": "path/key2",
                    "LastModified": "2022-01-22T17:48:21.000Z",
                    "ETag": "etag",
                    "Size": 228,
                    "StorageClass": "STANDARD",
                    "Owner": {
                        "ID": "id"
                    }
                }
            ]
        }
        ]]

        local mock_sys = mock(sys, true)
        mock_sys.make_system_call.returns(mock_list_object_result)

        local result = s3.get_objects("my_bucket")

        assert.are.same("key1", result[1])
        assert.are.same("path/key2", result[2])
        assert.stub(mock_sys.make_system_call).was_called_with("aws s3api list-objects --bucket my_bucket --output json")
    end)

    it("should return empty when no objects are found", function()
        local mock_list_object_result = ""

        local mock_sys = mock(sys, true)
        mock_sys.make_system_call.returns(mock_list_object_result)

        local result = s3.get_objects("my_bucket")
        assert.are.same({}, result)

        assert.stub(mock_sys.make_system_call).was_called_with("aws s3api list-objects --bucket my_bucket --output json")
    end)
end)

describe("download_object", function()
    it("should make a s3 api get object system call", function()
        local mock_sys = mock(sys, true)
        mock_sys.make_system_call.returns({})

        local result = s3.download_object("my_bucket", "my_key", "outfile")

        assert.are.same({}, result)
        assert
            .stub(mock_sys.make_system_call)
            .was_called_with("aws s3api get-object --bucket my_bucket --key my_key outfile")
    end)
end)

describe("put_object", function()
    it("should make a s3 api put object system call", function()
        local mock_sys = mock(sys, true)
        mock_sys.make_system_call.on_call_with("aws s3api head-object --bucket my_bucket --key my_key --query ContentType --output text").returns('application/json')
        mock_sys.make_system_call.on_call_with('aws s3api put-object --bucket my_bucket --key my_key --body infile --content-type "application/json"').returns({})

        local result = s3.put_object("my_bucket", "my_key", "infile")

        assert.are.same({}, result)
        assert
            .stub(mock_sys.make_system_call)
            .was_called_with("aws s3api put-object --bucket my_bucket --key my_key --body infile --content-type application/json")
    end)
end)
