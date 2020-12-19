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

syntax match y86asmInstructionError /^\s\+\w\+/ contained
highlight link y86asmInstructionError Error

" Instruction blocks are always indented, so we can say that the instruction
" itself starts with whitespace
syntax match y86asmInstruction /\v\s+(i|r|m)(r|m)movq?/ contained
syntax match y86asmInstruction /\v\s+i?addq?/ contained
syntax match y86asmInstruction /\v\s+i?andq?/ contained
syntax match y86asmInstruction /\v\s+i?xorq?/ contained
syntax match y86asmInstruction /\v\s+i?subq?/ contained
syntax match y86asmInstruction /\v\s+(ret|halt)/ contained
highlight link y86asmInstruction Operator

syntax match y86asmCall /\v\s+call/ contained
highlight link y86asmCall Function

syntax match y86asmJump /\v\s+j(mp|ne|eq)/ contained
highlight link y86asmJump Repeat

syntax match y86asmDirective /\v\.(pos|quad|align)/ contained
highlight link y86asmDirective PreProc

syntax region y86asmBlock start=/^\s\+/ end=/$/
        \ contains=y86asmLabel,y86asmComment,y86asmRegister,y86asmDirective,y86asmNumber,y86asmCall,y86asmJump,y86asmInstructionError,y86asmInstruction

syntax region y86asmComment start=/#/ end=/$/ keepend
highlight link y86asmComment Comment

let b:current_syntax = 'y86asm'
