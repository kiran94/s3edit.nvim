run:
	nvim --cmd "set rtp+=./" --cmd 'lua require("s3edit").setup()' -o lua/s3edit/init.lua

test:
	nvim --cmd "set rtp+=./" --headless -c "PlenaryBustedDirectory lua/tests/ { minimal_init = 'lua/tests/setup.vim' }"
