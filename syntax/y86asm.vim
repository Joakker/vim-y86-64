if exists('b:current_syntax')
    finish
endif

" Decimal numbers are of the form $100, while hexadecimal is of the form 0x64.
" Normal, decimal notation is also supported
syntax match y86asmNumber /\$\?[0-9]\+/ contained
syntax match y86asmNumber /0x[0-9a-fA-F]\+/ contained
highlight link y86asmNumber Constant

syntax match y86asmColon /:/
highlight link y86asmColon Operator

" Labels that start at the beginning of the line define adresses in memory, and
" so they contain a colon. Labels that don't start at the beginning of the line,
" but don't start with an indent either must be a reference to those adresses.
" Otherwise they are detected as y86asmInstructionError
syntax match y86asmLabel /[a-zA-Z]\+/ contained
syntax match y86asmLabel /^[a-zA-Z]\+:/ contains=y86asmColon
highlight link y86asmLabel Label

" This would highlight %r0 through %r19, but only %r8 through %r14 actually
" exist. Still, it's more concise than to define them one by one
syntax match y86asmRegister /%r1\?[0-9]/
syntax match y86asmRegister /\v\%r(s|d)i/
syntax match y86asmRegister /\v\%r(a|b|c|d)x/
syntax match y86asmRegister /\v\%r(s|b)p/
highlight link y86asmRegister Special

" Catch any indented word that doesn't correspond to a preprocessor or
" instruction statement as an error
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


" Highlight non-indented instructions, no matter their form, as errors
syntax match y86asmInstructionError /\v^(i|r|m)(r|m)movq?/
syntax match y86asmInstructionError /\v^i?addq?/
syntax match y86asmInstructionError /\v^i?andq?/
syntax match y86asmInstructionError /\v^i?xorq?/
syntax match y86asmInstructionError /\v^i?subq?/
syntax match y86asmInstructionError /\v^(ret|halt)/
syntax match y86asmInstructionError /\v^call/
syntax match y86asmInstructionError /\v^j(mp|ne|eq)/
highlight link y86asmInstructionError Error

" Preprocessor directives start with a dot
syntax match y86asmDirective /\v\.(pos|quad|align|long)/ contained nextgroup=y86asmNumber
highlight link y86asmDirective PreProc

" Register references are of the form (%rXX)
syntax region y86asmReference start=/(/ end=/)/ contains=y86asmRegister
highlight link y86asmReference Delimiter

" This is the meat and potatos of the syntax definition. It contains everything
" that can or is indented.
syntax region y86asmBlock start=/^\s\+/ end=/$/
        \ contains=y86asmLabel,y86asmComment,y86asmRegister,y86asmDirective,y86asmNumber,y86asmCall,y86asmJump,y86asmInstructionError,y86asmInstruction,y86asmReference

" TODO directives are only contained in comments
syntax keyword y86asmTodo TODO FIXME XXX contained
highlight link y86asmTodo Todo

" Comments start with a hash sign and continue to the end of the line
syntax region y86asmComment start=/#/ end=/$/ keepend contains=y86asmTodo
highlight link y86asmComment Comment

let b:current_syntax = 'y86asm'
