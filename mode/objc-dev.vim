nmap ,xr :silent !open ~/.vim/xcode/run.app<CR>
nmap ,xd :silent !open ~/.vim/xcode/debug.app<CR>
nmap ,xb :silent !open ~/.vim/xcode/build.app<CR>
nmap ,ma :wa<CR>:make<CR>

command! -nargs=1 XcodeSDK :call s:SetXcodeSDK(<q-args>)
cab xsdk XcodeSDK
command! -nargs=1 XcodeConfig :let g:xconfig=<q-args>
cab xcon XcodeConfig
let g:xsdk = 'iphonesimulator3.0'
let g:xconfig = 'Debug'
function! s:SetXcodeSDK(sdk)
    if a:sdk == 'sim'
        let g:xsdk = 'iphonesimulator3.0'
    endif
    if a:sdk == 'dev'
        let g:xsdk = 'iphoneos3.0'
    endif
endfunction

"find definition of a message
command! -nargs=1 FindMessage :call s:FindDefinition(<q-args>)
nmap <C-]> :FindMessage <C-R>=expand("<cword>")<CR><CR>
function! s:FindDefinition(message)
    let cmd = "vimgrep '[+-].*".a:message."' **/*.m"
    exec cmd
endfunction

