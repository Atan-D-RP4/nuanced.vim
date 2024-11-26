" List of ftplugins to load LSP for
let g:lsp_fts = ['javascript', 'typescript', 'typescriptreact',
            \ 'javascriptreact', 'json', 'yaml', 'html', 'css', 'scss', 'less',
            \ 'graphql', 'markdown', 'lua', 'python', 'rust', 'go', 'java', 'php',
            \ 'ruby', 'c', 'cpp', 'haskell', 'scala', 'kotlin', 'swift', 'dart',
            \ 'elixir', 'vim', 'sh', 'bash', 'zsh', 'dockerfile', 'plaintext']

" LSP and LanguageClient Plugins
Plug 'prabirshrestha/vim-lsp', { 'for': g:lsp_fts }
Plug 'mattn/vim-lsp-settings', { 'for': g:lsp_fts }

Plug 'prabirshrestha/asyncomplete.vim', { 'for': g:lsp_fts }
Plug 'prabirshrestha/asyncomplete-lsp.vim', { 'for': g:lsp_fts }

Plug 'sheerun/vim-polyglot'

" ALE
Plug 'dense-analysis/ale', { 'for': g:lsp_fts }
Plug 'rhysd/vim-lsp-ale', { 'for': g:lsp_fts }

let g:lsp_semantic_enabled = 1
let g:lsp_diagnostics_virtual_text_align = "after"
let g:lsp_use_event_queue = 1
let g:lsp_log_verbose = 1
let g:lsp_inlay_hints_enabled = 1
let g:lsp_log_file = expand('$XDG_DATA_HOME/vim/lsp.log')

if !filereadable(expand('$XDG_DATA_HOME/vim/lsp.log'))
  call writefile([], g:lsp_log_file)
endif

let g:lsp_log_file = expand('$XDG_DATA_HOME/vim/lsp.log')


let g:async_complete_min_chars = 3
let g:asyncomplete_auto_completeopt = 1

" LSP settings
function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal tagfunc=lsp#tagfunc
    setlocal signcolumn=yes
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
endfunction

augroup lsp_install
    au!
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
