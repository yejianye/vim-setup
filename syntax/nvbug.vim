syntax clear
set iskeyword=a-z,A-Z,[,]
syn match nvbugFieldName /\[\[BugID\]\]\|\[\[RequesterFullName\]\]\|\[\[Synopsis\]\]\|\[\[Module\]\]\|\[\[Severity\]\]\|\[\[Disposition\]\]\|\[\[BugAction\]\]\|\[\[ARBFullName\]\]\|\[\[Description\]\]\|\[\[AuthorFullName\]\]\|\[\[Comment\]\]\|\[\[ApplicationDivision\]\]\|\[\[BugType\]\]\|\[\[DuplicateBugs\]\]\|\[\[EngineerFullName\]\]\|\[\[QAEngineerFullName\]\]\|\[\[CCFullName\]\]/
syn match nvbugHeaderField /Bug ID:\|Requester:\|Date:\|Synopsis:\|Module:\|Severity:\|Priority:\|Engineer:\|Disposition:\|QA Engineer:\|Bug Action:\|Action Req By:/
syn match nvbugSectionTitle /Description:\|New Comment:\|Comments:/
syn match nvbugCommentTitle /^[0-9]*-[0-9]*-[0-9]* [0-9]*:[0-9]*:[0-9]*.*/
syn region nvbugPre start=/<nv:pre>/ end=/<\/nv:pre>/
syn match nvbugSeperator /----------------------*/
syn match nvbugTestdesc /^[0-9]\+ [a-zA-Z0-9_]\+#[a-z0-9]\+.*/ contains=nvbugTestname
syn match nvbugTestname /[a-zA-Z0-9_]\+#[a-z0-9]\+/ contained
syn match nvbugLink /http:\/\/\S*/
hi HtmlLink term=underline cterm=underline ctermfg=4
hi def link nvbugFieldName Statement
hi def link nvbugHeaderField Identifier
hi def link nvbugSectionTitle Comment
hi def link nvbugCommentTitle Constant
hi def link nvbugSeperator Identifier
hi def link nvbugPre Include
hi def link nvbugTestdesc Statement
hi def link nvbugTestname Identifier
hi def link nvbugLink HtmlLink
let b:current_syntax = "nvbug"

