if exists("b:do_objc_init") 
	finish
endif
let b:do_objc_init = 1

setlocal number
setlocal autoindent
setlocal smartindent
setlocal cindent
set tags=tags,/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS3.0.sdk/System/Library/Frameworks/tags

function! s:MakeProject()
    let orgdir=getcwd()
    let dir=orgdir
    while isdirectory(dir)
        if filereadable(dir . '/Makefile')
            exec "cd ".dir
            exec "make SDK=".g:xsdk." CONFIG=".g:xconfig
            exec "cd ".orgdir
            return
        endif
        let dir = dir . "/.."
    endwhile
endfunction

vnoremap <buffer> <silent> ,cc <ESC><ESC>:'<,'>s%^%//%<CR>
vnoremap <buffer> <silent> ,co <ESC><ESC>:'<,'>s%^//%%<CR>
nnoremap <buffer> <silent> ,cc :s%^%//%<CR>
nnoremap <buffer> <silent> ,co :s%^//%%<CR>

nnoremap <buffer> ,ma :wa<CR>:call <SID>MakeProject()<CR>
