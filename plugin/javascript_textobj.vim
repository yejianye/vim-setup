"javascript function textobj 
onoremap <buffer> <silent>af :<c-u>cal JsFuncObj(0)<CR>
onoremap <buffer> <silent>if :<C-u>cal JsFuncObj(1)<CR>
vnoremap <buffer> <silent>af :<C-u>cal JsFuncObj(0)<CR><Esc>gv
vnoremap <buffer> <silent>if :<C-u>cal JsFuncObj(1)<CR><Esc>gv
nnoremap <buffer> <silent> [m mp:cal JsFuncObj(1)<CR><Esc>'p'<
nnoremap <buffer> <silent> ]m mp:cal JsFuncObj(1)<CR><Esc>'p'>

function! JsFuncObj(inner)
	let curline = line(".")
	normal! ?function
	normal! $F{
	normal! F{
	let startline = a:inner ? line(".") + 1 : line(".")
	normal! %
	let endline = a:inner ? line(".") - 1 : line(".")
	exec string(startline)
	normal! 0V
	while line(".") < endline 
		+
	endwhile
endfunction
