#!/bin/sh
find . -type f -name '*.vim' > tag_files
find bundle/textobj_function/test -type f >> tag_files
echo '.vimrc_common' >> tag_files

