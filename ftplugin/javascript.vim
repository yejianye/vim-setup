"Javascript Tailing comma check for IE 7.0
au! BufWritePost *.js call CheckTailComma()
function! CheckTailComma()
	let error_line = search(',\n*\s*}', 'w')
	if error_line > 0
		echo 'Tailing comma found at line ' . error_line . ' in ' . bufname('%')
	endif
endfunction

