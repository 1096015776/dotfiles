augroup detectWxmlfileFiletype
    autocmd!
    autocmd BufRead,BufNewFile *.wxml setfiletype html
    autocmd BufRead,BufNewFile *.wxss setfiletype css
augroup END
