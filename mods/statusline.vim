"" -*- mode: vimrc; +indent: 2 -*- Statusline theme -- Adapted from [[https://www.reddit.com/r/vim/comments/ld8h2j/i_made_a_status_line_from_scratch_no_plugins_used/][u/SamLovesNotion]]
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" This is my custom statusline theme, using colors adapted from [[https://github.com/mohkale/an-old-hope-theme][an-old-hope]]
" and a style reminiscent of my [[https://github.com/mohkale/emacs][emacs]] mode-line.
"
" This theme expects you to have:
" - Nerd Fonts installed and enabled (See the [[https://github.com/ryanoasis/vim-devicons][vim-devicons]] plugin)
" - The StatusLine and StatusLineNC highlight groups setup with bold variants
"   StatusLineBold and StatusLineNCBold
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"" Statusline
set laststatus=2                                                                " Enable statusline
set lazyredraw

"" Color highlighting groups
" Define color scheme for the GUI, we use the equivalent term ANSI
" colors when running in the terminal (See [[https://jonasjacek.github.io/colors/][colors]]).
let g:StslineColorGreen     = '#78bd65' " term=2
let g:StslineColorTurquoise = '#67e4c5' " term=6
let g:StslineColorBlue      = '#4fb3d8' " term=12
let g:StslineColorViolet    = '#ba78ab' " term=234
let g:StslineColorYellow    = '#eead0e' " term=214
let g:StslineColorOrange    = '#ee7b29' " term=208
let g:StslineColorRed       = '#ea3d54' " term=167
let g:StslineColorBlack     = '#1c1d20' " term=167
let g:StslineColorWhite     = '#cbccd1' " term=15
let g:StslineColorGrey      = '#44464f' " term=236

" Configures the left most part of the statusline showing the current
" evil state.
let g:StsLineModeFgDark     = 1
let g:StsLineVimModeColor   = g:StslineColorYellow
let g:StsLineVimModeTermColor = '214'

" Create highlight groups
execute 'highlight StsVimMode guifg=' . g:StslineColorBlack . ' ctermfg=234' . ' guibg=' . g:StsLineVimModeColor . ' ctermbg=' . g:StsLineVimModeTermColor

" Update colors. Recreate highlight groups with new Primary color values
function! UpdateStslineColors()
  execute 'highlight StsVimMode guifg=' . (g:StsLineModeFgDark?g:StslineColorBlack:g:StslineColorBlack) . ' ctermfg=' . (g:StsLineModeFgDark?'234':'15') . ' guibg=' . g:StsLineVimModeColor . ' ctermbg=' . g:StsLineVimModeTermColor
endfunction

" Format fileformat in the same way as emacs.
function! StsLineFileFormat()
  let l:ff = &fileformat
  if l:ff==#'unix'
     let l:ff = 'LF'
  endif
  return toupper(l:ff)
endfunction

" Taken from [[https://vi.stackexchange.com/a/14521][here]], converts a byte count to a humand readable string
function! HumanSize(bytes) abort
    let l:bytes = a:bytes
    let l:sizes = ['', 'k', 'm', 'g', 't']
    let l:i = 0
    while l:bytes >= 1024
        let l:bytes = l:bytes / 1024.0
        let l:i += 1
    endwhile
    if l:bytes < 0
        let l:bytes = 0
    endif
    return printf('%.0f%s', l:bytes, l:sizes[l:i])
endfunction

" Define active statusline
function! ActivateStatusline()
  setlocal statusline=%#StsVimMode#\ %{StslineMode()}\ %#StatusLine#\ %{HumanSize(line2byte('$')\ +\ len(getline('$')))}\ [%{&readonly?\"%\":&modified?\"*\":\"-\"}]\ %#StatusLineBold#%f%#StatusLine#%(%{get(b:,'coc_git_status',get(b:,'gitbranch',''))}%{get(b:,'coc_git_blame','')}%)%=%#StatusLineMeta#%a%(\ %h%w%)%#StatusLine#\ %{StsLineFileFormat()}\ %{toupper(&encoding)}\ %l:%v\ %p%%\ %#StatusLineBold#%(%{&filetype}\ %)%#StatusLine#
endfunction

" Define Inactive statusline
function! DeactivateStatusline()
  setlocal statusline=%#StsVimMode#\ %{StslineMode()}\ %#StatusLineNC#\ %{HumanSize(line2byte('$')\ +\ len(getline('$')))}\ [%{&readonly?\"%\":&modified?\"*\":\"-\"}]\ %#StatusLineNC#%F%#StatusLineNC#%=%#StatusLineNCMeta#%(\ %h%w%)%#StatusLineNC#\ %{StsLineFileFormat()}\ %{toupper(&encoding)}\ %l:%v\ %p%%\ %#StatusLineNC#%(%{&filetype}\ %)%#StatusLineNC#
endfunction

" Get Statusline mode & also set primary color for that that mode
function! StslineMode()
  let l:CurrentMode=mode()
  let g:StsLineModeFgDark = 1                                                             " The default

  if l:CurrentMode==#'n'
    let g:StsLineVimModeColor = g:StslineColorYellow
    let g:StsLineVimModeTermColor = '214'
    let b:CurrentMode = 'N'
  elseif l:CurrentMode==#'i'
    let g:StsLineVimModeColor = g:StslineColorGreen
    let g:StsLineVimModeTermColor = '2'
    let b:CurrentMode = 'I'
  elseif l:CurrentMode==#'c'
    let g:StsLineVimModeColor=g:StslineColorBlue
    let g:StsLineVimModeTermColor = '12'
    let b:CurrentMode = '●'
  elseif l:CurrentMode==#'v' || l:CurrentMode==#'V' || l:CurrentMode==#"\<C-v>"
    let g:StsLineVimModeColor = g:StslineColorGrey
    let g:StsLineVimModeTermColor = '236'
    let g:StsLineModeFgDark = 0
    let b:CurrentMode = 'V'
  elseif l:CurrentMode==#'R'
    let g:StsLineVimModeColor = g:StslineColorViolet
    let g:StsLineVimModeTermColor = '234'
    let b:CurrentMode = 'R'
  elseif l:CurrentMode==#'s'
    let g:StsTurquoise = g:StslineColorViolet
    let g:StsLineVimModeTermColor = '6'
    let b:CurrentMode = 'S'
  elseif l:CurrentMode==#'t'
    let g:StsTurquoise = g:StslineColorBlue
    let g:StsLineVimModeTermColor = '12'
    let b:CurrentMode = '!'
  elseif l:CurrentMode==#'!'
    let g:StsTurquoise = g:StslineColorBlue
    let g:StsLineVimModeTermColor = '12'
    let b:CurrentMode = '!'
  elseif expand('%:y') == 'help'
    let g:StsTurquoise = g:StslineColorViolet
    let g:StsLineVimModeTermColor = '6'
    let b:CurrentMode = '!'
  endif

  call UpdateStslineColors()

  return b:CurrentMode
endfunction

" Get git branch name
function! GetGitBranch()
  let b:gitbranch=""
  try
    let l:dir=expand('%:p:h')
    let l:gitrevparse = system("git -C ".l:dir." rev-parse --abbrev-ref HEAD")
    if !v:shell_error
      let b:gitbranch="   ".substitute(l:gitrevparse, '\n', '', 'g')
    endif
  catch
  endtry
endfunction

" Get git branch name after entering a buffer
augroup GetGitBranch
  autocmd!
  autocmd BufEnter * call GetGitBranch()
augroup END

" Set active / inactive statusline after entering, leaving buffer
augroup SetStslineline
  autocmd!
  autocmd BufEnter,WinEnter * call ActivateStatusline()
  autocmd BufLeave,WinLeave * call DeactivateStatusline()
augroup END

" Tabline
set showtabline=2                                                               " Enable tabline
" Color definition
let g:BufferlineColorGreen     = '#78bd65'
let g:BufferlineColorYellow    = '#eead0e'
let g:BufferlineColorRed       = '#ea3d54'
let g:BufferlineColorBlack     = '#1c1d20'
let g:BufferlineColorWhite     = '#cbccd1'
let g:BufferlineColorGrey      = '#44464f'

" Create highlight groups
execute 'highlight BufferlineMode guifg=' . g:BufferlineColorBlack . ' ctermfg=234 guibg=' . g:BufferlineColorYellow . ' ctermbg=214'
execute 'highlight BufferlineActive guifg=' . g:BufferlineColorWhite . ' guibg=' . g:BufferlineColorBlack
execute 'highlight BufferlineInactive guifg=' . g:BufferlineColorGrey . ' guibg=' . g:BufferlineColorBlack
execute 'highlight BufferlineModified guifg=' . g:BufferlineColorRed . ' guibg=' . g:BufferlineColorBlack

" Truncate filename if too long
function! TruncateFilename(filename, max_length)
    if len(a:filename) > a:max_length
        return a:filename[:a:max_length-3] . '...'
    endif
    return a:filename
endfunction

" Get buffer display name
function! GetBufferDisplayName(bufnr)
    " If no name, return [No Name]
    if empty(bufname(a:bufnr))
        return '[No Name]'
    endif

    " Get filename (tail)
    let filename = fnamemodify(bufname(a:bufnr), ':t')

    " Add directory hint for duplicate names
    if count(map(filter(range(1, bufnr('$')), 'buflisted(v:val)'), 'fnamemodify(bufname(v:val), ":t")'), filename) > 1
        let filename = fnamemodify(bufname(a:bufnr), ':h:t') . '/' . filename
    endif

    return filename
endfunction

" Custom bufferline rendering
function! CustomBufferLine()
    " List of listed buffers
    let bufnums = filter(range(1, bufnr('$')), 'buflisted(v:val)')

    " If no buffers, return empty
    if empty(bufnums)
        return ''
    endif

    let s:bufferline = ''

    " Iterate through buffers
    for bufnr in bufnums
        " Determine if this is the current buffer
        let is_current = bufnr == bufnr('%')

        " Highlight based on current buffer status
        let hl = is_current ? '%#TablineSel#' : '%#TablineNormal#'

        " Get filename
        let filename = TruncateFilename(GetBufferDisplayName(bufnr), 20)

        " Modified indicator
        let modified = getbufvar(bufnr, '&modified') ? '+ ' : ''

        " Construct buffer label
        let label = modified . filename

        " Add to bufferline with buffer switch command
        let s:bufferline .= hl . ' ' . label . ' '
    endfor

    " Fill remaining space
    let s:bufferline .= '%#TabLineFill#%='

    return s:bufferline
endfunction

" Set tabline to our custom buffer line
set tabline=%!CustomBufferLine()
set showtabline=2

" Optional configuration function (future-proofing)
function! BufferlineSetup(...)
    if a:0 > 0
        let g:bufferline_config = extend(get(g:, 'bufferline_config', {}), a:1)
    endif
endfunction

" Expose configuration command
command! -nargs=? BufferlineConfig call BufferlineSetup(<args>)
