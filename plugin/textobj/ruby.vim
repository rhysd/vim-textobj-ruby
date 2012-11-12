if exists('g:loaded_textobj_ruby_plugin')
  finish
endif
let g:loaded_textobj_ruby_plugin = 1

let s:save_cpo = &cpo
set cpo&vim

call textobj#user#plugin('ruby', {
       \
       \ 'any' : {
       \      'select-a' : 'arr', '*select-a-function*' : 'textobj#ruby#any_select_a',
       \      'select-i' : 'irr', '*select-i-function*' : 'textobj#ruby#any_select_i',
       \   },
       \
       \ 'module' : {
       \      'select-a' : 'arm', '*select-a-function*' : 'textobj#ruby#object_block_select_a',
       \      'select-i' : 'irm', '*select-i-function*' : 'textobj#ruby#object_block_select_i',
       \   },
       \
       \ 'loop' : {
       \      'select-a' : 'arl', '*select-a-function*' : 'textobj#ruby#loop_block_select_a',
       \      'select-i' : 'irl', '*select-i-function*' : 'textobj#ruby#loop_block_select_i',
       \   },
       \
       \ 'control' : {
       \      'select-a' : 'arc', '*select-a-function*' : 'textobj#ruby#control_block_select_a',
       \      'select-i' : 'irc', '*select-i-function*' : 'textobj#ruby#control_block_select_i',
       \   },
       \
       \ 'do' : {
       \      'select-a' : 'ard', '*select-a-function*' : 'textobj#ruby#do_block_select_a',
       \      'select-i' : 'ird', '*select-i-function*' : 'textobj#ruby#do_block_select_i',
       \   },
       \ })


let &cpo = s:save_cpo
unlet s:save_cpo
