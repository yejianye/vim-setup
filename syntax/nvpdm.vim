syntax clear
set iskeyword=a-z,A-Z,[,]
syn match bigTitle /NVPDM Test Comparison Report/
syn match summary /Performance Summary/
syn match overall /overall counts/ 
syn match unitdetails /Unit Details/
syn match unitsTitle /====.*===/
syn match sectionTitle /---.*---/
syn match diff /[+-]\?[1][0-9]\.[0-9]*%/
syn match bigdiff /[+-]\?[2-4][0-9]\.[0-9]*%/
syn match hugediff1 /[+-]\?[5-9][0-9]\.[0-9]*%/
syn match hugediff2 /[+-]\?[0-9]\{3,\}\.[0-9]*%/
syn match hugediff3 /Infinity%/
hi HtmlLink term=underline cterm=underline ctermfg=4
hi def link bigTitle Define
hi def link summary Statement
hi def link overall Comment
hi def link unitdetails  Comment
hi def link unitsTitle  Define
hi def link sectionTitle  Statement
hi def link diff  Constant
hi def link bigdiff Define
hi def link hugediff1 Error
hi def link hugediff2 Error
hi def link hugediff3 Error

let b:current_syntax = "nvpdm"

