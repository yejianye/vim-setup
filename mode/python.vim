command! -nargs=1 SearchDefinition :call s:SearchDefinition(<q-args>)
command! -nargs=1 SearchClass :call s:SearchClass(<q-args>)
cab sd SearchDefinition
cab sc SearchClass

function! s:SearchDefinition(method)
	exec 'grep "def '. a:method . '(" **/*.py'
endfunction

function! s:SearchClass(class)
	exec 'grep "class '. a:class . '(" **/*.py'
endfunction
