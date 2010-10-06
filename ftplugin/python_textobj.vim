"python function textobj 
onoremap <buffer> <silent>af :<c-u>cal PyFuncObj(0)<CR>
onoremap <buffer> <silent>if :<C-u>cal PyFuncObj(1)<CR>
vnoremap <buffer> <silent>af :<C-u>cal PyFuncObj(0)<CR><Esc>gv
vnoremap <buffer> <silent>if :<C-u>cal PyFuncObj(1)<CR><Esc>gv
nnoremap <buffer> <silent> [m mp:cal PyFuncObj(1)<CR><Esc>'p'<
nnoremap <buffer> <silent> ]m mp:cal PyFuncObj(1)<CR><Esc>'p'>

function! PyFuncObj(inner)
	let lastline = line("$")
	"search back to find def
	while line(".") > 1 && getline(".") !~ '^\s*def.*'
		 -
	endwhile
	if getline(".") !~ '^\s*def.*'
		return
	endif
	let funcIndent = indent(line("."))
	if (a:inner)
		 +
		 normal! 0V
	else
		 normal! 0V
	endif
	let funcEnd = 0
	while !funcEnd && line(".")  < lastline
		 +
		let funcEnd = getline(line(".")+1) !~ '^\s*$' && indent(line(".")+1) <= funcIndent
	endwhile
endfunction
