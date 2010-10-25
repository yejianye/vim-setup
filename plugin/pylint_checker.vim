command! -nargs=0 PylintFull :call <SID>CheckWithPylint(expand('%'), 'all')
command! -nargs=0 Pylint :call <SID>CheckWithPylint(expand('%'), 'error')
let g:pylint_cfg_filename = '~/.pylintrc'
function! s:CheckWithPylint(filename, level)
	let output_filename='~/.pylint_output'	
	let pylint_cmd = 'pylint --output-format=parseable --reports=n '
	let pylint_cmd_error = 'pylint --output-format=parseable --reports=n -E '
	let rcfile = ''
	if filereadable(g:pylint_cfg_filename)
		let rcfile = ' --rcfile=' . g:pylint_cfg_filename . ' '
	endif
	if a:level == 'all'
		let cmd = '!' . pylint_cmd . rcfile . a:filename . ' > ' . output_filename
	elseif a:level == 'error'
		let cmd = '!' . pylint_cmd_error . rcfile . a:filename . ' > ' . output_filename
	endif
	exec cmd
	exec 'cfile ' . output_filename
	botright cwindow
	redraw!
endfun	
