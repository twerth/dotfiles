"=============================================================================
" fuzzyfinder.vim : Fuzzy/Partial pattern explorer for
"                   buffer/file/MRU/command/bookmark/tag/etc.
"=============================================================================
"
" Author:  Takeshi NISHIDA <ns9tks@DELETE-ME.gmail.com>
" Version: 2.19, for Vim 7.1
" Licence: MIT Licence
" URL:     http://www.vim.org/scripts/script.php?script_id=1984
"
" GetLatestVimScripts: 1984 1 :AutoInstall: fuzzyfinder.vim
"
"=============================================================================
" DOCUMENT: {{{1
"   Japanese: http://vim.g.hatena.ne.jp/keyword/fuzzyfinder.vim
"
"-----------------------------------------------------------------------------
" Description:
"   Fuzzyfinder provides convenient ways to quickly reach the buffer/file you
"   want. Fuzzyfinder finds matching files/buffers with a fuzzy/partial
"   pattern to which it converted the entered pattern.
"
"   E.g.: entered pattern -> fuzzy pattern / partial pattern
"         abc             -> *a*b*c*       / *abc*
"         a?c             -> *a?c*         / *a?c*
"         dir/file        -> dir/*f*i*l*e* / dir/*file*
"         d*r/file        -> d*r/*f*i*l*e* / d*r/*file*
"         ../**/s         -> ../**/*s*     / ../**/*s*
"
"     (** allows searching a directory tree.)
"
"   You will be happy when:
"     "./OhLongLongLongLongLongFile.txt"
"     "./AhLongLongLongLongLongName.txt"
"     "./AhLongLongLongLongLongFile.txt" <- you want :O
"     Type "AF" and "AhLongLongLongLongLongFile.txt" will be select. :D
"
"   Fuzzyfinder has some modes:
"     - Buffer mode
"     - File mode
"     - Directory mode (yet another :cd command)
"     - MRU-File mode (most recently used files)
"     - MRU-Command mode (most recently used command-lines)
"     - Bookmark mode
"     - Tag mode (yet another :tag command)
"     - Tagged-File mode (files which are included in current tags)
"
"   Fuzzyfinder supports the multibyte.
"
"-----------------------------------------------------------------------------
" Installation:
"   Drop this file in your plugin directory.
"
"-----------------------------------------------------------------------------
" Usage:
"   Starting Fuzzyfinder:
"     You can start Fuzzyfinder by the following commands:
"
"       :FuzzyFinderBuffer      - launchs Fuzzyfinder as Buffer mode.
"       :FuzzyFinderFile        - launchs Fuzzyfinder as File mode.
"       :FuzzyFinderDir         - launchs Fuzzyfinder as Directory mode.
"       :FuzzyFinderMruFile     - launchs Fuzzyfinder as MRU-File mode.
"       :FuzzyFinderMruCmd      - launchs Fuzzyfinder as MRU-Command mode.
"       :FuzzyFinderBookmark    - launchs Fuzzyfinder as Bookmark mode.
"       :FuzzyFinderTag         - launchs Fuzzyfinder as Tag mode.
"       :FuzzyFinderTaggedFile  - launchs Fuzzyfinder as Tagged-File mode.
"
"     It is recommended to map these commands. These commands can take initial
"     text as a command argument. The text will be entered after Fuzzyfinder
"     launched. If a command was executed with a ! modifier (e.g.
"     :FuzzyFinderTag!), it enables the partial matching instead of the fuzzy
"     matching.
"
"
"   In Fuzzyfinder:
"     An entered pattern is converted to a fuzzy pattern and items which match
"     the pattern is shown in a completion menu.
"
"     A completion menu is shown when you type at an end of a line and the
"     length of the entered pattern is more than setting value. By default, it
"     is shown at the beginning.
"
"     The number of items shown in the completion menu is limited (50, by
"     default) to speed up the response time.
"
"     Fuzzyfinder sorts completion items with some rules:
"       - A perfect matching puts first.
"       - A sequential matching puts higher than a fragmentary matching.
"       - A backward matching puts higher than a forward matching.
"       - A short item is put higher than a long item.
"
"     Plus, Fuzzyfinder has a learning system. An item which has been
"     completed in the past with a current pattern is placed upper.
"
"     The first item in the completion menu will be selected automatically.
"
"     You can open a selected item in various ways:
"       <CR>  - opens in a previous window.
"       <C-j> - opens in a split window.
"       <C-k> - opens in a vertical-split window.
"       <C-]> - opens in a new tab page.
"
"     To cancel and return to previous window, leave Insert mode.
"
"     To Switch the mode without leaving Insert mode, use <C-l> or <C-o>.
"     This key mapping is customizable.
"
"     If you want to temporarily change whether or not to ignore case, use
"     <C-t>. This key mapping is customizable.
"
"   To Hide The Completion Menu Temporarily In Fuzzyfinder:
"     You can close it by <C-e> and reopen it by <C-x><C-u>.
"
"   About Highlighting:
"     Fuzzyfinder highlights the buffer with "Error" group when the number of
"     completion items found is 0 or over enumerating_limit.
"
"   About Alternative Approach For Tag Jump:
"     Following mappings are replacements for :tag and <C-]>:
"
"       nnoremap <silent> <C-f><C-t> :FuzzyFinderTag!<CR>
"       nnoremap <silent> <C-]>      :FuzzyFinderTag! <C-r>=expand('<cword>')<CR><CR>
"
"     In the tag mode, it is recommended to use partial matching instead of
"     fuzzy matching.
"
"   About Tagged File Mode:
"     The files which are included in the current tags are the ones which are
"     related to the current working environment. So this mode is a pseudo
"     project mode.
"
"   About Usage Of Command Argument:
"     As an example, if you want to launch file-mode Fuzzyfinder with the full
"     path of current directory, map like below:
"
"       nnoremap <C-p> :FuzzyFinderFile <C-r>=fnamemodify(getcwd(), ':p')<CR><CR>
"
"     Instead, if you want the directory of current buffer and not current
"     directory:
"
"       nnoremap <C-p> :FuzzyFinderFile <C-r>=expand('%:~:.')[:-1-len(expand('%:~:.:t'))]<CR><CR>
"
"   About Abbreviations And Multiple Search:
"     You can use abbreviations and multiple search in each mode. For example,
"     set as below:
"
"       let g:FuzzyFinderOptions.Base.abbrev_map  = {
"             \   "^WORK" : [
"             \     "~/project/**/src/",
"             \     ".vim/plugin/",
"             \   ],
"             \ }
"
"     And type "WORKtxt" in file-mode Fuzzyfinder, then it searches by
"     following patterns:
"
"       "~/project/**/src/*t*x*t*"
"       ".vim/plugin/*t*x*t*"
"
"   About Bookmark Mode:
"     You can jump to a line you have added to bookmarks beforehand.
"     Fuzzyfinder adjusts a line number for jump. If a line of bookmarked
"     position does not match to a pattern when the bookmark was added,
"     Fuzzyfinder searches a matching line around bookmarked position. So you
"     can jump to a bookmarked line even if the line is out of bookmarked
"     position. If you want to jump to bookmarked line number, set
"     g:FuzzyFinderOptions.Bookmark.searching_range option to 0.
"
"   Adding Bookmark:
"     You can add a cursor line to bookmarks by the following commands:
"
"       :FuzzyFinderAddBookmark
"
"     Execute that command and you will be prompted to enter a bookmark name.
"
"   About Information File:
"     Fuzzyfinder writes information of the MRU, bookmark, etc to the file by
"     default (~/.vimfuzzyfinder).

"     :FuzzyFinderEditInfo command is helpful in editing your information
"     file. This command reads the information file in new unnamed buffer.
"     Write the buffer and the information file will be updated.
"
"   About Cache:
"     Once a cache was created, It is not automatically updated to speed up
"     the response time by default. To update it, use :FuzzyFinderRemoveCache
"     command.
"
"   About Migemo:
"     Migemo is a search method for Japanese language.
"
"-----------------------------------------------------------------------------
" Options:
"   You can set options via g:FuzzyFinderOptions which is a dictionary. See
"   the folded section named "GLOBAL OPTIONS:" for details. To easily set
"   options for customization, put necessary entries from GLOBAL OPTIONS into
"   your vimrc file and edit those values.
"
"-----------------------------------------------------------------------------
" Setting Example:
"   let g:FuzzyFinderOptions = { 'Base':{}, 'Buffer':{}, 'File':{}, 'Dir':{}, 'MruFile':{}, 'MruCmd':{}, 'Bookmark':{}, 'Tag':{}, 'TaggedFile':{}}
"   let g:FuzzyFinderOptions.Base.ignore_case = 1
"   let g:FuzzyFinderOptions.Base.abbrev_map  = {
"         \   '\C^VR' : [
"         \     '$VIMRUNTIME/**',
"         \     '~/.vim/**',
"         \     '$VIM/.vim/**',
"         \     '$VIM/vimfiles/**',
"         \   ],
"         \ }
"   let g:FuzzyFinderOptions.MruFile.max_item = 200
"   let g:FuzzyFinderOptions.MruCmd.max_item = 200
"   nnoremap <silent> <C-n>      :FuzzyFinderBuffer<CR>
"   nnoremap <silent> <C-m>      :FuzzyFinderFile <C-r>=expand('%:~:.')[:-1-len(expand('%:~:.:t'))]<CR><CR>
"   nnoremap <silent> <C-j>      :FuzzyFinderMruFile<CR>
"   nnoremap <silent> <C-k>      :FuzzyFinderMruCmd<CR>
"   nnoremap <silent> <C-p>      :FuzzyFinderDir <C-r>=expand('%:p:~')[:-1-len(expand('%:p:~:t'))]<CR><CR>
"   nnoremap <silent> <C-f><C-d> :FuzzyFinderDir<CR>
"   nnoremap <silent> <C-b>      :FuzzyFinderBookmark<CR>
"   nnoremap <silent> <C-f><C-t> :FuzzyFinderTag!<CR>
"   nnoremap <silent> <C-f><C-g> :FuzzyFinderTaggedFile<CR>
"   noremap  <silent> g]         :FuzzyFinderTag! <C-r>=expand('<cword>')<CR><CR>
"   nnoremap <silent> <C-f>b     :FuzzyFinderAddBookmark<CR>
"   nnoremap <silent> <C-f><C-e> :FuzzyFinderEditInfo<CR>
"
"-----------------------------------------------------------------------------
" Special Thanks:
"   Vincent Wang
"   Ingo Karkat
"   Nikolay Golubev
"   Brian Doyle
"   id:secondlife
"   Matt Tolton
"
"-----------------------------------------------------------------------------
" ChangeLog:
"   2.19:
"     - Changed MRU-File mode that always formats completion items to be
"       relative to the home directory.
"     - Fixed a bug that a file was opened in an unintended window with Tag
"       List plugin. Thanks Alexey.
"     - Fixed a bug that garbage characters were entered when switched current
"       mode. Thanks id:lugecy.
"
"   2.18:
"     - Improved rules for the sorting of completion items.
"     - Changed not to learn a completion if an entered pattern is empty.
"     - Fixed a bug that Buffer mode did not work. Thanks ryo7000.
"
"   2.17:
"     - Introduced a learning system for the sorting of completion items.
"     - Added g:FuzzyFinderOptions.Base.learning_limit option.
"     - Changed the specification of the information file. Please remove your
"       information file for Fuzzyfinder.
"
"   2.16:
"     - Improved response time by caching in MRU-File mode.
"     - Fixed a bug in Bookmark mode that Fuzzyfinder did not jump to the
"       Bookmarked line number when Bookmarked pattern was not found.
"
"   2.15:
"     - Added Bookmark mode.
"     - Removed Favorite-file mode. Use Bookmark mode instead.
"     - Fixed not to record a entry of input() in MRU-Command mode.
"
"   2.14:
"     - Changed to show buffer status in Buffer mode.
"     - Fixed a bug that an error occurs when nonexistent buffer-name was
"       entered in Buffer mode. Thanks Maxim Kim.
"     - Added 'enumerating_limit' option. Thanks id:secondlife.
"     - Removed 'matching_limit' option. Use 'enumerating_limit' instead.
"
"   2.13:
"     - Fixed a bug that a directory disappeared when a file in that directroy
"       was being opened in File/Mru-File mode.
"
"   2.12:
"     - Changed to be able to show completion items in the order of recently
"       used in Buffer mode.
"     - Added g:FuzzyFinderOptions.Buffer.mru_order option.
"
"   2.11:
"     - Changed that a dot sequence of entered pattern is expanded to parent
"       directroies in File/Dir mode.
"       E.g.: "foo/...bar" -> "foo/../../bar"
"     - Fixed a bug that a prompt string was excessively inserted.
"
"   2.10:
"     - Changed not to show a current buffer in a completion menu.
"     - Fixed a bug that a filename to open was not been escaped.
"     - Added 'prompt' option.
"     - Added 'prompt_highlight' option.
"     - Removed g:FuzzyFinderOptions.MruFile.no_special_buffer option.
"
"   2.9:
"     - Enhanced <BS> behavior in Fuzzyfinder and added 'smart_bs' option.
"     - Fixed a bug that entered pattern was not been escaped.
"     - Fixed not to insert "zv" with "c/pattern<CR>" command in Normal mode.
"     - Avoid the slow down problem caused by filereadable() check for the MRU
"       information in BufEnter/BufWritePost.
"
"   2.8.1:
"     - Fixed a bug caused by the non-escaped buffer name "[Fuzzyfinder]".
"     - Fixed a command to open in a new tab page in Buffer mode.
"   2.8:
"     - Added 'trim_length' option.
"     - Added 'switch_order' option.
"     - Fixed a bug that entered command did not become the newest in the
"       history.
"     - Fixed a bug that folds could not open with <CR> in a command-line when
"       searching.
"     - Removed 'excluded_indicator' option. Now a completion list in Buffer
"       mode is the same as a result of :buffers.
"
"   2.7:
"     - Changed to find an item whose index is matched with the number
"       suffixed with entered pattern.
"     - Fixed the cache bug after changing current directroy in File mode.
"
"   2.6.2:
"     - Fixed not to miss changes in options when updates the MRU information.
"
"   2.6.1:
"     - Fixed a bug related to floating-point support.
"     - Added support for GetLatestVimScripts.
"
"   2.6:
"     - Revived MRU-command mode. The problem with a command-line abbreviation
"       was solved.
"     - Changed the specification of the information file.
"     - Added :FuzzyFinderEditInfo command.

"   2.5.1:
"     - Fixed to be able to match "foo/./bar" by "foo/**/bar" in File mode.
"     - Fixed to be able to open a space-containing file in File mode.
"     - Fixed to honor the current working directory properly in File mode.
"
"   2.5:
"     - Fixed the bug that a wrong initial text is entered after switching to a
"       next mode.
"     - Fixed the bug that it does not return to previous window after leaving
"       Fuzzyfinder one.
"
"   2.4:
"     - Fixed the bug that Fuzzyfinder fails to open a file caused by auto-cd
"       plugin/script.
"
"   2.3:
"     - Added a key mapping to open items in a new tab page and
"       g:FuzzyFinderOptions.Base.key_open_tab opton.
"     - Changed to show Fuzzyfinder window above last window even if
"       'splitbelow' was set.
"     - Changed to set nocursorline and nocursorcolumn in Fuzzyfinder.
"     - Fixed not to push up a buffer number unlimitedly.
"
"   2.2:
"     - Added new feature, which is the partial matching.
"     - Fixed the bug that an error occurs when "'" was entered.
"
"   2.1:
"     - Restructured the option system AGAIN. Sorry :p
"     - Changed to inherit a typed text when switching a mode without leaving
"       Insert mode.
"     - Changed commands which launch explorers to be able to take a argument
"       for initial text.
"     - Changed to complete file names by relative path and not full path in
"       the buffer/mru-file/tagged-file mode.
"     - Changed to highlight a typed text when the completion item was not
"       found or the completion process was aborted.
"     - Changed to create caches for each tag file and not working directory
"       in the tag/tagged-file mode.
"     - Fixed the bug that the buffer mode couldn't open a unnamed buffer.
"     - Added 'matching_limit' option.
"     - Removed 'max_match' option. Use 'matching_limit' option instead.
"     - Removed 'initial_text' option. Use command argument instead.
"     - Removed the MRU-command mode.
"
"   2.0:
"     - Added the tag mode.
"     - Added the tagged-file mode.
"     - Added :FuzzyFinderRemoveCache command.
"     - Restructured the option system. many options are changed names or
"       default values of some options.
"     - Changed to hold and reuse caches of completion lists by default.
"     - Changed to set filetype 'fuzzyfinder'.
"     - Disabled the MRU-command mode by default because there are problems.
"     - Removed FuzzyFinderAddMode command.
"
"   1.5:
"     - Added the directory mode.
"     - Fixed the bug that it caused an error when switch a mode in Insert
"       mode.
"     - Changed g:FuzzyFinder_KeySwitchMode type to a list.
"
"   1.4:
"     - Changed the specification of the information file.
"     - Added the MRU-commands mode.
"     - Renamed :FuzzyFinderAddFavorite command to :FuzzyFinderAddFavFile.
"     - Renamed g:FuzzyFinder_MruModeVars option to
"       g:FuzzyFinder_MruFileModeVars.
"     - Renamed g:FuzzyFinder_FavoriteModeVars option to
"       g:FuzzyFinder_FavFileModeVars.
"     - Changed to show registered time of each item in MRU/favorite mode.
"     - Added 'timeFormat' option for MRU/favorite modes.
"
"   1.3:
"     - Fixed a handling of multi-byte characters.
"
"   1.2:
"     - Added support for Migemo. (Migemo is Japanese search method.)
"
"   1.1:
"     - Added the favorite mode.
"     - Added new features, which are abbreviations and multiple search.
"     - Added 'abbrevMap' option for each mode.
"     - Added g:FuzzyFinder_MruModeVars['ignoreSpecialBuffers'] option.
"     - Fixed the bug that it did not work correctly when a user have mapped
"       <C-p> or <Down>.
"
"   1.0:
"     - Added the MRU mode.
"     - Added commands to add and use original mode.
"     - Improved the sorting algorithm for completion items.
"     - Added 'initialInput' option to automatically insert a text at the
"       beginning of a mode.
"     - Changed that 'excludedPath' option works for the entire path.
"     - Renamed some options. 
"     - Changed default values of some options. 
"     - Packed the mode-specific options to dictionaries.
"     - Removed some options.
"
"   0.6:
"     - Fixed some bugs.

