let g:fzf_cmds = [
      \ 'Files', 'GFiles', 'Buffers', 'Colors', 'Ag', 'Rg', 'RG', 'Lines', 'BLines', 'Tags', 'BTags', 
      \ 'Changes', 'Marks', 'Jumps', 'Windows', 'Locate', 'History', 'Snippets', 'Commits', 'BCommits', 
      \ 'Commands', 'Maps', 'Helptags', 'Filetypes'
      \ ]

Plug 'junegunn/fzf.vim', { 'on': g:fzf_cmds }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

if executable('rg')
  let g:fzf_command = 'rg --files -L' " Set fzf command to use ripgrep (optional)
endif

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

nnoremap <leader>ff	        :Files<CR>
nnoremap <leader>fd         :Buffers<CR>
nnoremap <leader>fg	        :Rg<CR>
nnoremap <leader>fm	        :Marks<CR>
nnoremap <leader>fo	        :History<CR>
nnoremap <leader>fk         :Maps<CR>
