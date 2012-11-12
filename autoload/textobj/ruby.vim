let s:save_cpo = &cpo
set cpo&vim

" helpers for syntax
function! s:syntax_from_block(block) "{{{
    for [syntax, names] in items({
                \   'rubyConditional' : ['if', 'unless', 'case'],
                \   'rubyRepeat'      : ['while', 'until', 'for'],
                \   'rubyModule'      : ['module'],
                \   'rubyClass'       : ['class'],
                \   'rubyControl'     : ['do', 'begin'],
                \ })
        if index(names, a:block) >= 0
            return syntax
        endif
    endfor
    return ''
endfunction

function! s:syntax_highlight(line)
    return synIDattr(synID(a:line, col('.'),1), 'name')
endfunction
"}}}

" implementation to seed head and tail position
function! s:search_head(block, indent) "{{{
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
"}}}

" search the block's head and tail positions
function! s:search_block(block) "{{{
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
"}}}

" narrow range by 1 line on both sides
function! s:inside(range) "{{{
    " check if range exists
    if type(a:range) != type([]) || a:range[1][1]+1 > a:range[2][1]-1
        return 0
    endif

    let range = a:range
    let range[1][1] += 1
    let range[2][1] -= 1
    echo range

    return range
endfunction
"}}}

" any block
function! textobj#ruby#any_select_i() " {{{
    return s:inside(s:search_block('if\|unless\|case\|while\|until\|for\|module\|class\|do\|begin'))
endfunction

function! textobj#ruby#any_select_a()
    return s:search_block('if\|unless\|case\|while\|until\|for\|module\|class\|do\|begin')
endfunction
"}}}

" select module
function! textobj#ruby#object_block_select_i() "{{{
    return s:inside(s:search_block('module\|class'))
endfunction

function! textobj#ruby#object_block_select_a()
    return s:search_block('module\|class')
endfunction
"}}}

" select loop
function! textobj#ruby#loop_block_select_i() " {{{
    return s:inside(s:search_block('while\|until\|for'))
endfunction

function! textobj#ruby#loop_block_select_a()
    return s:search_block('while\|until\|for')
endfunction
"}}}

" select control statement
function! textobj#ruby#control_block_select_i() " {{{
    return s:inside(s:search_block('do\|begin\|if'))
endfunction

function! textobj#ruby#control_block_select_a()
    return s:search_block('do\|begin\|if')
endfunction
"}}}

" select do block
function! textobj#ruby#do_block_select_i() " {{{
    return s:inside(s:search_block('do'))
endfunction

function! textobj#ruby#do_block_select_a()
    return s:search_block('do')
endfunction
"}}}

let &cpo = s:save_cpo
unlet s:save_cpo
