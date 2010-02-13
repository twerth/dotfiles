" Helper function for (x)html snippets
if exists('s:did_snip_helper') || &cp || !exists('loaded_snips')
	finish
endif
let s:did_snip_helper = 1

" Automatically closes tag if in xhtml
fun! Close()
	if (!exists("g:force_xhtml"))
		let g:force_xhtml=0
	endif
	
	return (g:force_xhtml != 1 && stridx(&ft, 'xhtml') == -1) ? '' : ' /'
endf
