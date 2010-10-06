"javascript function textobj 
onoremap <buffer> <silent>af :<c-u>cal JsFuncObj(0)<CR>
onoremap <buffer> <silent>if :<C-u>cal JsFuncObj(1)<CR>
vnoremap <buffer> <silent>af :<C-u>cal JsFuncObj(0)<CR><Esc>gv
vnoremap <buffer> <silent>if :<C-u>cal JsFuncObj(1)<CR><Esc>gv
nnoremap <buffer> <silent> [m mp:cal JsFuncObj(1)<CR><Esc>'p'<
nnoremap <buffer> <silent> ]m mp:cal JsFuncObj(1)<CR><Esc>'p'>

function! JsFuncObj(inner)
	let curline = line(".")
	let startline = line("$") + 1
	let endline = -1
	let maxdepth = 4
	let depth = 0
	while curline < startline || curline > endline
		let prevstart = startline
		?function
		normal! $
		normal! F{
		let startline = line(".")
		if startline > prevstart
			return
		endif
		normal! %
		let endline = line(".")
		exec string(startline)
		normal! 0
	endwhile
	let startline = a:inner ? startline + 1 : startline
	let endline = a:inner ? endline - 1 : endline
	exec string(startline)
	normal! 0V
	while line(".") < endline 
		+
	endwhile
endfunction
