if exists('b:current_syntax')
    finish
endif

" Decimal numbers are of the form $100, while hexadecimal is of the form 0x64
syntax match y86asmNumber /\$[0-9]\+/ contained
syntax match y86asmNumber /0x[0-9a-fA-F]\+/ contained
highlight link y86asmNumber Number

syntax match y86asmLabel /[a-zA-Z]\+/
highlight link y86asmLabel Label

" This would highlight %r0 through %r19, but only %r8 through %r16 actually
" exist. Still, it's more concise than to defining them one by one
syntax match y86asmRegister /%r1\?[0-9]/
highlight link y86asmRegister Special

syntax match y86asmInstruction /\v(i|r|m)(r|m)movq?/ contained
syntax match y86asmInstruction /\v(i|r)raddq?/ contained
highlight link y86asmInstruction Operator

syntax match y86asmDirective /\.[a-zA-Z]\+/
highlight link y86asmDirective PreProc

" A code block (a sequence of valid instructions) is only valid if it is
" indented. This block makes sure the elements within it are highlighted only if
" that is the case
syntax region y86asmCodeBlock start=/\s\+/ end=/$/ contains=y86asmInstruction,y86asmNumber,y86asmRegister,y86asmComment

syntax region y86asmComment start=/#/ end=/$/ keepend
highlight link y86asmComment Comment

let b:current_syntax = 'y86asm'
