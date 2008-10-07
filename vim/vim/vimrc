" -----------------------------------------------------------------------------  
" |                            VIM Settings                                   |
" |                   (see gvimrc for gui vim settings)                       |
" -----------------------------------------------------------------------------  

set nocompatible

" Tabs ************************************************************************
set softtabstop=2
set shiftwidth=2
set tabstop=2
set expandtab
set sta " a <Tab> in an indent inserts 'shiftwidth' spaces


" Indenting ********************************************************************
set ai " Automatically set the indent of a new line (local to buffer)
set si " smartindent	(local to buffer)


" Scrollbars ******************************************************************
set sidescrolloff=2
set numberwidth=4


" Windows *********************************************************************
set equalalways " Multiple windows, when created, are equal in size
set splitbelow splitright


" Cursor highlights ***********************************************************
set cursorline
"set cursorcolumn


" Searching *******************************************************************
set hlsearch  " highlight search
set incsearch  " incremental search, search as you type
set ignorecase " Ignore case when searching 
set smartcase " Ignore case when searching lowercase


" Colors **********************************************************************
"set t_Co=256 " 256 colors
set background=dark 
syntax on " syntax highlighting
colorscheme ir_dark


" Status Line *****************************************************************
set showcmd
set ruler " Show ruler
"set ch=2 " Make command line two lines high


" Line Wrapping ***************************************************************
set nowrap
set linebreak  " Wrap at word


" Directories *****************************************************************
" Setup backup location and enable
"set backupdir=~/backup/vim
"set backup

" Set Swap directory
"set directory=~/backup/vim/swap

" Sets path to directory buffer was loaded from
autocmd BufEnter * lcd %:p:h


" File Stuff ******************************************************************
filetype plugin indent on
" To show current filetype use: set filetype

autocmd FileType html :set filetype=xhtml " we couldn't care less about html


" Inser New Line **************************************************************
map <S-Enter> O<ESC> " awesome, inserts new line without going into insert mode
map <Enter> o<ESC>
set fo-=r " do not insert a comment leader after an enter, (no work, fix!!)


" Sessions ********************************************************************
" Sets what is saved when you save a session
set sessionoptions=blank,buffers,curdir,folds,help,resize,tabpages,winsize


" Misc ************************************************************************
set backspace=indent,eol,start
set number " Show line numbers
set matchpairs+=<:>
set vb t_vb= " Turn off the bell, this could be more annoying, but I'm not sure how

" Set list Chars - for showing characters that are not
" normally displayed i.e. whitespace, tabs, EOL
"set listchars=trail:.,tab:>-,eol:$
"set nolist


" Mappings ********************************************************************
" Professor VIM says '87% of users prefer jj over esc', jj abrams strongly disagrees
imap jj <Esc>
imap uu _
"imap ,a @


" Mouse ***********************************************************************
"set mouse=a " Enable the mouse
"behave xterm
"set selectmode=mouse


" Cursor Movement *************************************************************
" Make cursor move by visual lines instead of file lines (when wrapping)
map <up> gk
map k gk
imap <up> <C-o>gk
map <down> gj
map j gj
imap <down> <C-o>gj
map E ge


" Ruby stuff ******************************************************************
"compiler ruby         " Enable compiler support for ruby
"map <F5> :!ruby %<CR>


" Omni Completion *************************************************************
autocmd FileType html :set omnifunc=htmlcomplete#CompleteTags
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete " may require ruby compiled in



" -----------------------------------------------------------------------------  
" |                              Pluggins                                     |
" -----------------------------------------------------------------------------  

" SnippetsEmu *****************************************************************
"imap <unique> <C-j> <Plug>Jumper
"let g:snip_start_tag = "_\."
"let g:snip_end_tag = "\._"
"let g:snip_elem_delim = ":"
"let g:snip_set_textmate_cp = '1'  " Tab to expand snippets, not automatically.


