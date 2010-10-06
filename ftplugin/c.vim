if exists("b:do_c_init") 
	finish
endif
let b:do_c_init = 1

setlocal number
setlocal autoindent
setlocal smartindent
setlocal cindent
setlocal iskeyword=a-z,A-Z,48-57,_
"Disable cErrInBracket for CTL
hi def link cErrInBracket	NONE 

function! g:printFunctionName()
    let function_header = search('^[a-z]','bn')
    if function_header != 0
        echo getline(function_header)
    else
        echo "Can't get function name"
    endif
endfunction

function! s:MakeProject()
    let orgdir=getcwd()
    let dir=orgdir
    while isdirectory(dir)
        if filereadable(dir . '/Makefile')
            exec "cd ".dir
            exec "make"
            exec "cd ".orgdir
            return
        endif
        let dir = dir . "/.."
    endwhile
endfunction

nmap <buffer> <silent> ,fn :call g:printFunctionName()<CR>
nmap <buffer> <silent> ,gf ?^[a-z]<CR>
vnoremap <buffer> <silent> ,cc <ESC><ESC>:'<,'>s%^%//%<CR>
vnoremap <buffer> <silent> ,co <ESC><ESC>:'<,'>s%^//%%<CR>
nnoremap <buffer> <silent> ,cc :s%^%//%<CR>
nnoremap <buffer> <silent> ,co :s%^//%%<CR>

nnoremap <buffer> ,ma :call <SID>MakeProject()<CR>
