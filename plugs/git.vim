" Git Fugitive
Plug 'tpope/vim-fugitive', {'on': ['Git']}

nnoremap <silent> <leader>gg :Git<CR>
nnoremap <silent> <leader>gg :Git status<CR>

" Git Gutter
Plug 'airblade/vim-gitgutter'

nnoremap <silent> <leader>hs :GitGutterStageHunk<CR>
nnoremap <silent> <leader>hu :GitGutterUndoHunk<CR>
