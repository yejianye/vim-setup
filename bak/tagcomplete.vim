let s:cache = {}
let s:cache.key = ''
let s:cache.items = []
let s:cache.time = 0
function! tagcomplete#Complete(findstart, base)
	if a:findstart
		" locate the start of the word
		let line = getline('.')
		let start = col('.') - 1
		while start > 0 && line[start - 1] =~ '\k'
			let start -= 1
		endwhile
		let tag_files = tagfiles()
		let key = join(tag_files, "\n")
		"TODO: need add a timestamp
		if s:cache.key != key || max(map(copy(tag_files), 'getftime(v:val) >= s:cache.time'))
			let items = []
			for filename in tag_files
				let lines = readfile(filename)
				for line in lines
					let fields = split(line, '\t')
					let info  = substitute(line, "^[^\t]*\t[^\t]*\t/\^[\t ]*", "", "")
					let info = substitute(info, "\$/;.*", "", "")
					call add(items, {'tag':fields[0], 'filename':fields[1],'info':info})
				endfor
			endfor
			let s:cache = {'items':items, 'key':key, 'time':localtime()}
		endif
		return start
	else
		" find tags matching with "a:base"
		let result = []
		let matchlist = copy(s:cache.items)
		call filter(matchlist, 'v:val.tag =~ "' . '^' . a:base . '"')
		for matchtag in matchlist
			let item = {'word':matchtag.tag,  'menu':matchtag.filename,'info':matchtag.info, 'dup':1}
			call add(result, item)
		endfor
		return result
	endif
endfunc 
set completefunc=tagcomplete#Complete
