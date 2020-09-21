let g:serverInit = 0
let s:path = expand('<sfile>:p:h')

function! MDPreview()
  
  if (g:serverInit == 0)
    let g:serverInit = 1
    silent execute "!php -S localhost:8537 -t " . s:path . " &"
    silent execute "!" . g:markdownpreview#browser . " " . s:path . "/views/page.html &"

    augroup SendData
    autocmd BufWritePost *.md call SendData()
    augroup END

  else
    let g:serverInit = 0

    autocmd! SendData BufWritePost *.md

  endif

endfunction

function! SendData()
  silent execute  "!ruby " s:path . "/SendData.rb " @%
endfunction

command! -bar MDPreview call MDPreview()
