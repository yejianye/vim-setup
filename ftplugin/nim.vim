nmap <buffer> <Leader>rr <esc>:w<cr>:call RunNim()<cr>
nmap <buffer> <Leader>ra <esc>:w<cr>:call RunNimWithArgs()<cr>

let b:run_args = ''

function! RunNimWithArgs()
	let b:run_args = input('arguments:', b:run_args)
	call RunNim()
endfunction

function! RunNim()
	exec '!nim compile --run ' . bufname('%') . ' ' . b:run_args
endfunction
