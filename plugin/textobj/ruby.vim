if exists('g:loaded_textobj_ruby')
  finish
endif
let g:loaded_textobj_ruby = 1

let s:save_cpo = &cpo
set cpo&vim

call textobj#user#plugin('ruby', {
            \ 'any' : {
            \      'select-a' : 'arr', '*select-a-function*': 'textobj#ruby#any_select_a',
            \      'select-i' : 'irr', '*select-i-function*': 'textobj#ruby#any_select_i',
            \   },
            \ })


let &cpo = s:save_cpo
unlet s:save_cpo
