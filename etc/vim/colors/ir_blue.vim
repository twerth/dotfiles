" ir_blue color scheme
" More at: http://blog.infinitered.com


" ********************************************************************************
" The following are the preferred 16 colors for your terminal
"           Colors      Bright Colors
" Black     #4E4E4E     #7C7C7C
" Red       #FF6C60     #FFB6B0
" Green     #A8FF60     #CEFFAB
" Yellow    #FFFFB6     #FFFFCB
" Blue      #96CBFE     #FFFFCB
" Magenta   #FF73FD     #FF9CFE
" Cyan      #C6C5FE     #DFDFFE
" White     #EEEEEE     #FFFFFF


" ********************************************************************************
set background=dark
hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "ir_blue"


"hi Example         guifg=NONE        guibg=NONE        gui=NONE      ctermfg=NONE        ctermbg=NONE        cterm=NONE

" General colors
hi Normal           guifg=#f6f3e8     guibg=#000026     gui=NONE      ctermfg=NONE        ctermbg=NONE        cterm=NONE
hi NonText          guifg=#000026     guibg=#000026     gui=NONE      ctermfg=black       ctermbg=NONE        cterm=NONE

hi Cursor           guifg=black       guibg=white       gui=NONE      ctermfg=black       ctermbg=white       cterm=reverse
hi LineNr           guifg=#3e3e3e     guibg=#000026     gui=NONE      ctermfg=darkgray    ctermbg=NONE        cterm=NONE

hi VertSplit        guifg=#404040     guibg=#404040     gui=NONE      ctermfg=darkgray    ctermbg=darkgray    cterm=NONE
hi StatusLine       guifg=#CCCCCC     guibg=#404040     gui=italic    ctermfg=white       ctermbg=darkgray    cterm=NONE
hi StatusLineNC     guifg=black       guibg=#404040     gui=NONE      ctermfg=blue        ctermbg=darkgray    cterm=NONE  

hi Folded           guifg=#a0a8b0     guibg=#384048     gui=NONE      ctermfg=NONE        ctermbg=NONE        cterm=NONE
hi Title            guifg=#f6f3e8     guibg=NONE        gui=bold      ctermfg=NONE        ctermbg=NONE        cterm=NONE
hi Visual           guifg=NONE        guibg=#323848     gui=NONE      ctermfg=NONE        ctermbg=NONE        cterm=REVERSE

hi SpecialKey       guifg=#808080     guibg=#343434     gui=NONE      ctermfg=NONE        ctermbg=NONE        cterm=NONE

hi WildMenu         guifg=green       guibg=yellow      gui=NONE      ctermfg=black       ctermbg=yellow      cterm=NONE
hi PmenuSbar        guifg=black       guibg=white       gui=NONE      ctermfg=black       ctermbg=white       cterm=NONE
"hi Ignore           guifg=gray        guibg=black       gui=NONE      ctermfg=NONE        ctermbg=NONE        cterm=NONE

hi Error            guifg=NONE        guibg=NONE        gui=undercurl ctermfg=white       ctermbg=red         cterm=NONE     guisp=#FF6C60 " undercurl color
hi ErrorMsg         guifg=white       guibg=#FF6C60     gui=BOLD      ctermfg=white       ctermbg=red         cterm=NONE
hi WarningMsg       guifg=white       guibg=#FF6C60     gui=BOLD      ctermfg=white       ctermbg=red         cterm=NONE
hi LongLineWarning  guifg=NONE        guibg=#371F1C     gui=underline ctermfg=NONE        ctermbg=NONE	      cterm=underline

" Message displayed in lower left, such as --INSERT--
hi ModeMsg          guifg=black       guibg=#C6C5FE     gui=BOLD      ctermfg=black       ctermbg=cyan        cterm=BOLD

if version >= 700 " Vim 7.x specific colors
  hi CursorLine     guifg=NONE        guibg=#16191A     gui=NONE      ctermfg=NONE        ctermbg=NONE        cterm=BOLD
  hi CursorColumn   guifg=NONE        guibg=#16191A     gui=NONE      ctermfg=NONE        ctermbg=NONE        cterm=BOLD
  hi MatchParen     guifg=#f6f3e8     guibg=#857b6f     gui=BOLD      ctermfg=white       ctermbg=darkgray    cterm=NONE
  hi Pmenu          guifg=#f6f3e8     guibg=#444444     gui=NONE      ctermfg=NONE        ctermbg=NONE        cterm=NONE
  hi PmenuSel       guifg=#000000     guibg=#cae682     gui=NONE      ctermfg=NONE        ctermbg=NONE        cterm=NONE
  hi Search         guifg=NONE        guibg=#2F2F00     gui=underline ctermfg=NONE        ctermbg=NONE	      cterm=underline
endif

" Syntax highlighting
hi Comment          guifg=#7C7C7C     guibg=NONE        gui=NONE      ctermfg=darkgray    ctermbg=NONE        cterm=NONE
hi String           guifg=#A8FF60     guibg=NONE        gui=NONE      ctermfg=green       ctermbg=NONE        cterm=NONE
hi Number           guifg=#FF73FD     guibg=NONE        gui=NONE      ctermfg=magenta     ctermbg=NONE        cterm=NONE

