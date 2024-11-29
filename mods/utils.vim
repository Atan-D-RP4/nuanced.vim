function! s:CCR()
    if getcmdtype() isnot# ':'
        return "\<CR>"
    endif

    let l:cmdline = getcmdline()

    " Dictionary of patterns and their corresponding actions
    let l:patterns = {
        \ '^\s*\(ls\|files\|buffers\)!\?\s*\(\s[+\-=auhx%#]\+\)\?$': "\<CR>:b",
        \ '\v/(#|nu%[mber])$': "\<CR>:",
        \ '^\s*\(dli%[st]\|il%[ist]\)!\?\s\+\S': function('s:HandleListJump'),
        \ '^\s*\(cli\|lli\)%[st]!\?\s*\(\s\d\+\(,\s*\d\+\)\?\)\?$': function('s:HandleErrorList'),
        \ '^\s*ol%[dfiles]\s*$': function('s:HandleOldFiles'),
        \ '^\s*changes\s*$': function('s:HandleChanges'),
        \ '^\s*ju%[mps]': function('s:HandleJumps'),
        \ '^\s*marks\s*\(\s\w\+\)\?$': "\<CR>:norm! `",
        \ '^\s*undol%[ist]': "\<CR>:u ",
        \ '\C^reg': "\<CR>:norm! \"p\<Left>"
    \ }

    for [l:pattern, l:Action] in items(l:patterns)
        if l:cmdline =~# l:pattern
            if type(l:Action) == type(function('tr'))
                return l:Action(l:cmdline)
            elseif type(l:Action) == type('')
                return l:Action
            endif
        endif
    endfor

    return "\<c-]>\<CR>"
endfunction

" Helper functions for complex actions
function! s:HandleListJump(cmdline)
    let l:parts = split(a:cmdline, " ")
    return printf("\<CR>:%sj  %s\<S-Left>\<Left>", a:cmdline[0], l:parts[1])
endfunction

function! s:HandleErrorList(cmdline)
    return printf("\<CR>:sil %s \<Space>", repeat(a:cmdline[0], 2))
endfunction

function! s:HandleOldFiles(cmdline)
    set nomore
    return "\<CR>:sil se more|e #<"
endfunction

function! s:HandleChanges(cmdline)
    set nomore
    return "\<CR>:sil se more|norm! g;\<S-Left>"
endfunction

function! s:HandleJumps(cmdline)
    set nomore
    return "\<CR>:sil se more|norm! \<C-o>\<S-Left>"
endfunction

" Mapping to use the function
cnoremap <expr> <CR> <SID>CCR()

" Tries to make <CR> a little smarter in insert mode:
" - expands [{()}] 'correctly'
" - expands <tag>|</tag> 'correctly'
" - removes empty comment marker
function! <SID>ICR()
    " specific case: beware of the cmdline window
    if &buftype ==# "quickfix" || &buftype ==# "nofile"
        return "\<CR>"
    endif

    " specific case: <CR><CR> to get out of commenting
    if getline(".") =~ '^\s*\(\*\|//\|#\|"\)\s*$'
        return "\<C-u>"
    endif

    " generic case
    let previous = getline(".")[col(".")-2]
    let next     = getline(".")[col(".")-1]

    if previous ==# "{"
        return <SID>PairExpander(previous, "}", next)
    elseif previous ==# "["
        return <SID>PairExpander(previous, "]", next)
    elseif previous ==# "("
        return <SID>PairExpander(previous, ")", next)
    elseif previous ==# ">"
        return <SID>TagExpander(next)
    else
        return "\<CR>"
    endif
endfunction

function! s:PairExpander(left, right, next)
    let pair_position = []

    if a:left == "["
        let pair_position = searchpairpos('\' . a:left, "", '\' . a:right, "Wn")
    else
        let pair_position = searchpairpos(a:left, "", a:right, "Wn")
    endif

    if a:next !=# a:right && pair_position[0] == 0
        return "\<CR>" . a:right . "\<C-o>==O"
    elseif a:next !=# a:right && pair_position[0] != 0 && indent(pair_position[0]) != indent(".")
        return "\<CR>" . a:right . "\<C-o>==O"
    elseif a:next ==# a:right
        return "\<CR>\<C-o>==O"
    else
        return "\<CR>"
    endif
endfunction

function! s:TagExpander(next)
    let thisline = getline(".")

    if a:next ==# "<" && thisline[col(".")] ==# "/"
        if thisline[searchpos("<", "bnW")[1]] ==# "/" || thisline[searchpos("<", "bnW")[1]] !=# thisline[col(".") + 1]
            return "\<CR>"
        else
            return "\<CR>\<C-o>==O"
        endif
    else
        return "\<CR>"
    endif
endfunction

inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-r>=<SID>ICR()\<CR>"
