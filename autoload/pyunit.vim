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

function! s:run_test(filename, pattern)
	call DechoSystem("nosetests --match='" . a:pattern . "' " . a:filename)
endfunction

"Name            Stmts   Miss  Cover   Missing
"---------------------------------------------
"apps/ce6/user     291    153    47%   32-36, 84, 88-90, 94-96, 100-102, 106-108, 112-114, 117-118, 128, 132, 139-142, 146-149, 153-157, 161-165, 172, 174, 180-184, 187, 190, 193, 199-200, 204, 208, 212, 216, 238-249, 252-258, 264, 274-275, 278-283, 286-292, 295-296, 299-310, 313-319, 340-342, 347-352, 355-357, 360-366, 384, 392, 398-400, 403-405, 408-410, 414-418, 421-423, 426-427, 431-432, 435-443
function! s:run_coverage(unittest, sourcefile)
	exec "silent !coverage run " . a:unittest
	let report = system("coverage report --include='" . a:sourcefile . "' -m")
	let rlines = split(report, '\n')
	for l in rlines
		call Decho(l)
	endfor
	exec 'b ' . a:sourcefile
	exec '1,$MarkLinesOff'
	let missing_lines = substitute(rlines[2], '.*[0-9]% *', '', '')
	let missing_groups = split(missing_lines, ', ')
	for group in missing_groups
		if group =~ '-'
			let line_range = split(group, '-')
			exec line_range[0] . ',' . line_range[1] . 'MarkLinesOn ErrorMsg'
		else
			exec group . 'MarkLinesOn ErrorMsg'
		endif
	endfor
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
	elseif search('import unittest', 'w') != 0 || search('^def test_') != 0
		call s:run_test(expand('%'), '^test')
	else
		echo "Can't find the unit test."
	endif
endfunction

function! pyunit#run_test_file_with_coverage()
	call s:run_coverage(s:get_unit_test_filename(), expand('%'))
endfunction

function! pyunit#run_test_function(function_name)
	call s:run_test(expand('%'), '^' . a:function_name . '$')
endfunction

