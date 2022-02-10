" File:        todo.txt.vim
" Description: Todo.txt filetype detection
" Author:      Nick Murphy <comfortablynick@gamil.com>, David Beniamine <David@Beniamine.net>, Leandro Freitas <freitass@gmail.com>
" License:     Vim license
" Website:     http://github.com/comfortablynick/todo.txt-vim

" General options {{{1
" Some options lose their values when window changes. They will be set every
" time this script is invoked, which is whenever a file of this type is
" created or edited.
setlocal textwidth=0
setlocal wrapmargin=0

" Increment and decrement the priority use <C-A> and <C-X> on alpha
setlocal nrformats+=alpha

" Mappings {{{1
" <Plug> mappings that users can map alternate keys to {{{2
" if they choose not to map default keys (or otherwise)
nnoremap <silent> <buffer> <Plug>(TodotxtIncrementDueDateNormal) :<C-u>call <SID>ChangeDueDateWrapper(1, "\<Plug>(TodotxtIncrementDueDateNormal)")<CR>
vnoremap <silent> <buffer> <Plug>(TodotxtIncrementDueDateVisual) :call <SID>ChangeDueDateWrapper(1, "\<Plug>(TodotxtIncrementDueDateVisual)")<CR>
nnoremap <silent> <buffer> <Plug>(TodotxtDecrementDueDateNormal) :<C-u>call <SID>ChangeDueDateWrapper(-1, "\<Plug>(TodotxtDecrementDueDateNormal)")<CR>
vnoremap <silent> <buffer> <Plug>(TodotxtDecrementDueDateVisual) :call <SID>ChangeDueDateWrapper(-1, "\<Plug>(TodotxtDecrementDueDateVisual)")<CR>

noremap  <silent> <buffer> <Plug>(TodotxtMarkAsDone) :call todo#ToggleMarkAsDone()<CR>
    \:call repeat#set("\<Plug>(TodotxtMarkAsDone)", v:count)<CR>

noremap  <silent> <buffer> <Plug>(TodotxtIncrementPriority) :call todo#PrioritizeIncrease()<CR>
    \:call repeat#set("\<Plug>(TodotxtIncrementPriority)", v:count)<CR>
noremap  <silent> <buffer> <Plug>(TodotxtDecrementPriority) :call todo#PrioritizeDecrease()<CR>
    \:call repeat#set("\<Plug>(TodotxtDecrementPriority)", v:count)<CR>

" Default key mappings {{{2
if !get(g:, 'Todo_txt_do_not_map', 0)
    " Sort todo by (first) context {{{3
    noremap  <buffer> <LocalLeader>sc  <Cmd>call todo#HierarchicalSort('@', '', 1)<CR>
    noremap  <buffer> <LocalLeader>scp <Cmd>call todo#HierarchicalSort('@', '+', 1)<CR>

    " Sort todo by (first) project {{{3
    noremap  <buffer> <LocalLeader>sp  <Cmd>call todo#HierarchicalSort('+', '',1)<CR>
    noremap  <buffer> <LocalLeader>spc <Cmd>call todo#HierarchicalSort('+', '@',1)<CR>

    " Sort tasks {{{3
    nnoremap <buffer> <LocalLeader>s <Cmd>call todo#Sort("")<CR>
    nnoremap <buffer> <LocalLeader>s@ <Cmd>call todo#Sort("@")<CR>
    nnoremap <buffer> <LocalLeader>s+ <Cmd>call todo#Sort("+")<CR>

    " Priorities {{{3
    nmap     <buffer> <LocalLeader>k <Plug>(TodotxtIncrementPriority)
    nmap     <buffer> <LocalLeader>j <Plug>(TodotxtDecrementPriority)

    noremap  <buffer> <LocalLeader>a <Cmd>call todo#PrioritizeAdd('A')<CR>
    noremap  <buffer> <LocalLeader>b <Cmd>call todo#PrioritizeAdd('B')<CR>
    noremap  <buffer> <LocalLeader>c <Cmd>call todo#PrioritizeAdd('C')<CR>

    " Insert date {{{3
    if get(g:, 'TodoTxtUseAbbrevInsertMode', 0)
        inoreabbrev <script> <silent> <buffer> date: <C-R>=strftime("%Y-%m-%d")<CR>

        inoreabbrev <script> <silent> <buffer> due: due:<C-R>=strftime("%Y-%m-%d")<CR>
        inoreabbrev <script> <silent> <buffer> DUE: DUE:<C-R>=strftime("%Y-%m-%d")<CR>
    else
        inoremap <script> <silent> <buffer> date<Tab> <C-R>=strftime("%Y-%m-%d")<CR>

        inoremap <script> <silent> <buffer> due: due:<C-R>=strftime("%Y-%m-%d")<CR>
        inoremap <script> <silent> <buffer> DUE: DUE:<C-R>=strftime("%Y-%m-%d")<CR>
    endif

    noremap  <buffer> <LocalLeader>d <Cmd>call todo#PrependDate()<CR>

    " Mark done {{{3
    nmap     <buffer> <LocalLeader>x <Plug>(TodotxtMarkAsDone)

    " Mark all done {{{3
    noremap  <buffer> <LocalLeader>X <Cmd>call todo#MarkAllAsDone()<CR>

    " Remove completed {{{3
    nnoremap <buffer> <LocalLeader>D <Cmd>call todo#RemoveCompleted()<CR>

    " Sort by due: date {{{3
    nnoremap <buffer> <LocalLeader>sd <Cmd>call todo#SortDue()<CR>
    " try fix format {{{3
    nnoremap <buffer> <LocalLeader>ff <Cmd>call todo#FixFormat()<CR>

    " increment and decrement due:date {{{3
    nmap    <buffer> <LocalLeader>p <Plug>(TodotxtIncrementDueDateNormal)
    vmap    <buffer> <LocalLeader>p <Plug>(TodotxtIncrementDueDateVisual)
    nmap    <buffer> <LocalLeader>P <Plug>(TodotxtDecrementDueDateNormal)
    vmap    <buffer> <LocalLeader>P <Plug>(TodotxtDecrementDueDateVisual)

