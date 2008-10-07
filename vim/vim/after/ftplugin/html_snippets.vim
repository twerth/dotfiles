" Note, many snippets have a 'l'ong version, which is the multiline version, as well as the normal version which is on one line;
" such as div and divl, p an pl, etc.
"
" Extra spaces after some tags, such as img and base ( <img /> <br /> ), are intentional for compatibility with older browsers
" 
" Available Snippets ******************************************
" xml
" doctype
" 
" html 
"   head 
"     meta base link shortcut style
"     
"     script scriptsrc noscript
"
"   body
"     div divl span
"     
"     tg tgl at
"     
"     h1 h1l h2 h2l h3 h3l h4 h4l h5 h5l h6 h6l
"     
"     p pl
"     
"     st em del ins
"     
"     aref mailto
"     
"     img
"     
"     ul ol li
"     
"     code pre
"     
"     br space
"     
"     table tr td tfoot
"     
"     form fieldset legend label input select optgroup opt txtarea
"     
"     bq ct
"     
"     dl dt
"     
"     hint movie
"     
"     cmt cdata
"     
"     lorem loreml


if !exists('loaded_snippet') || &cp
    finish
endif

" Due to issues with IE 6, you should leave off the XML declaration if you are targeting such browsers
Snippet xml <?xml version="<{"1.0"}>" encoding="<{"UTF-8"}>"?><CR><CR><{}>

function! SelectXHTMLDoctype()
    let dt = inputlist(['Select doctype:',
              \ '1. XHTML 1.0 Frameset',
              \ '2. XHTML 1.0 Strict',
              \ '3. XHTML 1.0 Transitional' ])
    let dts = { 1: "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Frameset//EN\"\n\"http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd\">\n\n",
              \ 2: "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\"\n\"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">\n\n",
              \ 3: "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\"\n\"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n\n"}
    return dts[dt]
endfunction
Snippet doctype ``SelectXHTMLDoctype()``

Snippet html <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="<{en}>" lang="<{en}>"><CR><{}><CR></html>

Snippet head <head><CR><meta http-equiv="Content-type" content="text/html; charset=utf-8"/><CR><title><{}></title><CR><{}><CR></head><CR>
Snippet meta <meta name="<{name}>" content="<{content}>" /><{}>

Snippet base <base href="<{}>" /><{}> 
Snippet link <link rel="<{stylesheet}>" href="<{"/stylesheets/base.css"}>" type="text/css" media="<{all}>" title="<{standard}>" charset="<{"utf-8"}>" /><{}>
Snippet shortcut <link rel="shortcut icon" href="<{"favicon.ico"}>" /><{}>
Snippet style <style type="text/css" media="<{screen}>"><CR>/* <![CDATA[ */<CR><{}><CR>/* ]]> */<CR></style>

Snippet script <script type="text/javascript" charset="<{"utf-8"}>"><CR>// <![CDATA[<CR><{}><CR>// ]]><CR></script>
Snippet scriptsrc <script src="<{}>" type="text/javascript" charset="<{"utf-8"}>"></script><{}>
Snippet noscript <noscript><CR><{}><CR></noscript>

Snippet body <body><CR><{}><CR></body>

Snippet div <div id="<{id}>"><{}></div><{}>
Snippet divl <div id="<{id}>"><CR><{}><CR></div> <!-- <{id}> --><CR>
Snippet span <span class="<{}>"><{}></span><{}>

Snippet tg <<{tag}><{}>><{}></<{tag}>><{}>
Snippet tgl <<{tag}>><CR><{}><CR></<{tag}>>
Snippet at <{}>="<{}>" <{}>

Snippet h1 <h1><{}></h1><{}>
Snippet h1l <h1><CR><{}><CR></h1>
Snippet h2 <h2><{}></h2><{}>
Snippet h2l <h2><CR><{}><CR></h2>
Snippet h3 <h3><{}></h3><{}>
Snippet h3l <h3><CR><{}><CR></h3>
Snippet h4 <h4><{}></h4><{}>
Snippet h4l <h4><CR><{}><CR></h4>
Snippet h5 <h5><{}></h5><{}>
Snippet h5l <h5><CR><{}><CR></h5>
Snippet h6 <h6><{}></h6><{}>
Snippet h6l <h6><CR><{}><CR></h6>