"   0.5:
"     - Improved response by aborting processing too many items.
"     - Changed to be able to open a buffer/file not only in previous window
"       but also in new window.
"     - Fixed a bug that recursive searching with '**' does not work.
"     - Added g:FuzzyFinder_CompletionItemLimit option.
"     - Added g:FuzzyFinder_KeyOpen option.
"
"   0.4:
"     - Improved response of the input.
"     - Improved the sorting algorithm for completion items. It is based on
"       the matching level. 1st is perfect matching, 2nd is prefix matching,
"       and 3rd is fuzzy matching.
"     - Added g:FuzzyFinder_ExcludePattern option.
"     - Removed g:FuzzyFinder_WildIgnore option.
"     - Removed g:FuzzyFinder_EchoPattern option.
"     - Removed g:FuzzyFinder_PathSeparator option.
"     - Changed the default value of g:FuzzyFinder_MinLengthFile from 1 to 0.
"
"   0.3:
"     - Added g:FuzzyFinder_IgnoreCase option.
"     - Added g:FuzzyFinder_KeyToggleIgnoreCase option.
"     - Added g:FuzzyFinder_EchoPattern option.
"     - Changed the open command in a buffer mode from ":edit" to ":buffer" to
"       avoid being reset cursor position.
"     - Changed the default value of g:FuzzyFinder_KeyToggleMode from
"       <C-Space> to <F12> because <C-Space> does not work on some CUI
"       environments.
"     - Changed to avoid being loaded by Vim before 7.0.
"     - Fixed a bug with making a fuzzy pattern which has '\'.
"
"   0.2:
"     - A bug it does not work on Linux is fixed.
"
"   0.1:
"     - First release.
"
" }}}1
"=============================================================================
" INCLUDE GUARD: {{{1
if exists('loaded_fuzzyfinder') || v:version < 701
  finish
endif
let loaded_fuzzyfinder = 1

" }}}1
"=============================================================================
" FUNCTIONS: LIST ------------------------------------------------------- {{{1

