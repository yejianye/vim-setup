function! s:LoadProject()
    let dir=getcwd()
    while strlen(dir) > 0
        if filereadable(dir . '/.load_project.vim')
            exec "source ".dir. '/.load_project.vim'
            return
        endif
        let dir = substitute(dir, "/[^/]*$", "", "")
    endwhile
endfunction
call <SID>LoadProject()
