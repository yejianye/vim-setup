function! ConqueTermBindPasteKey(term)
    inoremap <buffer> <C-V> <esc>:call PasteFromSystemClipboard()<CR>
endfunction

function! PasteFromSystemClipboard()
    let terminal=conque_term#get_instance()
    call terminal.write(@*)
    startinsert
endfunction

if has('gui_macvim')
    call conque_term#register_function('after_startup', 'ConqueTermBindPasteKey')
endif