hi Keyword          guifg=#96CBFE     guibg=NONE        gui=NONE      ctermfg=blue        ctermbg=NONE        cterm=NONE
hi PreProc          guifg=#96CBFE     guibg=NONE        gui=NONE      ctermfg=blue        ctermbg=NONE        cterm=NONE
hi Conditional      guifg=#6699CC     guibg=NONE        gui=NONE      ctermfg=blue        ctermbg=NONE        cterm=NONE  " if else end

hi Todo             guifg=#8f8f8f     guibg=NONE        gui=NONE      ctermfg=red         ctermbg=NONE        cterm=NONE
hi Constant         guifg=#99CC99     guibg=NONE        gui=NONE      ctermfg=cyan        ctermbg=NONE        cterm=NONE

hi Identifier       guifg=#C6C5FE     guibg=NONE        gui=NONE      ctermfg=cyan        ctermbg=NONE        cterm=NONE
hi Function         guifg=#FFD2A7     guibg=NONE        gui=NONE      ctermfg=brown       ctermbg=NONE        cterm=NONE
hi Type             guifg=#FFFFB6     guibg=NONE        gui=NONE      ctermfg=yellow      ctermbg=NONE        cterm=NONE
hi Statement        guifg=#6699CC     guibg=NONE        gui=NONE      ctermfg=lightblue   ctermbg=NONE        cterm=NONE

hi Special          guifg=#E18964     guibg=NONE        gui=NONE      ctermfg=white       ctermbg=NONE        cterm=NONE
hi Delimiter        guifg=#00A0A0     guibg=NONE        gui=NONE      ctermfg=cyan        ctermbg=NONE        cterm=NONE
hi Operator         guifg=white       guibg=NONE        gui=NONE      ctermfg=white       ctermbg=NONE        cterm=NONE

hi link Character       Constant
hi link Boolean         Constant
hi link Float           Number
hi link Repeat          Statement
hi link Label           Statement
hi link Exception       Statement
hi link Include         PreProc
hi link Define          PreProc
hi link Macro           PreProc
hi link PreCondit       PreProc
hi link StorageClass    Type
hi link Structure       Type
hi link Typedef         Type
hi link Tag             Special
hi link SpecialChar     Special
hi link SpecialComment  Special
hi link Debug           Special


" Special for Ruby
hi rubyRegexp                  guifg=#B18A3D      guibg=NONE      gui=NONE      ctermfg=brown          ctermbg=NONE      cterm=NONE
hi rubyRegexpDelimiter         guifg=#FF8000      guibg=NONE      gui=NONE      ctermfg=brown          ctermbg=NONE      cterm=NONE
hi rubyEscape                  guifg=white        guibg=NONE      gui=NONE      ctermfg=cyan           ctermbg=NONE      cterm=NONE
hi rubyInterpolationDelimiter  guifg=#00A0A0      guibg=NONE      gui=NONE      ctermfg=blue           ctermbg=NONE      cterm=NONE
hi rubyControl                 guifg=#6699CC      guibg=NONE      gui=NONE      ctermfg=blue           ctermbg=NONE      cterm=NONE  "and break, etc
"hi rubyGlobalVariable          guifg=#FFCCFF      guibg=NONE      gui=NONE      ctermfg=lightblue      ctermbg=NONE      cterm=NONE  "yield
hi rubyStringDelimiter         guifg=#336633      guibg=NONE      gui=NONE      ctermfg=lightgreen     ctermbg=NONE      cterm=NONE
"rubyInclude
"rubySharpBang
"rubyAccess
"rubyPredefinedVariable
"rubyBoolean
"rubyClassVariable
"rubyBeginEnd
"rubyRepeatModifier
"hi link rubyArrayDelimiter    Special  " [ , , ]
"rubyCurlyBlock  { , , }

hi link rubyClass             Keyword 
hi link rubyModule            Keyword 
hi link rubyKeyword           Keyword 
hi link rubyOperator          Operator
hi link rubyIdentifier        Identifier
hi link rubyInstanceVariable  Identifier
hi link rubyGlobalVariable    Identifier
hi link rubyClassVariable     Identifier
hi link rubyConstant          Type  


" Special for Java
" hi link javaClassDecl    Type
hi link javaScopeDecl         Identifier 
hi link javaCommentTitle      javaDocSeeTag 
hi link javaDocTags           javaDocSeeTag 
hi link javaDocParam          javaDocSeeTag 
hi link javaDocSeeTagParam    javaDocSeeTag 

hi javaDocSeeTag              guifg=#CCCCCC     guibg=NONE        gui=NONE      ctermfg=darkgray    ctermbg=NONE        cterm=NONE
hi javaDocSeeTag              guifg=#CCCCCC     guibg=NONE        gui=NONE      ctermfg=darkgray    ctermbg=NONE        cterm=NONE
"hi javaClassDecl              guifg=#CCFFCC     guibg=NONE        gui=NONE      ctermfg=white       ctermbg=NONE        cterm=NONE


" Special for XML
hi link xmlTag          Keyword 
hi link xmlTagName      Conditional 
hi link xmlEndTag       Identifier 


" Special for HTML
hi link htmlTag         Keyword 
hi link htmlTagName     Conditional 
hi link htmlEndTag      Identifier 


" Special for Javascript
hi link javaScriptNumber      Number 


" Special for Python
"hi  link pythonEscape         Keyword      


" Special for CSharp
hi  link csXmlTag             Keyword      


" Special for PHP
