command! IPythonShellToggle call <SID>IPythonShellToggle()
command! IPythonShellFocus call <SID>IPythonShellFocus()

let s:ipython_bufname = ""
let s:ipython_winheight = 15
function! <SID>IPythonShellToggle()
	if s:ipython_bufname == "" || !bufexists(s:ipython_bufname)
		call s:IPythonShellNew()
	endif
	if bufwinnr(s:ipython_bufname) == -1
		exec "botright sb " . s:ipython_bufname
		exec "resize " . s:ipython_winheight
	else
		let s:ipython_winheight = winheight(bufwinnr(s:ipython_bufname))
		exec bufwinnr(s:ipython_bufname) . "wincmd w"
		:q
		stopinsert
	endif
endfunction

function! <SID>IPythonShellNew()
	:ConqueTermSplit ipython
	let s:ipython_bufname = bufname('%')
	:q
endfunction

function! <SID>IPythonShellFocus()
	if bufwinnr(s:ipython_bufname) > -1
		exec bufwinnr(s:ipython_bufname) . "wincmd w"
	else
		:call <SID>IpythonShellToggle()
	endif
endfunction
