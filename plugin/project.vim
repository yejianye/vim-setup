function! s:LoadProjectSettings()
    let dir=getcwd()
    while strlen(dir) > 0
        if filereadable(dir . '/project.vim')
            exec "source ".dir. '/project.vim'
            return
        endif
        let dir = substitute(dir, "/[^/]*$", "", "")
    endwhile
endfunction
call <SID>LoadProjectSettings()
