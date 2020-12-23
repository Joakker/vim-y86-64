if exists('b:current_syntax')
    finish
endif

" Decimal numbers are of the form $100, while hexadecimal is of the form 0x64.
" Normal, decimal notation is also supported
syntax match y64asmNumber /\$\?[0-9]\+/ contained
syntax match y64asmNumber /0x[0-9a-fA-F]\+/ contained
highlight link y64asmNumber Constant

syntax match y64asmColon /:/
highlight link y64asmColon Operator

" Labels that start at the beginning of the line define adresses in memory, and
" so they contain a colon. Labels that don't start at the beginning of the line,
" but don't start with an indent either must be a reference to those adresses.
" Otherwise they are detected as y64asmInstructionError
syntax match y64asmLabel /[a-zA-Z]\+/ contained
syntax match y64asmLabel /^[a-zA-Z]\+:/ contains=y64asmColon
highlight link y64asmLabel Label

" This would highlight %r0 through %r19, but only %r8 through %r14 actually
" exist. Still, it's more concise than to define them one by one
syntax match y64asmRegister /%r1\?[0-9]/
syntax match y64asmRegister /\v\%r(s|d)i/
syntax match y64asmRegister /\v\%r(a|b|c|d)x/
syntax match y64asmRegister /\v\%r(s|b)p/
highlight link y64asmRegister Special

" Catch any indented word that doesn't correspond to a preprocessor or
" instruction statement as an error
syntax match y64asmInstructionError /^\s\+\w\+/ contained
highlight link y64asmInstructionError Error

" Instruction blocks are always indented, so we can say that the instruction
" itself starts with whitespace
syntax match y64asmInstruction /\v\s+(i|r|m)(r|m)movq?/ contained
syntax match y64asmInstruction /\v\s+i?addq?/ contained
syntax match y64asmInstruction /\v\s+i?andq?/ contained
syntax match y64asmInstruction /\v\s+i?xorq?/ contained
syntax match y64asmInstruction /\v\s+i?subq?/ contained
syntax match y64asmInstruction /\v\s+(ret|halt)/ contained
highlight link y64asmInstruction Operator

syntax match y64asmCall /\v\s+call/ contained
highlight link y64asmCall Function

syntax match y64asmJump /\v\s+j(mp|ne|eq)/ contained
highlight link y64asmJump Repeat


" Highlight non-indented instructions, no matter their form, as errors
syntax match y64asmInstructionError /\v^(i|r|m)(r|m)movq?/
syntax match y64asmInstructionError /\v^i?addq?/
syntax match y64asmInstructionError /\v^i?andq?/
syntax match y64asmInstructionError /\v^i?xorq?/
syntax match y64asmInstructionError /\v^i?subq?/
syntax match y64asmInstructionError /\v^(ret|halt)/
syntax match y64asmInstructionError /\v^call/
syntax match y64asmInstructionError /\v^j(mp|ne|eq)/
highlight link y64asmInstructionError Error

" Preprocessor directives start with a dot
syntax match y64asmDirective /\v\.(pos|quad|align|long)/ contained nextgroup=y64asmNumber
highlight link y64asmDirective PreProc

" Register references are of the form (%rXX)
syntax region y64asmReference start=/(/ end=/)/ contains=y64asmRegister
highlight link y64asmReference Delimiter

" This is the meat and potatos of the syntax definition. It contains everything
" that can or is indented.
syntax region y64asmBlock start=/^\s\+/ end=/$/
        \ contains=y64asmLabel,y64asmComment,y64asmRegister,y64asmDirective,y64asmNumber,y64asmCall,y64asmJump,y64asmInstructionError,y64asmInstruction,y64asmReference

" TODO directives are only contained in comments
syntax keyword y64asmTodo TODO FIXME XXX contained
highlight link y64asmTodo Todo

" Comments start with a hash sign and continue to the end of the line
syntax region y64asmComment start=/#/ end=/$/ keepend contains=y64asmTodo
highlight link y64asmComment Comment

let b:current_syntax = 'y64asm'
