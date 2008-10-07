" F6_Comment.vim
" Author: David Maclay
" Version: 1.1
" License: GPLv2

" Description:
" I don't know for sure that something like this does not already exist in Vim,
" but if it does, I can't find it.

" I recal Cream having this kind of functionallity mapped to <F6>,
" so to maintain consistency I've kept the convention.

" This uses the current value of &cms / &commentstring to comment and uncomment code.
" It works for ranges selected in Visual mode, or for the current line in all modes.
" NB. Comment strings may not include '@' or '+'
" (I don't know of any languages that use these characters).

" Help:
" Use <F6> to comment, and <S-F6> to uncomment.

function Comment() range
    execute ':silent '.a:firstline.','.a:lastline.'s@\(^[\t, ]*\)\(\)\(..*\)@\1'.substitute(&cms,'%s.*$','','').'\3@'
    execute ':silent '.a:firstline.','.a:lastline.'s@\(..*\)\($\)@\1'.           substitute(&cms,'^.*%s','','').'@'
endfunction
map <silent> <F6> :call Comment()<CR>
imap <silent> <F6> <ESC><F6>i

function UnComment() range
    exe ':silent '.a:firstline.','.a:lastline.'s@\(^[\t, ]*\)\('.substitute(substitute(&cms,'%s.*$','',''),'\*','\\*','g').'\)@\1@'
    exe ':silent '.a:firstline.','.a:lastline.'s@'.              substitute(substitute(&cms,'^.*%s','',''),'\*','\\*','g').'$@@'
endfunction
map <silent> <S-F6> :call UnComment()<CR>
imap <silent> <S-F6> <ESC><S-F6>i


" P.S.
" This command cleans up a code file.
" It swaps 4 spaces for all tabs, and removes any trailing spaces.
" Just use :Clean

function Clean()
    %s/\t/    /g
    %s/  *$//g
endfunction
com -nargs=* Clean :call Clean()<args>|noh

