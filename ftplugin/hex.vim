let b:filename = bufname("%")

function! HexLoadPythonFunctions()
python << EOF
import vim, re, struct, sys
def hexAddComma(val):
    val = str(val)
    val = val[::-1]
    val = re.sub(r'(\d\d\d)(?=\d)',r'\1,',val)
    val = val[::-1]
    return val

def hexGetBuffers():
    bufnr1 = int(vim.eval('v:beval_bufnr'))
    buf1 = filter(lambda x: x.number == bufnr1, vim.buffers)[0]
    buflist = vim.eval('tabpagebuflist()')
    if len(buflist) != 2:
        return [buf1]
    else: 
        buflist = map(int, buflist)
        bufnr2 = filter(lambda x: x != bufnr1, buflist)[0]
        buf2 = filter(lambda x: x.number == bufnr2, vim.buffers)[0]
        if (re.search('.hex$',buf2.name)):
            return [buf1, buf2]
        else:
            return [buf1]

def hexGetValue(buf, row, col, mode):
    line = buf[row-1];
    addrEx = re.compile('^([0-9a-f]*: *)');
    addr = addrEx.search(line).group(1)
    line = addrEx.sub('',line)
    line = re.sub('  .*$','',line)
    col -= len(addr)
    if col < 0 or col > 40: return None
    addr = re.sub(': *','',addr)
    addr = eval('0x'+addr)
    if (mode == 'dword'):
        offset = col / 10
        addr += offset * 4
        data = line.split(' ')
        hexVal = data[2*offset] + data[2*offset+1]
        hexVal = re.sub('(..)(..)(..)(..)',r'0x\4\3\2\1',hexVal)
        val = eval(hexVal)
    else:
        offset = col / 5
        addr += offset * 2
        data = line.split(' ')
        hexVal = data[offset]
        hexVal = re.sub('(..)(..)',r'0x\2\1',hexVal)
        val = eval(hexVal)
    return [addr, val]

def hexToFp(val):
    return struct.unpack('f', struct.pack("I", val))[0]
    
def hexBalloonExpr(mode):
    buflist = hexGetBuffers()
    buf1 = buflist[0]
    row = int(vim.eval('v:beval_lnum'))
    col = int(vim.eval('v:beval_col'))
    try:
        (addr, val1) = hexGetValue(buf1, row, col, mode)
    except:
        return
    fval1 = hexToFp(val1)
    if len(buflist) == 1:
        print "addr: 0x%x  val: 0x%x/%s/%g" % (addr, val1, hexAddComma(val1), fval1)
    else:
        buf2 = buflist[1]
        (addr, val2) = hexGetValue(buf2, row, col, mode)
        fval2 = hexToFp(val2)
        valDiff = val1 - val2
        fvalDiff = fval1 - fval2
        print "addr: 0x%x  val: %d/%s/%g  ref: %d/%s/%g  diff: %s/%g" % \
            (addr, val1, hexAddComma(val1), fval1, \
            val2, hexAddComma(val2), fval2, \
            hexAddComma(valDiff), fvalDiff)
EOF
endfunction

function! HexBalloonExprDWORD()
    python hexBalloonExpr('dword')
    return []
endfunction

function! HexBalloonExprWORD()
    python hexBalloonExpr('word')
    return []
endfunction

function! ConvertHexToBinary()
    let binary=substitute(b:filename, ".hex$", "", "")
    let cmd = 'silent !/usr/bin/xxd -r '.b:filename.' > '.binary
    exec(cmd)
endfunction

call HexLoadPythonFunctions()
setlocal bexpr=HexBalloonExprDWORD()
setlocal ballooneval
command! -buffer ShowWord :setlocal bexpr=HexBalloonExprWORD()
command! -buffer ShowDword :setlocal bexpr=HexBalloonExprDWORD()

autocmd BufWritePost *.hex call ConvertHexToBinary()
