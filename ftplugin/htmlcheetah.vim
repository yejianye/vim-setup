runtime! ftplugin/html.vim
let b:match_words = b:match_words . ',#if:#elif:#else:#end if,#for:#end for,#def:#end def' 
setlocal autoindent
setlocal iskeyword=a-z,A-Z,48-57,_,#
