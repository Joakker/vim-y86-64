if exists('b:current_syntax')
    finish
endif

" Decimal numbers are of the form $100, while hexadecimal is of the form 0x64
syntax match y86asmNumber /[0-9]\+/
syntax match y86asmNumber /\$[0-9]\+/ contained
syntax match y86asmNumber /0x[0-9a-fA-F]\+/ contained
highlight link y86asmNumber Constant

syntax match y86asmPunctuation /:/
highlight link y86asmPunctuation Operator

syntax match y86asmLabel /[a-zA-Z]\+/ contained
syntax match y86asmLabel /^[a-zA-Z]\+:/ contains=y86asmPunctuation
highlight link y86asmLabel Label

" This would highlight %r0 through %r19, but only %r8 through %r14 actually
" exist. Still, it's more concise than to defining them one by one
syntax match y86asmRegister /%r1\?[0-9]/
syntax match y86asmRegister /\v\%r(s|d)i/
syntax match y86asmRegister /\v\%r(a|b|c|d)x/
syntax match y86asmRegister /\v\%r(s|b)p/
highlight link y86asmRegister Special

" Instruction blocks are always indented, so we can say that the instruction
" itself starts with whitespace
syntax match y86asmInstruction /\v\s+(i|r|m)(r|m)movq?/
syntax match y86asmInstruction /\v\s+i?addq?/
syntax match y86asmInstruction /\v\si?andq?/
syntax match y86asmInstruction /\v\si?xorq?/
syntax match y86asmInstruction /\v\si?subq?/
syntax match y86asmInstruction /\v\sj(mp|ne|eq)/
syntax keyword y86asmInstruction ret call halt
highlight link y86asmInstruction Operator

syntax match y86asmDirective /\v\.(pos|quad|align)/ contained
highlight link y86asmDirective PreProc

syntax region y86asmBlock start=/^/ end=/$/
        \ contains=y86asmInstruction,y86asmLabel,y86asmComment,y86asmRegister,y86asmDirective,y86asmNumber

syntax region y86asmComment start=/#/ end=/$/ keepend
highlight link y86asmComment Comment

let b:current_syntax = 'y86asm'
