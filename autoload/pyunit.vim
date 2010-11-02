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

function! pyunit#edit_unit_test()
	let filename = s:get_unit_test_filename()
	if filename != ''
		exec 'e '. filename
	endif
endfunction

function! pyunit#run_unit_test()
	" if current buffer is a unittest file, run it directly
	" Otherwise, find the unittest and run it
	let errorfile = tempname()
	if search('# *unittest:', 'w') != 0
		call DechoSystem('python ' . s:get_unit_test_filename())
	elseif search('import unittest', 'w') != 0
		call DechoSystem('python ' . expand('%'))
	else
		echo "Can't find the unit test."
	endif
endfunction
