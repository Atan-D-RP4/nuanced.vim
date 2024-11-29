let wiki_cmds = [ 'VimwikiVar', 'VimwikiIndex' ]
" Wiki Plugin   
Plug 'vimwiki/vimwiki', { 'for': 'vimwiki', 'on': wiki_cmds }

let g:vimwiki_list = [{'path': '~/Notes/', 'syntax': 'markdown', 'ext': 'md'}]
let g:vimwiki_global_ext = 0
let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown'}
