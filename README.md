# S3Edit.nvim

[![main](https://github.com/kiran94/s3edit.nvim/actions/workflows/main.yaml/badge.svg)](https://github.com/kiran94/s3edit.nvim/actions/workflows/main.yaml)

> Edit files from S3 directly from Neovim

## Install

```lua
{ 'kiran94/s3edit.nvim', config = true, cmd = "S3Edit"},
```

*using lazy.nvim*

### Dependencies

- [`aws`](https://github.com/aws/aws-cli) in your `PATH` and configured
- Neovim 0.8+

Once installed you can run a health check via `:checkhealth s3edit`

### Usage

Setup the plugin

```lua
require('s3edit').setup()
```

#### Configuration

By default the following configuration will apply:

```lua
require('s3edit').setup({
    exclude = { ".git", ".hoodie", ".parquet", ".zip" },
    autocommand_events = { "BufWritePost" },
}
```

| Option               | Description                              |
| -------              | -----------                              |
| `exclude`            | File paths to exclude from object search |
| `autocommand_events` | The event to fire updates to S3          |


#### Edit

```lua
require('s3edit').edit() -- or :S3Edit
```

### Preview

[![asciicast](https://asciinema.org/a/529113.svg)](https://asciinema.org/a/529113)

*NOTE: if you want to use telescope as your selector then take a look at [telescope-ui-select.nvim](https://github.com/nvim-telescope/telescope-ui-select.nvim)*

### Similar

- [s3-edit](https://github.com/tsub/s3-edit)
