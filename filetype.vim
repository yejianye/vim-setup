" my filetype file
if exists("did_load_filetypes")
  finish
endif
augroup filetypedetect
  au! BufNewFile,BufRead *.m setf objc
  au! BufNewFile,BufRead *.doctest setf python
  au! BufNewFile,BufRead *.as setf actionscript
  au! BufNewFile,BufRead *.md setf markdown
augroup END
