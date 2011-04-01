function! s:get_unit_test_filename()
	let pos = search('# *unittest:', 'w')
	if pos == 0
		return ''
	endif
	let line = getline('.')
	let filename = substitute(line, '# *unittest: *', '', '') 
	let filename = expand('%:p:h') . '/' . filename
	return filename
endfunction

function! s:run_test(filename, pat)
	call DechoSystem("nosetests --match='" . a:pat . "' " . a:filename)
endfunction

function! pyunit#edit_unit_test()
	let filename = s:get_unit_test_filename()
	if filename != ''
		exec 'e '. filename
	endif
endfunction

function! pyunit#run_test_file()
	" if current buffer is a unittest file, run it directly
	" Otherwise, find the unittest and run it
	if search('# *unittest:', 'w') != 0
		call s:run_test(s:get_unit_test_filename(), '^test')
	elseif search('import unittest', 'w') != 0
		call s:run_test(expand('%'), '^test')
	else
		echo "Can't find the unit test."
	endif
endfunction

function! pyunit#run_test_function(function_name)
	call s:run_test(expand('%'), '^' . a:function_name . '$')
endfunction

