run:
	nvim --cmd "set rtp+=./" --cmd 'lua require("s3edit").setup()' -o lua/s3edit/init.lua