endif

" Additional options {{{2
" Prefix creation date when opening a new line {{{3
if get(g:, 'Todo_txt_prefix_creation_date', 1)
    nnoremap <buffer> o o<C-R>=strftime("%Y-%m-%d ")<CR>
    nnoremap <buffer> O O<C-R>=strftime("%Y-%m-%d ")<CR>
    inoremap <buffer> <expr> <CR> strftime("\<CR>%Y-%m-%d ")
endif

" Functions for maps {{{1
function s:ChangeDueDateWrapper(by_days, repeat_mapping)
    call todo#CreateNewRecurrence(0)
    call todo#ChangeDueDate(a:by_days, 'd', '')
    silent! call repeat#set(a:repeat_mapping, v:count)
endfunction

" Folding {{{1
" Options {{{2
setlocal foldmethod=expr
setlocal foldexpr=TodoFoldLevel(v:lnum)
setlocal foldtext=TodoFoldText()

" Go to first completed task
let s:oldpos = getcurpos()
if !exists('g:Todo_fold_char')
    let g:Todo_fold_char = '@'
    let s:base_pos = search('^x\s', 'ce')
    " Get next completed task
    let s:first_incomplete = search('^\s*[^<x\s>]')
    if s:first_incomplete < s:base_pos
        " Check if all tasks from
        let g:Todo_fold_char = 'x'
    endif
    call setpos('.', s:oldpos)
endif

function s:get_contextproject(line) "{{{2
    return matchstr(getline(a:line), g:Todo_fold_char..'[^ ]\+')
endfunction "}}}3

" TodoFoldLevel(lnum) {{{2
function TodoFoldLevel(lnum)
    let l:this_context = s:get_contextproject(a:lnum)
    let l:next_context = s:get_contextproject(a:lnum - 1)

    if g:Todo_fold_char ==# 'x'
        " fold on cmpleted task
        return  match(getline(a:lnum),'\C^x\s') + 1
    endif

    if l:this_context ==# l:next_context
        return '1'
    endif
    return '>1'
endfunction

" TodoFoldText() {{{2
function TodoFoldText()
    let l:this_context = s:get_contextproject(v:foldstart)
    if g:Todo_fold_char ==# 'x'
        let l:this_context = 'Completed tasks'
    endif
    " The text displayed at the fold is formatted as '+- N Completed tasks'
    " where N is the number of lines folded.
    return '+'..v:folddashes..' '
        \ ..(v:foldend - v:foldstart + 1)
        \ ..' '..l:this_context..' '
endfunction
