"        My Keybindings----

" Don't use Ex mode, use Q for formatting.
" Revert with ":unmap Q".
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
" Revert with ":iunmap <C-U>".
inoremap <C-U> <C-G>u<C-U>

" Better keybinding Esc in insert mode
inoremap <Esc> <Esc><Esc>
inoremap <C-c> <Esc><Esc>

" Deals with search highlighting for me
nnoremap <silent><Esc> :noh<CR><ESC>

" Keybinding for opening a new line in normal mode
nnoremap <leader><CR> i<CR><Esc>

" Keybinding for deleting a line in normal mode
nnoremap <leader><BS> dd

" Keybinding for opening terminal
nnoremap <leader>' :terminal<CR>

" Keybinding for Toggling Netrw
nnoremap <C-n> :ToggleNetrw<CR>

" Keybinding for Toggling UndoTree -- put in plugs/undotree.vim
nnoremap <leader>u :UndotreeToggle<CR>

" LSP navigation
nnoremap <leader>sl :LspDocumentSymbolSearch<CR>

" Keymaps for buffer-tabs
nnoremap <silent> <Tab> :bnext!<CR>
nnoremap <silent> <S-Tab> :bprevious!<CR>
" nnoremap <silent> <leader>d :bdelete! %<CR>

" Write map for <leader>e that lists buffers and prompts for a buffer number and on keypress switches to that buffer
nnoremap <silent> <leader>e :buffers<CR>:b!<Space>
nnoremap <silent> <leader>q :buffers<CR>:bd!<Space>

" Auto-expands braces
inoremap (; (<CR>);<Esc>O
inoremap (, (<CR>),<Esc>O
inoremap {; {<CR>};<Esc>O
inoremap {, {<CR>},<Esc>O
inoremap [; [<CR>];<Esc>O
inoremap [, [<CR>],<Esc>O

inoremap {<CR> {<CR>}<Esc>O

" Keybindings for navigation
nnoremap <silent> <S-w> b
vnoremap <silent> <S-w> b

" Keybinding for quicksaving
nnoremap <silent> <C-s> :update<CR>
inoremap <silent> <C-s> <Esc>:update <CR>
vnoremap <silent> <C-s> <Esc>:update <CR>

vnoremap <silent> K :m '<-2<CR>gv=gv
vnoremap <silent> J :m '>+1<CR>gv=gv

" Jump up the file lines
nnoremap <silent> <C-q> <C-u>
vnoremap <silent> <C-q> <C-u>

" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" Treat long lines as break lines (useful when moving around in them)
nmap j gj
nmap k gk
vmap j gj
vmap k gk

" Keymap for repeating ':' commands
nnoremap <silent> <leader>; :<Up><CR>

tnoremap <C-\> <C-\><C-n>| " Enter normal mode