function! s:Unique(in)
  let sorted = sort(a:in)
  if len(sorted) < 2
    return sorted
  endif
  let last = remove(sorted, 0)
  let result = [last]
  for item in sorted
    if item != last
      call add(result, item)
      let last = item
    endif
  endfor
  return result
endfunction

" [ [0], [1,2], [3] ] -> [ 0, 1, 2, 3 ]
function! s:Concat(in)
  let result = []
  for l in a:in
    let result += l
  endfor
  return result
endfunction

" [ [ 0, 1 ], [ 2, 3, 4 ], ] -> [ [0,2], [0,3], [0,4], [1,2], [1,3], [1,4] ]
function! s:CartesianProduct(lists)
  if empty(a:lists)
    return []
  endif
  "let result = map((a:lists[0]), '[v:val]')
  let result = [ [] ]
  for l in a:lists
    let temp = []
    for r in result
      let temp += map(copy(l), 'add(copy(r), v:val)')
    endfor
    let result = temp
  endfor
  return result
endfunction

" copy + filter + limit
function! s:FilterEx(in, expr, limit)
  if a:limit <= 0
    return filter(copy(a:in), a:expr)
  endif
  let result = []
  let stride = a:limit * 3 / 2 " x1.5
  for i in range(0, len(a:in) - 1, stride)
    let result += filter(a:in[i : i + stride - 1], a:expr)
    if len(result) >= a:limit
      return remove(result, 0, a:limit - 1)
    endif
  endfor
  return result
endfunction

" 
function! s:FilterMatching(items, key, pattern, index, limit)
  return s:FilterEx(a:items, 'v:val[''' . a:key . '''] =~ ' . string(a:pattern) . ' || v:val.index == ' . a:index, a:limit)
endfunction

function! s:MapToSetSerialIndex(in, offset)
  for i in range(len(a:in))
    let a:in[i].index = i + a:offset
  endfor
  return a:in
endfunction

function! s:UpdateMruList(mrulist, new_item, max_item, excluded)
  let result = copy(a:mrulist)
  let result = filter(result,'v:val.word != a:new_item.word')
  let result = insert(result, a:new_item)
  let result = filter(result, 'v:val.word !~ a:excluded')
  return result[0 : a:max_item - 1]
endfunction

" FUNCTIONS: STRING ----------------------------------------------------- {{{1

" trims a:str and add a:mark if a length of a:str is more than a:len
function! s:TrimLast(str, len)
  if a:len <= 0 || len(a:str) <= a:len
    return a:str
  endif
  return a:str[:(a:len - len(s:ABBR_TRIM_MARK) - 1)] . s:ABBR_TRIM_MARK
endfunction

" takes suffix numer. if no digits, returns -1
function! s:SuffixNumber(str)
  let s = matchstr(a:str, '\d\+$')
  return (len(s) ? str2nr(s) : -1)
endfunction

function! s:ConvertWildcardToRegexp(expr)
  let re = escape(a:expr, '\')
  for [pat, sub] in [ [ '*', '\\.\\*' ], [ '?', '\\.' ], [ '[', '\\[' ], ]
    let re = substitute(re, pat, sub, 'g')
  endfor
  return '\V' . re
endfunction

" "foo/bar/hoge" -> { head: "foo/bar/", tail: "hoge" }
function! s:SplitPath(path)
  let dir = matchstr(a:path, '^.*[/\\]')
  return  {
        \   'head' : dir,
        \   'tail' : a:path[strlen(dir):]
        \ }
endfunction

function! s:EscapeFilename(fn)
  return escape(a:fn, " \t\n*?[{`$%#'\"|!<")
endfunction

" "foo/.../bar/...hoge" -> "foo/.../bar/../../hoge"
function! s:ExpandTailDotSequenceToParentDir(base)
  return substitute(a:base, '^\(.*[/\\]\)\?\zs\.\(\.\+\)\ze[^/\\]*$',
        \           '\=repeat(".." . s:PATH_SEPARATOR, len(submatch(2)))', '')
endfunction

function! s:ExistsPrompt(line, prompt)
  return  strlen(a:line) >= strlen(a:prompt) && a:line[:strlen(a:prompt) -1] ==# a:prompt
endfunction

function! s:RemovePrompt(line, prompt)
  return a:line[(s:ExistsPrompt(a:line, a:prompt) ? strlen(a:prompt) : 0):]
endfunction

function! s:RestorePrompt(line, prompt)
  let i = 0
  while i < len(a:prompt) && i < len(a:line) && a:prompt[i] ==# a:line[i]
    let i += 1
  endwhile
  return a:prompt . a:line[i : ]
endfunction

" FUNCTIONS: COMPLETION ITEM: ------------------------------------------- {{{1

" returns [v(1), v(2), ..., v(n) ] , v(i) < v(i+1) , v(1) > v(n)/2
function! s:MakeAscendingValues(n, total)
  let values = range(a:n, a:n * 2 - 1)
  let sum = 0
  for val in values
    let sum += val
  endfor
  return map(values, 'v:val * a:total / sum')
endfunction

" a range of return value is [0, s:MATCHING_RATE_BASE]
function! s:EvaluateMatchingRate(word, base)
  let rate = 0
  let scores = s:MakeAscendingValues(len(a:word), s:MATCHING_RATE_BASE)
  let matched = 0
  let skip_penalty = 1
  let i_base = 0
  for i_word in range(len(a:word))
    if i_base >= len(a:base)
      let skip_penalty = skip_penalty * 2
      break
    elseif a:word[i_word] == a:base[i_base]
      let rate += scores[i_word]
      let matched = 1
      let i_base += 1
    elseif matched
      let skip_penalty = skip_penalty * 2
      let matched = 0
    endif
  endfor
  return rate / skip_penalty
endfunction

" 
function! s:EvaluateLearningRank(word, stats)
  for i in range(len(a:stats))
    if a:stats[i].word ==# a:word
      return i
    endif
  endfor
  return len(a:stats)
endfunction


" FUNCTIONS: COMMANDLINE ------------------------------------------------ {{{1

function! s:EchoWithHl(msg, hl)
  execute "echohl " . a:hl
  echo a:msg
  echohl None
endfunction

function! s:InputHl(prompt, text, hl)
  execute "echohl " . a:hl
  let s = input(a:prompt, a:text)
  echohl None
  return s
endfunction

" FUNCTIONS: FUZZYFIDNER WINDOW ----------------------------------------- {{{1

function! s:HighlightPrompt(prompt, highlight)
  syntax clear
  execute printf('syntax match %s /^\V%s/', a:highlight, escape(a:prompt, '\'))
endfunction

function! s:HighlightError()
  syntax clear
  syntax match Error  /^.*$/
endfunction

" FUNCTIONS: TAG -------------------------------------------------------- {{{1

function! s:GetTagList(tagfile)
  let result = map(readfile(a:tagfile), 'matchstr(v:val, ''^[^!\t][^\t]*'')')
  return filter(result, 'v:val =~ ''\S''')
endfunction

function! s:GetTaggedFileList(tagfile)
  execute 'cd ' . fnamemodify(a:tagfile, ':h')
  let result = map(readfile(a:tagfile), 'fnamemodify(matchstr(v:val, ''^[^!\t][^\t]*\t\zs[^\t]\+''), '':p:~'')')
  cd -
  return filter(result, 'v:val =~ ''[^/\\ ]$''')
endfunction

function! s:GetCurrentTagFiles()
  return sort(filter(map(tagfiles(), 'fnamemodify(v:val, '':p'')'), 'filereadable(v:val)'))
endfunction

" FUNCTIONS: MISC ------------------------------------------------------- {{{1

function! s:IsAvailableMode(mode)
  return exists('a:mode.mode_available') && a:mode.mode_available
endfunction

function! s:GetAvailableModes()
  return filter(values(g:FuzzyFinderMode), 's:IsAvailableMode(v:val)')
endfunction

function! s:GetSortedAvailableModes()
  let modes = filter(items(g:FuzzyFinderMode), 's:IsAvailableMode(v:val[1])')
  let modes = map(modes, 'extend(v:val[1], { "ranks" : [v:val[1].switch_order, v:val[0]] })')
  return sort(modes, 's:CompareRanks')
endfunction

function! s:GetSidPrefix()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_')
endfunction

function! s:OnCmdCR()
  for m in s:GetAvailableModes()
    call m.extend_options()
    call m.on_command_pre(getcmdtype() . getcmdline())
  endfor
  " lets last entry become the newest in the history
  call histadd(getcmdtype(), getcmdline())
  " this is not mapped again (:help recursive_mapping)
  return "\<CR>"
endfunction

function! s:ExpandAbbrevMap(base, abbrev_map)
  let result = [a:base]
  " expand
  for [pattern, sub_list] in items(a:abbrev_map)
    let exprs = result
    let result = []
    for expr in exprs
      let result += map(copy(sub_list), 'substitute(expr, pattern, v:val, "g")')
    endfor
  endfor
  return s:Unique(result)
endfunction

" "**" is expanded to ["**", "."]. E.g.: "foo/**/bar" -> [ "foo/./bar", "foo/**/bar" ]
function! s:ExpandEx(dir)
  if a:dir !~ '\S'
    return ['']
  endif
  " [ ["foo/"], ["**/", "./" ], ["bar/"] ]
  let lists = []
  for i in split(a:dir, '[/\\]\zs')
    let m = matchlist(i, '^\*\{2,}\([/\\]*\)$')
    call add(lists, (empty(m) ? [i] : [i, '.' . m[1]]))
  endfor
  " expand wlidcards
  return split(join(map(s:CartesianProduct(lists), 'expand(join(v:val, ""))'), "\n"), "\n")
endfunction

function! s:EnumExpandedDirsEntries(dir, excluded)
  let dirs = s:ExpandEx(a:dir)
  let entries = s:Concat(map(copy(dirs), 'split(glob(v:val . ".*"), "\n") + ' .
        \                                'split(glob(v:val . "*" ), "\n")'))
  if len(dirs) > 1
    call map(entries, 'extend(s:SplitPath(v:val), { "suffix" : (isdirectory(v:val) ? s:PATH_SEPARATOR : "") })')
  else
    call map(entries, 'extend(s:SplitPath(v:val), { "suffix" : (isdirectory(v:val) ? s:PATH_SEPARATOR : ""), "head" : a:dir })')
  endif
  if len(a:excluded)
    call filter(entries, '(v:val.head . v:val.tail . v:val.suffix) !~ a:excluded')
  endif
  return entries