" Fuzzyfinder *****************************************************************
" Fuzzy finder rocks, like Command-T in TextMate (buggy at moment, fix!!)
let g:FuzzyFinderOptions = { 'Base':{}, 'Buffer':{}, 'File':{}, 'MruFile':{}, 'FavFile':{}, 'Dir':{}, 'Tag':{}, 'TaggedFile':{}}
let g:FuzzyFinderOptions.Base.abbrev_map = { "^Project-" : ["**/"], }
let g:FuzzyFinderOptions.Base.migemo_support = 0
let g:FuzzyFinderOptions.File.excluded_path = '\v\~$|\.o$|\.git/|\.DS_Store|\.exe$|\.bak$|\.swp$|((^|[/\\])\.[/\\]$)'
map ,f :FuzzyFinderFile Project-<CR>
map ,b :FuzzyFinderBuffer<CR>


" autocomplpop ***************************************************************
" complete option
"set complete=.,w,b,u,t,k
"let g:AutoComplPop_CompleteOption = '.,w,b,u,t,k'
"set complete=.
let g:AutoComplPop_IgnoreCaseOption = 0
let g:AutoComplPop_BehaviorKeywordLength = 2


" -----------------------------------------------------------------------------  
" |                             OS Specific                                   |
" |                      (GUI stuff goes in gvimrc)                           |
" -----------------------------------------------------------------------------  

" Mac *************************************************************************
"if has("mac") 
  "" 
"endif
 
" Windows *********************************************************************
"if has("gui_win32")
  "" 
"endif




" -----------------------------------------------------------------------------  
" |                              Test Stuff                                   |
" -----------------------------------------------------------------------------  

"" http://vim.wikia.com/wiki/Get_the_correct_indent_for_new_lines_despite_blank_lines
"function! IndentIgnoringBlanks(child)
  "while v:lnum > 1 && getline(v:lnum-1) == ""
    "normal k
    "let v:lnum = v:lnum - 1
  "endwhile
  "if a:child == ""
    "if v:lnum <= 1 || ! &autoindent
      "return 0
    "elseif &cindent
      "return cindent(v:lnum)
    "else
      "return indent(v:lnum-1)
    "endif
  "else
    "exec "let indent=".a:child
    "return indent==-1?indent(v:lnum-1):indent
  "endif
"endfunction
"augroup IndentIgnoringBlanks
  "au!
  "au FileType * if match(&indentexpr,'IndentIgnoringBlanks') == -1 |
        "\ let &indentexpr = "IndentIgnoringBlanks('".
        "\ substitute(&indentexpr,"'","''","g")."')" |
        "\ endif
"augroup END


" make p in Visual mode overwrite the selected text with the previously yanked text
"vnoremap p <Esc>:let current_reg = @"<CR>gvs<C-R>=current_reg<CR><Esc>

"This makes Vim break text to avoid lines getting longer than 78 characters.  
"But only for files that have been detected to be plain text
"autocmd FileType text setlocal textwidth=78


" doesn't work right !!
"if exists("loaded_vimspell")
  "set spell_auto_type="tex,mail,text,txt,html,sgml,otl"
  ":SpellAutoEnable
"endif


" Quick find file (I use FuzzyFinder now)
" Use ,f followed by the name:  ,f readme <enter>
" Be careful not to use this in a directory with tons of sub-directories, as it can be slow in that situation
"function! Find(name) 
  "let l:_name = substitute(a:name, "\\s", "*", "g") 
  "let l:list=system("find . -iname '*".l:_name."*' -not -name \"*.class\" -and -not -name \"*.swp\" -and -not -name \"*.svn*\" | perl -ne 'print \"$.\\t$_\"'") 
  "let l:num=strlen(substitute(l:list, "[^\n]", "", "g")) 
  "if l:num < 1 
    "echo "'".a:name."' not found" 
    "return 
  "endif 

  "if l:num != 1 
    "echo l:list 
    "let l:input=input("Which ? (<enter>=nothing)\n") 

    "if strlen(l:input)==0 
      "return 
    "endif 

    "if strlen(substitute(l:input, "[0-9]", "", "g"))>0 
      "echo "Not a number"
      "return 
    "endif 

    "if l:input<1 || l:input>l:num 
      "echo "Out of range" 
      "return 
    "endif 

    "let l:line=matchstr("\n".l:list, "\n".l:input."\t[^\n]*") 
  "else 
    "let l:line=l:list 
  "endif 

  "let l:line=substitute(l:line, "^[^\t]*\t./", "", "") 
  "execute ":e ".l:line 
"endfunction

"command! -nargs=1 Find :call Find("<args>")
"map ,f :Fi 
