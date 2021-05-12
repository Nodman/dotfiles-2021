local cmd = vim.cmd

cmd('command! Scratch lua require"utils".makeScratch()')
cmd('command! Wipe %bd|e#"')
