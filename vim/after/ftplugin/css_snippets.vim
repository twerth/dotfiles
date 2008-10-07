if !exists('loaded_snippet') || &cp
  finish
endif

" Selector and selector long
Snippet s <{}> { <{}>}<{}>
Snippet sl <{}> {<CR><{}><CR>}

" Property, if you use completion, don't use this, if not, this is handy
Snippet ; <{}>: <{}>; <{}>

Snippet cmt /* <{}> */
