setlocal completeopt=menuone,preview
setlocal makeprg=python\ %
nmap <buffer> <leader>et :call pyunit#edit_unit_test()<CR>
nmap <buffer> <leader>rt :call pyunit#run_test_file()<CR>
nmap <buffer> <leader>tf :call pyunit#run_test_function('<C-R>=expand('<cword>')<CR>')<CR>
nmap <buffer> <leader>li :Pylint<CR>
nmap <buffer> <leader>lf :PylintFull<CR>
"setlocal autoindent
"setlocal smartindent
"setlocal nocindent
vmap <buffer> <Leader>cb <esc>:'<,'>s/^/#/<cr>:noh<cr>
vmap <buffer> <Leader>cn <esc>:'<,'>s/^#//<cr>:noh<cr>

nmap <buffer> <Leader>rr <esc>:w<cr>:call RunPythonScript()<cr>
nmap <buffer> <Leader>ra <esc>:w<cr>:call RunPythonWithArgs()<cr>

let b:match_words = '\<if\>:\<elif\>:\<else\>,\<try\>:\<except\>'
let b:run_args = ''

function! RunPythonWithArgs()
	let b:run_args = input('arguments:', b:run_args)
	call RunPythonScript()
endfunction

function! RunPythonScript()
	exec '!python ' . bufname('%') . ' ' . b:run_args
endfunction
