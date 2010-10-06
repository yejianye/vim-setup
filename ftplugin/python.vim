setlocal completeopt=menuone,preview
setlocal omnifunc=python_complete#Complete
setlocal makeprg=python\ %
"setlocal autoindent
"setlocal smartindent
"setlocal nocindent
vmap <buffer> <Leader>cb <esc>:'<,'>s/^/#/<cr>:noh<cr>
vmap <buffer> <Leader>cn <esc>:'<,'>s/^#//<cr>:noh<cr>

nmap <buffer> <Leader>rr <esc>:w<cr>:!python %<cr>

let b:match_words = '\<if\>:\<elif\>:\<else\>,\<try\>:\<except\>'
