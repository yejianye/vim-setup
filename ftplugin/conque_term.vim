if has('gui_macvim')
    inoremap <buffer> <C-V> <esc>:call <SID>PasteFromSystemClipboard()<CR>
endif

function! <SID>PasteFromSystemClipboard()
    let terminal=conque_term#get_instance()
    call terminal.write(@*)
    startinsert
endfunction
