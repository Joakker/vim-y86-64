if !exists('g:y64_file_exts')
    let g:y64_file_exts = [ 'ys' ]
endif
for ext in g:y64_file_exts
    execute 'au BufRead,BufNewFile *.' . ext . ' setf y64asm'
endfor
