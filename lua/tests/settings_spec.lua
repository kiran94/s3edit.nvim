local settings = require("s3edit.settings")

describe("resolve", function()
    it("should provide default settings when empty is provided", function()
        local resolved = settings.resolve({})
        assert.are.same(settings.default_settings, resolved)
    end)

    it("should provide default settings when nil is provided", function()
        local resolved = settings.resolve(nil)
        assert.are.same(settings.default_settings, resolved)
    end)

    it("should override exclude when provided", function()
        local resolved = settings.resolve({
            exclude = { ".img" },
        })

        assert.are.same({ ".img" }, resolved.exclude)
        assert.are.same({ "BufWritePost" }, resolved.autocommand_events)
    end)

    it("should override autocommand_events when provided", function()
        local resolved = settings.resolve({
            autocommand_events = { "BufWritePre" },
        })

        assert.are.same({ ".git" }, resolved.exclude)
        assert.are.same({ "BufWritePre" }, resolved.autocommand_events)
    end)
end)
