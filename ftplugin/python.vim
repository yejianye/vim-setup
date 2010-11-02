setlocal completeopt=menuone,preview
setlocal omnifunc=python_complete#Complete
setlocal makeprg=python\ %
nmap <buffer> <leader>et :call pyunit#edit_unit_test()<CR>
nmap <buffer> <leader>rt :call pyunit#run_unit_test()<CR>
"setlocal autoindent
"setlocal smartindent
"setlocal nocindent
vmap <buffer> <Leader>cb <esc>:'<,'>s/^/#/<cr>:noh<cr>
vmap <buffer> <Leader>cn <esc>:'<,'>s/^#//<cr>:noh<cr>

nmap <buffer> <Leader>rr <esc>:w<cr>:!python %<cr>

let b:match_words = '\<if\>:\<elif\>:\<else\>,\<try\>:\<except\>'