endfunction

function! s:GetBufIndicator(nr)
  if !getbufvar(a:nr, '&modifiable')
    return '[-]'
  elseif getbufvar(a:nr, '&modified')
    return '[+]'
  elseif getbufvar(a:nr, '&readonly')
    return '[R]'
  else
    return '   '
  endif
endfunction

function! s:ModifyWordAsFilename(item, mods)
  let a:item.word = fnamemodify(a:item.word, a:mods)
  return a:item
endfunction

function! s:SetFormattedTimeToMenu(item, format)
  let a:item.menu = strftime(a:format, a:item.time)
  return a:item
endfunction

function! s:SetRanks(item, eval_word, eval_base, stats)
  "let eval_word = (a:is_path ? s:SplitPath(matchstr(a:item.word, '^.*[^/\\]')).tail : a:item.word)
  "let eval_base = (a:is_path ? s:SplitPath(a:base).tail : a:base)
  let rank_perfect = (a:eval_word == a:eval_base ? 0 : 1)
  if a:eval_word == a:eval_base
    let rank_perfect = 1
    let rank_matching = 0
  else
    let rank_perfect = 2
    let rank_matching = -s:EvaluateMatchingRate(a:eval_word, a:eval_base)
  endif
  let a:item.ranks = [ rank_perfect, s:EvaluateLearningRank(a:item.word, a:stats), rank_matching, a:item.index ]
  return a:item
endfunction

function! s:SetFormattedAbbr(item, key, trim_len)
  let a:item.abbr = s:TrimLast(printf('%3d: %s', a:item.index, a:item[a:key]), a:trim_len)
  return a:item
endfunction

function! s:CompareTimeDescending(i1, i2)
  return a:i1.time == a:i2.time ? 0 : a:i1.time > a:i2.time ? -1 : +1
endfunction

function! s:CompareRanks(i1, i2)
  if exists('a:i1.ranks') && exists('a:i2.ranks')
    for i in range(min([len(a:i1.ranks), len(a:i2.ranks)]))
      if     a:i1.ranks[i] > a:i2.ranks[i]
        return +1
      elseif a:i1.ranks[i] < a:i2.ranks[i]
        return -1
      endif
    endfor
  endif
  return 0
endfunction

