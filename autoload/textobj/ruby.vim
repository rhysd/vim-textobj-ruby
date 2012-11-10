if exists('g:textobj_ruby_loaded')
    finish
endif
let g:textobj_ruby_loaded = 1

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

function! s:search_edge(block, indent, head)
    let syntax = s:syntax_from_block(a:block)
    while 1
        let line = search('\<'.(a:head ? a:block : 'end').'\>', 
                    \ (a:head ? 'bW' : 'W'))
        if line == 0 || syntax == ''
            throw 'not found'
        endif
        if indent('.') < a:indent &&
                    \ syntax ==# s:syntax_highlight(line)
            return line
        endif
    endwhile
endfunction

" @args
"   @block : name of the block(e.g. module,if,do,begin and so on)
" @return  : the line numbers of head and tail of the block
function! textobj#ruby#search_block(block)
    let pos = getpos('.')
    let indent = indent('.')
    try
        let head = s:search_edge(a:block, indent, 1)
        call setpos('.', pos)
        let tail = s:search_edge(a:block, indent, 0)
        return [head, tail]
    catch /^not found$/
        echohl Error | echo 'block is not found.' | echohl None
        call setpos('.', pos)
        return 0
    endtry
endfunction

function! textobj#ruby#search_any_block()
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
    return textobj#ruby#search_block(block)
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
