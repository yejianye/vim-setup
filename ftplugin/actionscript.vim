nmap <leader>im :call g:GetImportString(expand('<cword>'))<CR>

function! g:GetImportString(className)
	for dir in g:asRoot
		let matched = system('find ' . dir . ' -name '. a:className . '.as')
		if matched == ''
			continue
		endif

		let mlist = split(matched, '\n')
		let mlist = map(mlist, 'substitute(v:val, dir . "/", "", "")')
		let mlist = map(mlist, 'substitute(v:val, "/", ".", "g")')
		let mlist = map(mlist, 'substitute(v:val, ".as$", "", "")')
		if len(mlist) == 1
			let classPath = mlist[0]
		else
			let choice = []
			let i = 1
			while i <= len(choice)
				let choice = choice + [ i . '. ' .mlist[i]]
			endwhile
			let selected = inputlist(choice)
			if selected == 0
				return
			endif
			let classPath = mlist[selected - 1]
		endif
		let importStatement = 'import '. classPath . ';'
		normal mp
		if search(importStatement, 'b') > 0
			normal 'p
			echo 'class already imported'
			return
		endif
		if search('^\s*import ', 'b') == 0
			call search('^\s*package', 'b')
		endif
		exec 'normal o' . importStatement
		normal 'p
		echo classPath
		return
	endfor
endfunction
