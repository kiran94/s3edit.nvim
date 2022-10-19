run:
	nvim --cmd "set rtp+=./" --cmd 'lua require("s3edit").setup()' -o lua/s3edit/init.lua

test:
	nvim --cmd "set rtp+=./" --headless -c "PlenaryBustedDirectory lua/tests/ { minimal_init = 'lua/tests/setup.vim' }"

help:
	nvim --cmd "set rtp+=./" --cmd 'h s3edit'

update_doc:
	md2vim README.md doc/s3edit.txt

install_deps:
	# used to convert markdown to vimdoc
	go install foosoft.net/projects/md2vim@latest
