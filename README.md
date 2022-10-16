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

By default the following configuration will apply: 

```lua
require('s3edit').setup({
    exclude = { ".git" },
    autocommand_events = { "BufWritePost" },
}
```

Run Edit:

```lua
require('s3edit').edit() -- or :S3Edit
```