Snippet p <p><{}></p><{}>
Snippet pl <p><CR><{}><CR></p>

Snippet st <strong><{}></strong> <{}>
Snippet em <em><{}></em> <{}>
Snippet del <del><{}></del> <{}>
Snippet ins <ins><{}></ins> <{}>

Snippet aref <a href="<{}>" title="<{}>"><{}></a><{}>
Snippet mailto <a href="mailto:<{}>?subject=<{}>"><{}></a><{}>

Snippet img <img src="<{}>" alt="<{" "}>" <{}>/><{}>

Snippet ul <ul><CR><{}><CR></ul>
Snippet ol <ol><CR><{}><CR></ol>
Snippet li <li><{}></li><CR><{}>

Snippet code <code><{}><CR></code> 
Snippet pre <pre><{}><CR></pre>

Snippet br <br /><{}>
Snippet space &nbsp;<{}>

Snippet table <table summary="<{summary}>" class="<{className}>" width="<{}>" cellspacing="<{}>" cellpadding="<{}>" border="<{}>"><CR><{}><CR></table>
Snippet tr <tr><CR><{}><CR></tr>
Snippet td <td><{}></td><{}>
Snippet tfoot <tfoot><CR><{}><CR></tfoot><{}>

Snippet form <form action="<{urlToGoTo}>" method="<{get}>" id="<{formID}>"><CR><p><CR><{}><CR></p><CR></form>
Snippet fieldset <fieldset><CR><{}><CR></fieldset>
Snippet legend <legend align="<{}>" accesskey="<{}>"><{}></legend><{}>
Snippet label <label for="<{inputItem}>"><{}></label><{}>
Snippet input <input type="<{"text submit hidden button"}>" name="<{name}>" id="<{name}>" value="<{}>" tabindex="<{}>" <{}>/><{}>
Snippet select <select id="<{ID}>" name="<{Name}>" size="<{}>" tabindex="<{}>"><CR><{}><CR></select><CR>
Snippet optgroup <optgroup label="<{Label}>"><CR><{}><CR></optgroup>
Snippet opt <option label="<{label}>" value="<{value}>"><{}></option> <{}>
Snippet txtarea <textarea name="<{name}>" id="<{name}>" rows="<{}>" cols="<{}>" tabindex="<{}>"<{}>><{}></textarea><{}>

Snippet bq <blockquote><p><{}></p></blockquote><CR><{}>
Snippet bql <blockquote><p><CR><{}><CR></p></blockquote><CR><{}>
Snippet ct <cite><{}></cite><CR><{}>

Snippet dl <dl><CR><{}><CR></dl>
Snippet dt <dt><{}></dt><CR><dd><{}></dd><{}>

Snippet hint <span class="hint"><{}></span><{}>
Snippet movie <object width="<{}>" height="<{}>"<CR>classid="clsid:02BF25D5-8C17-4B23-BC80-D3488ABDDC6B"<CR>codebase="http://www.apple.com/qtactivex/qtplugin.cab"><CR><param name="src"<CR>value="<{}>" /><CR><param name="controller" value="<{}>" /><CR><param name="autoplay" value="<{}>" /><CR><embed src="<{}>"<CR>width="<{}>" height="<{}>"<CR>controller="<{}>" autoplay="<{}>"<CR>scale="tofit" cache="true"<CR>pluginspage="http://www.apple.com/quicktime/download/"<CR>/><CR></object><CR><{}>

Snippet cmt <!-- <{}> -->
Snippet cdata <![CDATA[ <{}> ]]>

Snippet lorem Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
Snippet loreml Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod<CR>tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim<CR>veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea<CR>commodo consequat. Duis aute irure dolor in reprehenderit in voluptate<CR>velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint<CR>occaecat cupidatat non proident, sunt in culpa qui officia deserunt<CR>mollit anim id est laborum.
