# S3Edit.nvim

[![main](https://github.com/kiran94/s3edit.nvim/actions/workflows/main.yaml/badge.svg)](https://github.com/kiran94/s3edit.nvim/actions/workflows/main.yaml)

> Edit files from S3 directly from Neovim

## Install

```lua
use 'kiran94/s3edit.nvim' 
```

### Dependencies

- [`aws`](https://github.com/aws/aws-cli) in your `PATH` and configured
- Neovim 0.8+

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

### Similar

- [s3-edit](https://github.com/tsub/s3-edit)
