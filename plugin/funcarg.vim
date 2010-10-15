" This plugin will show function argument list in preview window
" Author: Ryan Ye
" Date: 2009-12-27
"
function! g:close_func_arg_win()
	let curbuf = bufname('%')
	let funcarg_win = bufwinnr('__funcarg__')
	if funcarg_win > -1
		exec funcarg_win . 'wincmd w'
		close
		exec bufwinnr(curbuf) . 'wincmd w'
	endif
endfunction

function! g:show_func_arg()
	let save_cursor = getpos(".")
	let line = getline('.')
	let line = strpart(line, 1, save_cursor[2])
	let offset = strridx(line, '(') - 1
	if offset < 0
		return
	endif
	call setpos('.', [save_cursor[0], save_cursor[1], offset, 0])
	let funcname = expand("<cword>")
	call s:function_argument(funcname)
	call setpos('.', save_cursor)
endfunction

function! s:function_argument(funcname)
	let curbuf = bufname('%')
	let curext = fnamemodify(expand('%'), ':e')
	let funcarg_win = bufwinnr('__funcarg__')
	if funcarg_win == -1
		if bufnr('__funcarg__') == -1
			" create buffer and window
			topleft sp __funcarg__
			set buftype=nofile
			set winfixheight
		else
			" create window
			topleft sb __funcarg__
			set winfixheight
		endif
	else
		exec funcarg_win . 'wincmd w'
	endif
	"set highlight
	syn match funcInfoArgs "(.*)"
	syn match funcInfoFilename "\[\[.*\]\]"
	hi def link funcInfoArgs Identifier
	hi def link funcInfoFilename Comment

	let func_info_list = []
	let func_info_list2 = []
	let func_info = {}
	for func_info in taglist('^' . a:funcname . '$')
		let def = substitute(func_info['cmd'], '.*'.func_info['name'], func_info['name'], '')
		let def = substitute(def, '[^)]*$', '', '')
		if def != '' 
			let ext = fnamemodify(func_info['filename'], ':e')
			if ext == curext
				call add(func_info_list, def . "  " . '[[' .func_info['filename'] . ']]')
			else
				call add(func_info_list2, def . "  " . '[[' .func_info['filename'] . ']]')
			endif
		endif
	endfor
	call extend(func_info_list, func_info_list2)
	silent %d
	if (len(func_info_list) == 0)
		call setline(1, 'No match function found')
	else
		call setline(1, func_info_list)
	endif
	"clear func argument info buffer
	if len(func_info_list) < 15
		exec 'resize '.len(func_info_list)
	else
		exec 'resize 15'
	endif
	"go back to original position
	exec bufwinnr(curbuf) . 'wincmd w'
endfunction