function! s:GetLinePattern(lnum)
  return '\C\V\^' . escape(getline(a:lnum), '\') . '\$'
endfunction

" opens a:path and jumps to the line matching to a:pattern from a:lnum within
" a:range. if not found, jumps to a:lnum.
function! s:JumpToBookmark(path, mode, pattern, lnum, range)
  call s:OpenFile(a:path, a:mode)
  let ln = a:lnum
  for i in range(0, a:range)
    if a:lnum + i <= line('$') && getline(a:lnum + i) =~ a:pattern
      let ln += i
      break
    elseif a:lnum - i >= 1 && getline(a:lnum - i) =~ a:pattern
      let ln -= i
      break
    endif
  endfor
  call cursor(ln, 0)
  normal! zvzz
endfunction

function! s:OpenBuffer(nr, mode)
  execute printf([
        \   ':%sbuffer',
        \   ':%ssbuffer',
        \   ':vertical :%ssbuffer',
        \   ':tab :%ssbuffer',
        \ ][a:mode], a:nr)
endfunction

function! s:OpenFile(path, mode)
  let nr = bufnr('^' . a:path . '$')
  if nr > -1
    call s:OpenBuffer(nr, a:mode)
  else
    execute [
          \   ':edit ',
          \   ':split ',
          \   ':vsplit ',
          \   ':tabedit ',
          \ ][a:mode] . s:EscapeFilename(a:path)
  endif
endfunction

" }}}1
"=============================================================================
" OBJECT: g:FuzzyFinderMode.Base ---------------------------------------- {{{1
let g:FuzzyFinderMode = { 'Base' : {} }

function! g:FuzzyFinderMode.Base.launch(initial_text, partial_matching)
  " initializes this object
  call self.extend_options()
  let self.partial_matching = a:partial_matching
  let self.prev_bufnr = bufnr('%')
  let self.last_col = -1
  call s:InfoFileManager.load()
  if !s:IsAvailableMode(self)
    echo 'This mode is not available: ' . self.to_str()
    return
  endif
  call self.on_mode_enter_pre()
  call s:WindowManager.activate(self.make_complete_func('CompleteFunc'))
  call s:OptionManager.set('completeopt', 'menuone')
  call s:OptionManager.set('ignorecase', self.ignore_case)
  " local autocommands
  augroup FuzzyfinderLocal
    autocmd!
    execute 'autocmd CursorMovedI <buffer>        call ' . self.to_str('on_cursor_moved_i()')
    execute 'autocmd InsertLeave  <buffer> nested call ' . self.to_str('on_insert_leave()'  )
  augroup END
  " local mapping
  for [lhs, rhs] in [
        \   [ self.key_open       , self.to_str('on_cr(0, 0)'            ) ],
        \   [ self.key_open_split , self.to_str('on_cr(1, 0)'            ) ],
        \   [ self.key_open_vsplit, self.to_str('on_cr(2, 0)'            ) ],
        \   [ self.key_open_tab   , self.to_str('on_cr(3, 0)'            ) ],
        \   [ '<BS>'              , self.to_str('on_bs()'                ) ],
        \   [ '<C-h>'             , self.to_str('on_bs()'                ) ],
        \   [ self.key_next_mode  , self.to_str('on_switch_mode(+1)'     ) ],
        \   [ self.key_prev_mode  , self.to_str('on_switch_mode(-1)'     ) ],
        \   [ self.key_ignore_case, self.to_str('on_switch_ignore_case()') ],
        \ ]
    " hacks to be able to use feedkeys().
    execute printf('inoremap <buffer> <silent> %s <C-r>=%s ? "" : ""<CR>', lhs, rhs)
  endfor
  " Starts Insert mode and makes CursorMovedI event now. Command prompt is
  " needed to forces a completion menu to update every typing.
  call setline(1, self.prompt . a:initial_text)
  call self.on_mode_enter_post()
  call feedkeys("A", 'n') " startinsert! does not work in InsertLeave handler
endfunction

function! g:FuzzyFinderMode.Base.on_cursor_moved_i()
  if !s:ExistsPrompt(getline('.'), self.prompt)
    call setline('.', s:RestorePrompt(getline('.'), self.prompt))
    call feedkeys("\<End>", 'n')
  elseif col('.') <= len(self.prompt)
    " if the cursor is moved before command prompt
    call feedkeys(repeat("\<Right>", len(self.prompt) - col('.') + 1), 'n')
  elseif col('.') > strlen(getline('.')) && col('.') != self.last_col
    " if the cursor is placed on the end of the line and has been actually moved.
    let self.last_col = col('.')
    let self.last_base = s:RemovePrompt(getline('.'), self.prompt)
    call feedkeys("\<C-x>\<C-u>", 'n')
  endif
endfunction

function! g:FuzzyFinderMode.Base.on_insert_leave()
  let last_pattern = s:RemovePrompt(getline('.'), self.prompt)
  call s:OptionManager.restore_all()
  call s:WindowManager.deactivate()
  if exists('s:reserved_command')
    call self.on_open(s:reserved_command[0], s:reserved_command[1])
    unlet s:reserved_command
  endif
  call self.on_mode_leave_post()
  call self.empty_cache_if_existed(0)
  " switchs to next mode, or finishes fuzzyfinder.
  if exists('s:reserved_switch_mode')
    let m = self.next_mode(s:reserved_switch_mode < 0)
    call m.launch(last_pattern, self.partial_matching)
    unlet s:reserved_switch_mode
  endif
endfunction

function! g:FuzzyFinderMode.Base.on_buf_enter()
endfunction

function! g:FuzzyFinderMode.Base.on_buf_write_post()
endfunction

function! g:FuzzyFinderMode.Base.on_command_pre(cmd)
endfunction

function! g:FuzzyFinderMode.Base.on_cr(index, dir_check)
  if pumvisible()
    call feedkeys(printf("\<C-y>\<C-r>=%s(%d, 1) ? '' : ''\<CR>", self.to_str('on_cr'), a:index), 'n')
    return
  endif
  if !empty(self.last_base)
    call self.add_stat(self.last_base, s:RemovePrompt(getline('.'), self.prompt))
  endif
  if a:dir_check && getline('.') =~ '[/\\]$'
    return
  endif
  let s:reserved_command = [s:RemovePrompt(getline('.'), self.prompt), a:index]
  call feedkeys("\<Esc>", 'n') " stopinsert behavior is strange...
endfunction

function! g:FuzzyFinderMode.Base.on_bs()
  let bs_count = 1
  if self.smart_bs && col('.') > 2 && getline('.')[col('.') - 2] =~ '[/\\]'
    let bs_count = len(matchstr(getline('.')[:col('.') - 3], '[^/\\]*$')) + 1
  endif
  call feedkeys((pumvisible() ? "\<C-e>" : "") . repeat("\<BS>", bs_count), 'n')
endfunction

" Before entering Fuzzyfinder buffer. This function should return in a short time.
function! g:FuzzyFinderMode.Base.on_mode_enter_pre()
endfunction

" After entering Fuzzyfinder buffer.
function! g:FuzzyFinderMode.Base.on_mode_enter_post()
endfunction

" After leaving Fuzzyfinder buffer.
function! g:FuzzyFinderMode.Base.on_mode_leave_post()
endfunction

function! g:FuzzyFinderMode.Base.on_open(expr, mode)
  call s:OpenFile(a:expr, a:mode)
endfunction

function! g:FuzzyFinderMode.Base.on_switch_mode(next_prev)
  let s:reserved_switch_mode = a:next_prev
  call feedkeys("\<Esc>", 'n') " stopinsert behavior is strange...
endfunction

function! g:FuzzyFinderMode.Base.on_switch_ignore_case()
  let &ignorecase = !&ignorecase
  echo "ignorecase = " . &ignorecase
  let self.last_col = -1
  call self.on_cursor_moved_i()
endfunction

" export mode-specific information as string list
function! g:FuzzyFinderMode.Base.serialize_info()
  let header_data  = self.to_key() . ".data\t"
  let header_stats = self.to_key() . ".stats\t"
  return  map(copy(self.data ), 'header_data  . string(v:val)') +
        \ map(copy(self.stats), 'header_stats . string(v:val)')
endfunction

" import mode-specific information from string list
function! g:FuzzyFinderMode.Base.deserialize_info(lines)
  let header_data  = self.to_key() . ".data\t"
  let header_stats = self.to_key() . ".stats\t"
  let self.data  = map(filter(copy(a:lines), 'v:val[: len(header_data ) - 1] ==# header_data '),
        \              'eval(v:val[len(header_data ) :])')
  let self.stats = map(filter(copy(a:lines), 'v:val[: len(header_stats) - 1] ==# header_stats'),
        \              'eval(v:val[len(header_stats) :])')
  call filter(self.stats, '!empty(v:val.base)') " NOTE: remove this line someday
endfunction

function! g:FuzzyFinderMode.Base.add_stat(base, word)
  call s:InfoFileManager.load()
  let stat = { 'base' : a:base, 'word' : a:word }
  call filter(self.stats, 'v:val !=# stat')
  call insert(self.stats, stat)
  let self.stats = self.stats[0 : self.learning_limit - 1]
  call s:InfoFileManager.save()
endfunction

function! g:FuzzyFinderMode.Base.complete(findstart, base)
  if a:findstart
    return 0
  elseif  !s:ExistsPrompt(a:base, self.prompt) || len(s:RemovePrompt(a:base, self.prompt)) < self.min_length
    return []
  endif
  call s:HighlightPrompt(self.prompt, self.prompt_highlight)
  " FIXME: ExpandAbbrevMap duplicates index
  let result = []
  for expanded_base in s:ExpandAbbrevMap(s:RemovePrompt(a:base, self.prompt), self.abbrev_map)
    let result += self.on_complete(expanded_base)
  endfor
  call sort(result, 's:CompareRanks')
  if empty(result) || len(result) >= self.enumerating_limit
    call s:HighlightError()
  endif
  if !empty(result)
    call feedkeys("\<C-p>\<Down>", 'n')
  endif
  return result
endfunction

" This function is set to 'completefunc' which doesn't accept dictionary-functions.
function! g:FuzzyFinderMode.Base.make_complete_func(name)
  execute printf("function! s:%s(findstart, base)\n" .
        \        "  return %s.complete(a:findstart, a:base)\n" .
        \        "endfunction", a:name, self.to_str())
  return s:GetSidPrefix() . a:name
endfunction

" fuzzy  : 'str' -> {'base':'str', 'wi':'*s*t*r*', 're':'\V\.\*s\.\*t\.\*r\.\*'}
" partial: 'str' -> {'base':'str', 'wi':'*str*', 're':'\V\.\*str\.\*'}
function! g:FuzzyFinderMode.Base.make_pattern(base)
  if self.partial_matching
    let wi = (a:base !~ '^[*?]'  ? '*' : '') . a:base .
          \  (a:base =~ '[^*?]$' ? '*' : '')
    let re = s:ConvertWildcardToRegexp(wi)
    return { 'base': a:base, 'wi':wi, 're': re }
  else
    let wi = ''
    for char in split(a:base, '\zs')
      if wi !~ '[*?]$' && char !~ '[*?]'
        let wi .= '*'. char
      else
        let wi .= char
      endif
    endfor
    if wi !~ '[*?]$'
      let wi .= '*'
    endif
    let re = s:ConvertWildcardToRegexp(wi)
    if self.migemo_support && a:base !~ '[^\x01-\x7e]'
      let re .= '\|\m.*' . substitute(migemo(a:base), '\\_s\*', '.*', 'g') . '.*'
    endif
    return { 'base': a:base, 'wi':wi, 're': re }
  endif
endfunction

function! g:FuzzyFinderMode.Base.get_filtered_stats(base)
  return filter(copy(self.stats), 'v:val.base ==# a:base')
endfunction

function! g:FuzzyFinderMode.Base.empty_cache_if_existed(force)
  if exists('self.cache') && (a:force || !exists('self.lasting_cache') || !self.lasting_cache)
    unlet self.cache
  endif
endfunction

function! g:FuzzyFinderMode.Base.to_key()
  return filter(keys(g:FuzzyFinderMode), 'g:FuzzyFinderMode[v:val] is self')[0]
endfunction

" returns 'g:FuzzyFinderMode.{key}{.argument}'
function! g:FuzzyFinderMode.Base.to_str(...)
  return 'g:FuzzyFinderMode.' . self.to_key() . (a:0 > 0 ? '.' . a:1 : '')
endfunction

" takes in g:FuzzyFinderOptions
function! g:FuzzyFinderMode.Base.extend_options()
  call extend(self, g:FuzzyFinderOptions.Base, 'force')
  call extend(self, g:FuzzyFinderOptions[self.to_key()], 'force')
endfunction

function! g:FuzzyFinderMode.Base.next_mode(rev)
  let modes = (a:rev ? s:GetSortedAvailableModes() : reverse(s:GetSortedAvailableModes()))
  let m_last = modes[-1]
  for m in modes
    if m is self
      break
    endif
    let m_last = m
  endfor
  return m_last
  " vim crashed using map()
endfunction

" OBJECT: g:FuzzyFinderMode.Buffer -------------------------------------- {{{1
let g:FuzzyFinderMode.Buffer = copy(g:FuzzyFinderMode.Base)

function! g:FuzzyFinderMode.Buffer.on_complete(base)
  let patterns = self.make_pattern(a:base)
  let base_tail = s:SplitPath(a:base).tail
  let stats = self.get_filtered_stats(a:base)
  let result = s:FilterMatching(self.items, 'word', patterns.re, s:SuffixNumber(patterns.base), self.enumerating_limit)
  return map(result, 's:SetRanks(v:val, s:SplitPath(matchstr(v:val.word, ''^.*[^/\\]'')).tail, base_tail, stats)')
endfunction

function! g:FuzzyFinderMode.Buffer.on_open(expr, mode)
  " filter the selected item to get the buffer number for handling unnamed buffer
  call filter(self.items, 'v:val.word ==# a:expr')
  if !empty(self.items)
    call s:OpenBuffer(self.items[0].buf_nr, a:mode)
  endif
endfunction

function! g:FuzzyFinderMode.Buffer.on_mode_enter_post()
  let self.items = map(filter(range(1, bufnr('$')), 'buflisted(v:val) && v:val != self.prev_bufnr'),
        \              'self.make_item(v:val)')
  if self.mru_order
    call s:MapToSetSerialIndex(sort(self.items, 's:CompareTimeDescending'), 1)
  endif
  call map(self.items, 's:SetFormattedAbbr(v:val, "abbr", self.trim_length)')
endfunction

function! g:FuzzyFinderMode.Buffer.on_buf_enter()
  call self.update_buf_times()
endfunction

function! g:FuzzyFinderMode.Buffer.on_buf_write_post()
  call self.update_buf_times()
endfunction

function! g:FuzzyFinderMode.Buffer.update_buf_times()
  call extend(self, { 'buf_times' : {} }, 'keep')
  let self.buf_times[bufnr('%')] = localtime()
endfunction

function! g:FuzzyFinderMode.Buffer.make_item(nr)
  let path = (empty(bufname(a:nr)) ? '[No Name]' : fnamemodify(bufname(a:nr), ':~:.'))
  let time = (exists('self.buf_times[a:nr]') ? self.buf_times[a:nr] : 0)
  return  {
        \   'index'  : a:nr,
        \   'buf_nr' : a:nr,
        \   'word'   : path,
        \   'abbr'   : s:GetBufIndicator(a:nr) . ' ' . path,
        \   'menu'   : strftime(self.time_format, time),
        \   'time'   : time,
        \ }
endfunction

"  'edit'/'split'/'vsplit'/'tabedit'
function! g:FuzzyFinderMode.Buffer.jump_to(item, cmd_open)
endfunction

" OBJECT: g:FuzzyFinderMode.File ---------------------------------------- {{{1
let g:FuzzyFinderMode.File = copy(g:FuzzyFinderMode.Base)

function! g:FuzzyFinderMode.File.on_complete(base)
  let base = s:ExpandTailDotSequenceToParentDir(a:base)
  let patterns = map(s:SplitPath(base), 'self.make_pattern(v:val)')
  let stats = self.get_filtered_stats(a:base)
  let result = self.cached_glob(patterns.head.base, patterns.tail.re, self.excluded_path, s:SuffixNumber(patterns.tail.base), self.enumerating_limit)
  let result = filter(result, 'bufnr("^" . v:val.word . "$") != self.prev_bufnr')
  return map(result, 's:SetRanks(v:val, s:SplitPath(matchstr(v:val.word, ''^.*[^/\\]'')).tail, patterns.tail.base, stats)')
endfunction

function! g:FuzzyFinderMode.File.cached_glob(dir, file, excluded, index, limit)
  let key = fnamemodify(a:dir, ':p')
  call extend(self, { 'cache' : {} }, 'keep')
  if !exists('self.cache[key]')
    echo 'Caching file list...'
    let self.cache[key] = s:EnumExpandedDirsEntries(key, a:excluded)
    call s:MapToSetSerialIndex(self.cache[key], 1)
  endif
  echo 'Filtering file list...'
  let result = s:FilterMatching(self.cache[key], 'tail', a:file, a:index, a:limit)
  call map(result, '{ "index" : v:val.index, "word" : (v:val.head == key ? a:dir : v:val.head) . v:val.tail . v:val.suffix }') 
  return map(result, 's:SetFormattedAbbr(v:val, "word", self.trim_length)') 
endfunction

" OBJECT: g:FuzzyFinderMode.Dir ----------------------------------------- {{{1
let g:FuzzyFinderMode.Dir = copy(g:FuzzyFinderMode.Base)

function! g:FuzzyFinderMode.Dir.on_complete(base)
  let base = s:ExpandTailDotSequenceToParentDir(a:base)
  let patterns = map(s:SplitPath(base), 'self.make_pattern(v:val)')
  let stats = self.get_filtered_stats(a:base)
  let result = self.cached_glob_dir(patterns.head.base, patterns.tail.re, self.excluded_path, s:SuffixNumber(patterns.tail.base), self.enumerating_limit)
  return map(result, 's:SetRanks(v:val, s:SplitPath(matchstr(v:val.word, ''^.*[^/\\]'')).tail, patterns.tail.base, stats)')
endfunction

function! g:FuzzyFinderMode.Dir.on_open(expr, mode)
  execute ':cd ' . s:EscapeFilename(a:expr)
endfunction

function! g:FuzzyFinderMode.Dir.cached_glob_dir(dir, file, excluded, index, limit)
  let key = fnamemodify(a:dir, ':p')
  call extend(self, { 'cache' : {} }, 'keep')
  if !exists('self.cache[key]')
    echo 'Caching file list...'
    let self.cache[key] = filter(s:EnumExpandedDirsEntries(key, a:excluded), 'len(v:val.suffix)')
    call insert(self.cache[key], { 'head' : key, 'tail' : '..', 'suffix' : s:PATH_SEPARATOR })
    call insert(self.cache[key], { 'head' : key, 'tail' : '.' , 'suffix' : '' })
    call s:MapToSetSerialIndex(self.cache[key], 1)
  endif
  echo 'Filtering file list...'
  let result = s:FilterMatching(self.cache[key], 'tail', a:file, a:index, a:limit)
  call map(result, '{ "index" : v:val.index, "word" : (v:val.head == key ? a:dir : v:val.head) . v:val.tail . v:val.suffix }') 
  return map(result, 's:SetFormattedAbbr(v:val, "word", self.trim_length)') 
endfunction

" OBJECT: g:FuzzyFinderMode.MruFile ------------------------------------- {{{1
let g:FuzzyFinderMode.MruFile = copy(g:FuzzyFinderMode.Base)

function! g:FuzzyFinderMode.MruFile.on_complete(base)
  let patterns = self.make_pattern(a:base)
  let base_tail = s:SplitPath(a:base).tail
  let stats = self.get_filtered_stats(a:base)
  let result = s:FilterMatching(self.items, 'word', patterns.re, s:SuffixNumber(patterns.base), self.enumerating_limit)
  return map(result, 's:SetRanks(v:val, s:SplitPath(matchstr(v:val.word, ''^.*[^/\\]'')).tail, base_tail, stats)')
endfunction

function! g:FuzzyFinderMode.MruFile.on_mode_enter_post()
  let self.items = copy(self.data)
  let self.items = map(self.items, 'self.format_item_using_cache(v:val)')
  let self.items = filter(self.items, '!empty(v:val) && bufnr("^" . v:val.word . "$") != self.prev_bufnr')
  let self.items = s:MapToSetSerialIndex(self.items, 1)
  let self.items = map(self.items, 's:SetFormattedAbbr(v:val, "word", self.trim_length)')
endfunction

function! g:FuzzyFinderMode.MruFile.on_buf_enter()
  call self.update_info()
endfunction

function! g:FuzzyFinderMode.MruFile.on_buf_write_post()
  call self.update_info()
endfunction

function! g:FuzzyFinderMode.MruFile.update_info()
  if !empty(&buftype) || expand('%') !~ '\S'
    return
  endif
  call s:InfoFileManager.load()
  let self.data = s:UpdateMruList(self.data, { 'word' : expand('%:p'), 'time' : localtime() },
        \                         self.max_item, self.excluded_path)
  call s:InfoFileManager.save()
  call self.remove_item_from_cache(expand('%:p'))
endfunction

" returns empty value if invalid item
function! g:FuzzyFinderMode.MruFile.format_item_using_cache(item)
  call extend(self, { 'cache' : {} }, 'keep')
  if a:item.word !~ '\S'
    return {}
  endif
  if !exists('self.cache[a:item.word]')
    let self.cache[a:item.word] =
          \ (filereadable(a:item.word)
          \  ? s:ModifyWordAsFilename(s:SetFormattedTimeToMenu(copy(a:item), self.time_format), ':p:~')
          \  : {})
  endif
  return self.cache[a:item.word]
endfunction

function! g:FuzzyFinderMode.MruFile.remove_item_from_cache(word)
  if !exists('self.cache')
    return
  endif
  for items in values(self.cache)
    if exists('items[a:word]')
      unlet items[a:word]
    endif
  endfor
endfunction

" OBJECT: g:FuzzyFinderMode.MruCmd -------------------------------------- {{{1
let g:FuzzyFinderMode.MruCmd = copy(g:FuzzyFinderMode.Base)

function! g:FuzzyFinderMode.MruCmd.on_complete(base)
  let patterns = self.make_pattern(a:base)
  let stats = self.get_filtered_stats(a:base)
  let result = s:FilterMatching(self.items, 'word', patterns.re, s:SuffixNumber(patterns.base), self.enumerating_limit)
  return map(result, 's:SetRanks(v:val, v:val.word, a:base, stats)')
endfunction

function! g:FuzzyFinderMode.MruCmd.on_open(expr, mode)
  call self.update_info(a:expr)
  call histadd(a:expr[0], a:expr[1:])
  call feedkeys(a:expr . "\<CR>", 'n')
endfunction

function! g:FuzzyFinderMode.MruCmd.on_mode_enter_post()
  let self.items = copy(self.data)
  let self.items = map(self.items, 's:SetFormattedTimeToMenu(v:val, self.time_format)')
  let self.items = s:MapToSetSerialIndex(self.items, 1)
  let self.items = map(self.items, 's:SetFormattedAbbr(v:val, "word", self.trim_length)')
endfunction

function! g:FuzzyFinderMode.MruCmd.on_command_pre(cmd)
  if getcmdtype() =~ '^[:/?]'
    call self.update_info(a:cmd)
  endif
endfunction

function! g:FuzzyFinderMode.MruCmd.update_info(cmd)
  call s:InfoFileManager.load()
  let self.data = s:UpdateMruList(self.data, { 'word' : a:cmd, 'time' : localtime() },
        \                         self.max_item, self.excluded_command)
  call s:InfoFileManager.save()
endfunction

" OBJECT: g:FuzzyFinderMode.Bookmark ------------------------------------- {{{1
let g:FuzzyFinderMode.Bookmark = copy(g:FuzzyFinderMode.Base)

function! g:FuzzyFinderMode.Bookmark.on_complete(base)
  let patterns = self.make_pattern(a:base)
  let stats = self.get_filtered_stats(a:base)
  let result = s:FilterMatching(self.items, 'word', patterns.re, s:SuffixNumber(patterns.base), self.enumerating_limit)
  return map(result, 's:SetRanks(v:val, v:val.word, a:base, stats)')
endfunction

function! g:FuzzyFinderMode.Bookmark.on_open(expr, mode)
  call filter(self.items, 'v:val.word ==# a:expr')
  if empty(self.items)
    return ''
  endif
  call s:JumpToBookmark(self.items[0].path, a:mode, self.items[0].pattern, self.items[0].lnum, self.searching_range)
endfunction

function! g:FuzzyFinderMode.Bookmark.on_mode_enter_post()
  let self.items = copy(self.data)
  let self.items = map(self.items, 's:SetFormattedTimeToMenu(v:val, self.time_format)')
  let self.items = s:MapToSetSerialIndex(self.items, 1)
  let self.items = map(self.items, 's:SetFormattedAbbr(v:val, "word", self.trim_length)')
endfunction

function! g:FuzzyFinderMode.Bookmark.bookmark_here(word)
  if !empty(&buftype) || expand('%') !~ '\S'
    call s:EchoWithHl('Can''t bookmark this buffer.', 'WarningMsg')
    return
  endif
  let item = {
        \   'word' : (a:word =~ '\S' ? substitute(a:word, '\n', ' ', 'g')
        \                            : pathshorten(expand('%:p:~')) . '|' . line('.') . '| ' . getline('.')),
        \   'path' : expand('%:p'),
        \   'lnum' : line('.'),
        \   'pattern' : s:GetLinePattern(line('.')),
        \   'time' : localtime(),
        \ }
  let item.word = s:InputHl('Bookmark as:', item.word, 'Question')
  if item.word !~ '\S'
    call s:EchoWithHl('Canceled', 'WarningMsg')
    return
  endif
  call s:InfoFileManager.load()
  call insert(self.data, item)
  call s:InfoFileManager.save()
endfunction

" OBJECT: g:FuzzyFinderMode.Tag ----------------------------------------- {{{1
let g:FuzzyFinderMode.Tag = copy(g:FuzzyFinderMode.Base)

function! g:FuzzyFinderMode.Tag.on_complete(base)
  let patterns = self.make_pattern(a:base)
  let stats = self.get_filtered_stats(a:base)
  let result = self.find_tag(patterns.re, s:SuffixNumber(patterns.base), self.enumerating_limit)
  return map(result, 's:SetRanks(v:val, v:val.word, a:base, stats)')
endfunction

function! g:FuzzyFinderMode.Tag.on_open(expr, mode)
  execute [
        \   ':tjump ',
        \   ':stjump ',
        \   ':vertical :stjump ',
        \   ':tab :stjump ',
        \ ][a:mode] . a:expr
endfunction

function! g:FuzzyFinderMode.Tag.on_mode_enter_pre()
  let self.tag_files = s:GetCurrentTagFiles()
endfunction

function! g:FuzzyFinderMode.Tag.find_tag(pattern, index, limit)
  if !len(self.tag_files)
    return []
  endif
  let key = join(self.tag_files, "\n")
  " cache not created or tags file updated? 
  call extend(self, { 'cache' : {} }, 'keep')
  if !exists('self.cache[key]') || max(map(copy(self.tag_files), 'getftime(v:val) >= self.cache[key].time'))
    echo 'Caching tag list...'
    let items = s:Unique(s:Concat(map(copy(self.tag_files), 's:GetTagList(v:val)')))
    let items = s:MapToSetSerialIndex(map(items, '{ "word" : v:val }'), 1)
    let self.cache[key] = { 'time'  : localtime(), 'items' : items }
  endif
  echo 'Filtering tag list...'
  let result = s:FilterMatching(self.cache[key].items, 'word', a:pattern, a:index, a:limit)
  return map(result, 's:SetFormattedAbbr(v:val, "word", self.trim_length)')
endfunction

" OBJECT: g:FuzzyFinderMode.TaggedFile ---------------------------------- {{{1
let g:FuzzyFinderMode.TaggedFile = copy(g:FuzzyFinderMode.Base)

function! g:FuzzyFinderMode.TaggedFile.on_complete(base)
  let patterns = self.make_pattern(a:base)
  let base_tail = s:SplitPath(a:base).tail
  let stats = self.get_filtered_stats(a:base)
  echo 'Making tagged file list...'
  let result = self.find_tagged_file(patterns.re, s:SuffixNumber(patterns.base), self.enumerating_limit)
  return map(result, 's:SetRanks(v:val, s:SplitPath(matchstr(v:val.word, ''^.*[^/\\]'')).tail, base_tail, stats)')
endfunction

function! g:FuzzyFinderMode.TaggedFile.on_mode_enter_pre()
  let self.tag_files = s:GetCurrentTagFiles()
endfunction

function! g:FuzzyFinderMode.TaggedFile.find_tagged_file(pattern, index, limit)
  if !len(self.tag_files)
    return []
  endif
  let key = join(self.tag_files, "\n")
  " cache not created or tags file updated? 
  call extend(self, { 'cache' : {} }, 'keep')
  if !exists('self.cache[key]') || max(map(copy(self.tag_files), 'getftime(v:val) >= self.cache[key].time'))
    echo 'Caching tagged-file list...'
    let items = s:Unique(s:Concat(map(copy(self.tag_files), 's:GetTaggedFileList(v:val)')))
    let items = s:MapToSetSerialIndex(map(items, '{ "word" : v:val }'), 1)
    let self.cache[key] = { 'time'  : localtime(), 'items' : items }
  endif
  echo 'Filtering tagged-file list...'
  call map(self.cache[key].items, 's:ModifyWordAsFilename(v:val, '':.'')')
  let result = s:FilterMatching(self.cache[key].items, 'word', a:pattern, a:index, a:limit)
  return map(result, 's:SetFormattedAbbr(v:val, "word", self.trim_length)')
endfunction

" OBJECT: s:OptionManager ----------------------------------------------- {{{1
" sets or restores temporary options
let s:OptionManager = { 'originals' : {} }

function! s:OptionManager.set(name, value)
  call extend(self.originals, { a:name : eval('&' . a:name) }, 'keep')
  execute printf('let &%s = a:value', a:name)
endfunction

function! s:OptionManager.restore_all()
  for [name, value] in items(self.originals)
    execute printf('let &%s = value', name)
  endfor
  let self.originals = {}
endfunction

" OBJECT: s:WindowManager ----------------------------------------------- {{{1
" manages buffer/window for fuzzyfinder
let s:WindowManager = { 'buf_nr' : -1 }

function! s:WindowManager.activate(complete_func)
  let cwd = getcwd()
  let self.buf_nr = s:Open1LineBuffer(self.buf_nr, '[Fuzzyfinder]')
  call s:SetLocalOptionsForFuzzyfinder(cwd, a:complete_func)
  redraw " for 'lazyredraw'
  if exists(':AutoComplPopLock') | execute ':AutoComplPopLock' | endif
endfunction

function! s:WindowManager.deactivate()
  if exists(':AutoComplPopUnlock') | execute ':AutoComplPopUnlock' | endif
  " must close after returning to previous window
  wincmd j
  execute self.buf_nr . 'bdelete'
endfunction

" Returns a buffer number. Creates new buffer if a:buf_nr is a invalid number
function! s:Open1LineBuffer(buf_nr, buf_name)
  if !bufexists(a:buf_nr)
    leftabove 1new
    execute printf('file `=%s`', string(a:buf_name))
  elseif bufwinnr(a:buf_nr) == -1
    leftabove 1split
    execute a:buf_nr . 'buffer'
    delete _
  elseif bufwinnr(a:buf_nr) != bufwinnr('%')
    execute bufwinnr(a:buf_nr) . 'wincmd w'
  endif
  return bufnr('%')
endfunction

function! s:SetLocalOptionsForFuzzyfinder(cwd, complete_func)
  " countermeasure for auto-cd script
  execute ':lcd ' . a:cwd
  setlocal filetype=fuzzyfinder
  setlocal bufhidden=delete
  setlocal buftype=nofile
  setlocal noswapfile
  setlocal nobuflisted
  setlocal modifiable
  setlocal nocursorline   " for highlighting
  setlocal nocursorcolumn " for highlighting
  let &l:completefunc = a:complete_func
endfunction

" OBJECT: s:InfoFileManager --------------------------------------------- {{{1
let s:InfoFileManager = { 'originals' : {} }

function! s:InfoFileManager.load()
  try
    let lines = readfile(expand(self.get_info_file()))
    " compatibility check
    if !count(lines, self.get_info_version_line())
      call self.warn_old_info()
      let g:FuzzyFinderOptions.Base.info_file = ''
      throw 1
    endif
  catch /.*/ 
    let lines = []
  endtry
  for m in s:GetAvailableModes()
    call m.deserialize_info(lines)
  endfor
endfunction

function! s:InfoFileManager.save()
  let lines = [ self.get_info_version_line() ]
  for m in s:GetAvailableModes()
    let lines += m.serialize_info()
  endfor
  try
    call writefile(lines, expand(self.get_info_file()))
  catch /.*/ 
  endtry
endfunction

function! s:InfoFileManager.edit()
  new
  file `='[FuzzyfinderInfo]'`
  let self.bufnr = bufnr('%')
  setlocal filetype=vim
  setlocal bufhidden=delete
  setlocal buftype=acwrite
  setlocal noswapfile
  augroup FuzzyfinderInfo
    autocmd!
    autocmd BufWriteCmd <buffer> call s:InfoFileManager.on_buf_write_cmd()
  augroup END
  execute '0read ' . expand(self.get_info_file())
  setlocal nomodified
endfunction

function! s:InfoFileManager.on_buf_write_cmd()
  for m in s:GetAvailableModes()
    call m.deserialize_info(getline(1, '$'))
  endfor
  call self.save()
  setlocal nomodified
  execute printf('%dbdelete! ', self.bufnr)
  echo "Information file updated"
endfunction

function! s:InfoFileManager.get_info_version_line()
  return "VERSION\t217"
endfunction

function! s:InfoFileManager.get_info_file()
  return g:FuzzyFinderOptions.Base.info_file
endfunction

function! s:InfoFileManager.warn_old_info()
  call s:EchoWithHl(printf("=================================================================\n" .
        \                  "  Sorry, but your information file for Fuzzyfinder is no longer  \n" .
        \                  "  compatible with this version of Fuzzyfinder. Please remove     \n" .
        \                  "  %-63s\n" .
        \                  "=================================================================\n" ,
        \                  '"' . expand(self.get_info_file()) . '".'),
        \           'WarningMsg')
  echohl Question
  call input('Press Enter')
  echohl None
endfunction

" }}}1
"=============================================================================
" GLOBAL OPTIONS: {{{1
" stores user-defined g:FuzzyFinderOptions ------------------------------ {{{2
let user_options = (exists('g:FuzzyFinderOptions') ? g:FuzzyFinderOptions : {})
" }}}2

" Initializes g:FuzzyFinderOptions.
let g:FuzzyFinderOptions = { 'Base':{}, 'Buffer':{}, 'File':{}, 'Dir':{}, 'MruFile':{}, 'MruCmd':{}, 'Bookmark':{}, 'Tag':{}, 'TaggedFile':{}}
"-----------------------------------------------------------------------------
" [All Mode] This is mapped to select completion item or finish input and
" open a buffer/file in previous window.
let g:FuzzyFinderOptions.Base.key_open = '<CR>'
" [All Mode] This is mapped to select completion item or finish input and
" open a buffer/file in split new window
let g:FuzzyFinderOptions.Base.key_open_split = '<C-j>'
" [All Mode] This is mapped to select completion item or finish input and
" open a buffer/file in vertical-split new window.
let g:FuzzyFinderOptions.Base.key_open_vsplit = '<C-k>'
" [All Mode] This is mapped to select completion item or finish input and
" open a buffer/file in a new tab page.
let g:FuzzyFinderOptions.Base.key_open_tab = '<C-]>'
" [All Mode] This is mapped to switch to the next mode.
let g:FuzzyFinderOptions.Base.key_next_mode = '<C-l>'
" [All Mode] This is mapped to switch to the previous mode.
let g:FuzzyFinderOptions.Base.key_prev_mode = '<C-o>'
" [All Mode] This is mapped to temporarily switch whether or not to ignore
" case.
let g:FuzzyFinderOptions.Base.key_ignore_case = '<C-t>'
" [All Mode] This is the file name to write information of the MRU, etc. If
" "" was set, Fuzzyfinder does not write to the file.
let g:FuzzyFinderOptions.Base.info_file = '~/.vimfuzzyfinder'
" [All Mode] Fuzzyfinder does not start a completion if a length of entered
" text is less than this.
let g:FuzzyFinderOptions.Base.min_length = 0
" [All Mode] This is a dictionary. Each value must be a list. All matchs of a
" key in entered text is expanded with the value.
let g:FuzzyFinderOptions.Base.abbrev_map = {}
" [All Mode] Fuzzyfinder ignores case in search patterns if non-zero is set.
let g:FuzzyFinderOptions.Base.ignore_case = 1
" [All Mode] This is a string to format time string. See :help strftime() for
" details.
let g:FuzzyFinderOptions.Base.time_format = '(%x %H:%M:%S)'
" [All Mode] This is the ceiling for the number of completion statistics to be
" stored.
let g:FuzzyFinderOptions.Base.learning_limit = 100
" [All Mode] To speed up the response time, Fuzzyfinder ends enumerating
" completion items when found over this.
let g:FuzzyFinderOptions.Base.enumerating_limit = 50
" [All Mode] If a length of completion item is more than this, it is trimmed
" when shown in completion menu.
let g:FuzzyFinderOptions.Base.trim_length = 80
" [All Mode] Fuzzyfinder does not remove caches of completion lists at the end
" of explorer to reuse at the next time if non-zero was set.
let g:FuzzyFinderOptions.Base.lasting_cache = 1
" [All Mode] Fuzzyfinder uses Migemo if non-zero is set.
let g:FuzzyFinderOptions.Base.migemo_support = 0
"-----------------------------------------------------------------------------
" [Buffer Mode] This disables all functions of this mode if zero was set.
let g:FuzzyFinderOptions.Buffer.mode_available = 1
" [Buffer Mode] The prompt string.
let g:FuzzyFinderOptions.Buffer.prompt = '>Buffer>'
" [Buffer Mode] The highlight group name for a prompt string.
let g:FuzzyFinderOptions.Buffer.prompt_highlight = 'Question'
" [Buffer Mode] Pressing <BS> after a path separator deletes one directory
" name if non-zero is set.
let g:FuzzyFinderOptions.Buffer.smart_bs = 1
" [Buffer Mode] This is used to sort modes for switching to the next/previous
" mode.
let g:FuzzyFinderOptions.Buffer.switch_order = 10
" [Buffer Mode] The completion items is sorted in the order of recently used
" if non-zero is set.
let g:FuzzyFinderOptions.Buffer.mru_order = 1
"-----------------------------------------------------------------------------
" [File Mode] This disables all functions of this mode if zero was set.
let g:FuzzyFinderOptions.File.mode_available = 1
" [File Mode] The prompt string.
let g:FuzzyFinderOptions.File.prompt = '>File>'
" [File Mode] The highlight group name for a prompt string.
let g:FuzzyFinderOptions.File.prompt_highlight = 'Question'
" [File Mode] Pressing <BS> after a path separator deletes one directory name
" if non-zero is set.
let g:FuzzyFinderOptions.File.smart_bs = 1
" [File Mode] This is used to sort modes for switching to the next/previous
" mode.
let g:FuzzyFinderOptions.File.switch_order = 20
" [File Mode] The items matching this are excluded from the completion list.
let g:FuzzyFinderOptions.File.excluded_path = '\v\~$|\.o$|\.exe$|\.bak$|\.swp$|((^|[/\\])\.[/\\]$)'
"-----------------------------------------------------------------------------
" [Directory Mode] This disables all functions of this mode if zero was set.
let g:FuzzyFinderOptions.Dir.mode_available = 1
" [Directory Mode] The prompt string.
let g:FuzzyFinderOptions.Dir.prompt = '>Dir>'
" [Directory Mode] The highlight group name for a prompt string.
let g:FuzzyFinderOptions.Dir.prompt_highlight = 'Question'
" [Directory Mode] Pressing <BS> after a path separator deletes one directory
" name if non-zero is set.
let g:FuzzyFinderOptions.Dir.smart_bs = 1
" [Directory Mode] This is used to sort modes for switching to the
" next/previous mode.
let g:FuzzyFinderOptions.Dir.switch_order = 30
" [Directory Mode] The items matching this are excluded from the completion
" list.
let g:FuzzyFinderOptions.Dir.excluded_path = '\v(^|[/\\])\.{1,2}[/\\]$'
"-----------------------------------------------------------------------------
" [Mru-File Mode] This disables all functions of this mode if zero was set.
let g:FuzzyFinderOptions.MruFile.mode_available = 1
" [Mru-File Mode] The prompt string.
let g:FuzzyFinderOptions.MruFile.prompt = '>MruFile>'
" [Mru-File Mode] The highlight group name for a prompt string.
let g:FuzzyFinderOptions.MruFile.prompt_highlight = 'Question'
" [Mru-File Mode] Pressing <BS> after a path separator deletes one directory
" name if non-zero is set.
let g:FuzzyFinderOptions.MruFile.smart_bs = 1
" [Mru-File Mode] This is used to sort modes for switching to the
" next/previous mode.
let g:FuzzyFinderOptions.MruFile.switch_order = 40
" [Mru-File Mode] The items matching this are excluded from the completion
" list.
let g:FuzzyFinderOptions.MruFile.excluded_path = '\v\~$|\.bak$|\.swp$'
" [Mru-File Mode] This is the ceiling for the number of MRU items to be
" stored.
let g:FuzzyFinderOptions.MruFile.max_item = 200
"-----------------------------------------------------------------------------
" [Mru-Cmd Mode] This disables all functions of this mode if zero was set.
let g:FuzzyFinderOptions.MruCmd.mode_available = 1
" [Mru-Cmd Mode] The prompt string.
let g:FuzzyFinderOptions.MruCmd.prompt = '>MruCmd>'
" [Mru-Cmd Mode] The highlight group name for a prompt string.
let g:FuzzyFinderOptions.MruCmd.prompt_highlight = 'Question'
" [Mru-Cmd Mode] Pressing <BS> after a path separator deletes one directory
" name if non-zero is set.
let g:FuzzyFinderOptions.MruCmd.smart_bs = 0
" [Mru-Cmd Mode] This is used to sort modes for switching to the next/previous
" mode.
let g:FuzzyFinderOptions.MruCmd.switch_order = 50
" [Mru-Cmd Mode] The items matching this are excluded from the completion
" list.
let g:FuzzyFinderOptions.MruCmd.excluded_command = '^$'
" [Mru-Cmd Mode] This is the ceiling for the number of MRU items to be stored.
let g:FuzzyFinderOptions.MruCmd.max_item = 200
"-----------------------------------------------------------------------------
" [Bookmark Mode] This disables all functions of this mode if zero was set.
let g:FuzzyFinderOptions.Bookmark.mode_available = 1
" [Bookmark Mode] The prompt string.
let g:FuzzyFinderOptions.Bookmark.prompt = '>Bookmark>'
" [Bookmark Mode] The highlight group name for a prompt string.
let g:FuzzyFinderOptions.Bookmark.prompt_highlight = 'Question'
" [Bookmark Mode] Pressing <BS> after a path separator deletes one directory
" name if non-zero is set.
let g:FuzzyFinderOptions.Bookmark.smart_bs = 0
" [Bookmark Mode] This is used to sort modes for switching to the
" next/previous mode.
let g:FuzzyFinderOptions.Bookmark.switch_order = 60
" [Bookmark Mode] Fuzzyfinder searches a matching line from bookmarked
" position within this number of lines.
let g:FuzzyFinderOptions.Bookmark.searching_range = 100
"-----------------------------------------------------------------------------
" [Tag Mode] This disables all functions of this mode if zero was set.
let g:FuzzyFinderOptions.Tag.mode_available = 1
" [Tag Mode] The prompt string.
let g:FuzzyFinderOptions.Tag.prompt = '>Tag>'
" [Tag Mode] The highlight group name for a prompt string.
let g:FuzzyFinderOptions.Tag.prompt_highlight = 'Question'
" [Tag Mode] Pressing <BS> after a path separator deletes one directory name
" if non-zero is set.
let g:FuzzyFinderOptions.Tag.smart_bs = 0
" [Tag Mode] This is used to sort modes for switching to the next/previous
" mode.
let g:FuzzyFinderOptions.Tag.switch_order = 70
" [Tag Mode] The items matching this are excluded from the completion list.
let g:FuzzyFinderOptions.Tag.excluded_path = '\v\~$|\.bak$|\.swp$'
"-----------------------------------------------------------------------------
" [Tagged-File Mode] This disables all functions of this mode if zero was set.
let g:FuzzyFinderOptions.TaggedFile.mode_available = 1
" [Tagged-File Mode] The prompt string.
let g:FuzzyFinderOptions.TaggedFile.prompt = '>TaggedFile>'
" [Tagged-File Mode] The highlight group name for a prompt string.
let g:FuzzyFinderOptions.TaggedFile.prompt_highlight = 'Question'
" [Tagged-File Mode] Pressing <BS> after a path separator deletes one
" directory name if non-zero is set.
let g:FuzzyFinderOptions.TaggedFile.smart_bs = 0
" [Tagged-File Mode] This is used to sort modes for switching to the
" next/previous mode.
let g:FuzzyFinderOptions.TaggedFile.switch_order = 80

" overwrites default values of g:FuzzyFinderOptions with user-defined values - {{{2
call map(user_options, 'extend(g:FuzzyFinderOptions[v:key], v:val, ''force'')')
call map(copy(g:FuzzyFinderMode), 'v:val.extend_options()')
" }}}2

" }}}1
"=============================================================================
" COMMANDS/AUTOCOMMANDS/MAPPINGS/ETC.: {{{1

let s:PATH_SEPARATOR = (has('win32') || has('win64') ? '\' : '/')
let s:MATCHING_RATE_BASE = 1000000
let s:ABBR_TRIM_MARK = '...'

augroup FuzzyfinderGlobal
  autocmd!
  autocmd BufEnter     * for m in s:GetAvailableModes() | call m.extend_options() | call m.on_buf_enter() | endfor
  autocmd BufWritePost * for m in s:GetAvailableModes() | call m.extend_options() | call m.on_buf_write_post() | endfor
augroup END

" cnoremap has a problem, which doesn't expand cabbrev.
cmap <silent> <expr> <CR> <SID>OnCmdCR()

command! -bang -narg=? -complete=buffer FuzzyFinderBuffer      call g:FuzzyFinderMode.Buffer.launch    (<q-args>, len(<q-bang>))
command! -bang -narg=? -complete=file   FuzzyFinderFile        call g:FuzzyFinderMode.File.launch      (<q-args>, len(<q-bang>))
command! -bang -narg=? -complete=dir    FuzzyFinderDir         call g:FuzzyFinderMode.Dir.launch       (<q-args>, len(<q-bang>))
command! -bang -narg=? -complete=file   FuzzyFinderMruFile     call g:FuzzyFinderMode.MruFile.launch   (<q-args>, len(<q-bang>))
command! -bang -narg=? -complete=file   FuzzyFinderMruCmd      call g:FuzzyFinderMode.MruCmd.launch    (<q-args>, len(<q-bang>))
command! -bang -narg=? -complete=file   FuzzyFinderBookmark    call g:FuzzyFinderMode.Bookmark.launch  (<q-args>, len(<q-bang>))
command! -bang -narg=? -complete=tag    FuzzyFinderTag         call g:FuzzyFinderMode.Tag.launch       (<q-args>, len(<q-bang>))
command! -bang -narg=? -complete=file   FuzzyFinderTaggedFile  call g:FuzzyFinderMode.TaggedFile.launch(<q-args>, len(<q-bang>))
command! -bang -narg=? -complete=file   FuzzyFinderEditInfo    call s:InfoFileManager.edit()
command! -bang -narg=? -complete=file   FuzzyFinderAddBookmark call g:FuzzyFinderMode.Bookmark.bookmark_here(<q-args>)
command! -bang -narg=0                  FuzzyFinderRemoveCache for m in s:GetAvailableModes() | call m.empty_cache_if_existed(1) | endfor

" }}}1
"=============================================================================
" vim: set fdm=marker:
