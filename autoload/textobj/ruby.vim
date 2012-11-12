if exists('g:textobj_ruby_autoload_loaded')
    finish
endif
let g:textobj_ruby_autoload_loaded = 1

let s:save_cpo = &cpo
set cpo&vim

let s:syntax_table = [
            \ [['if', 'unless', 'case'],  'rubyConditional'],
            \ [['while', 'until', 'for'], 'rubyRepeat'],
            \ [['module'],                'rubyModule'],
            \ [['class'],                 'rubyClass'],
            \ [['do', 'begin'],           'rubyControl']
            \ ]

function! s:syntax_from_block(block)
    for [names, syntax] in s:syntax_table
        let idx = index(names, a:block)
        if idx >= 0
            return syntax
        endif
    endfor
    return ''
endfunction

function! s:syntax_highlight(line)
    return synIDattr(synID(a:line, col('.'),1), 'name')
endfunction

function! s:search_head(block, indent)
    while 1
        let line = search( '\<\%('.a:block.'\)\>', 'bW' )
        if line == 0
            throw 'not found'
        endif

        let syntax = s:syntax_from_block(expand('<cword>'))
        if syntax == ''
            throw 'not found'
        endif

        if indent('.') < a:indent &&
                    \ syntax ==# s:syntax_highlight(line)
            return [syntax, getpos('.')]
        endif
    endwhile
endfunction

function! s:search_tail(block, indent, syntax)
    while 1
        let line = search( '\<end\>', 'W' )
        if line == 0
            throw 'not found'
        endif

        if indent('.') < a:indent &&
                    \ a:syntax ==# s:syntax_highlight(line)
            return getpos('.')
        endif
    endwhile
endfunction

" TODO ブロックを正規表現で指定できるようにして，'module\|class' のように指定できるようにする
" @args
"   @block : name of the block(e.g. module,if,do,begin and so on)
" @return  : the line numbers of head and tail of the block
function! s:search_block(block)
    let indent = indent('.')
    let pos = getpos('.')
    try
        let [syntax, head] = s:search_head(a:block, indent)
        call setpos('.', pos)
        let tail = s:search_tail(a:block, indent, syntax)
        return ['V', head, tail]
    catch /^not found$/
        echohl Error | echo 'block is not found.' | echohl None
        call setpos('.', pos)
        return 0
    endtry
endfunction

function! s:search_any_block()
    let pos = getpos('.')
    let indent = indent('.')
    while 1
        if ! search('\<\%(if\|unless\|case\|while\|until\|for\|module\|class\|do\|begin\)\>', 'bW')
            return 0
        endif
        if indent('.') < indent && s:syntax_highlight(line('.')) !=# 'rubyString'
            break
        endif
    endwhile
    let block = expand('<cword>')
    call setpos('.', pos)
    return s:search_block(block)
endfunction

function! s:inside(range)
    " check if range exists
    if type(a:range) != type([]) || a:range[1][1]+1 > a:range[2][1]-1
        return 0
    endif

    " narrow range by 1 line on both sides
    let range = a:range
    let range[1][1] += 1
    let range[2][1] -= 1
    echo range

    return range
endfunction

" any block "{{{
function! textobj#ruby#any_select_i()
    return s:inside(s:search_block('if\|unless\|case\|while\|until\|for\|module\|class\|do\|begin'))
endfunction

function! textobj#ruby#any_select_a()
    return s:search_block('if\|unless\|case\|while\|until\|for\|module\|class\|do\|begin')
endfunction
"}}}

" select module "{{{
function! textobj#ruby#object_block_select_i()
    return s:inside(s:search_block('module\|class'))
endfunction

function! textobj#ruby#object_block_select_a()
    return s:search_block('module\|class')
endfunction
"}}}

" select loop "{{{
function! textobj#ruby#loop_block_select_i()
    return s:inside(s:search_block('while\|until\|for'))
endfunction

function! textobj#ruby#loop_block_select_a()
    return s:search_block('while\|until\|for')
endfunction
"}}}

" select control statement "{{{
function! textobj#ruby#control_block_select_i()
    return s:inside(s:search_block('do\|begin\|if'))
endfunction

function! textobj#ruby#control_block_select_a()
    return s:search_block('do\|begin\|if')
endfunction
"}}}

" select do block "{{{
function! textobj#ruby#do_block_select_i()
    return s:inside(s:search_block('do'))
endfunction

function! textobj#ruby#do_block_select_a()
    return s:search_block('do')
endfunction
"}}}

let &cpo = s:save_cpo
unlet s:save_cpo
