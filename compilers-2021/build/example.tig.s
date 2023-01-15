.text
.globl insert
.type insert, @function
insert:
.set insert_framesize, 16
subq $16, %rsp
movq %rbx, %rbx
movq %rbp, %rbp
movq %r12, %r12
movq %r13, %r13
movq %r14, %r14
movq %r15, %r15
L69:
movq %rdx, %rdx
movq %rsi, %rsi
movq %rdi,(insert_framesize-8)(%rsp)
movq %rsi, %r11
movq %rsi, %r10
movq $0, %r10
cmpq %r10, %rsi
je L23
L24:
movq $0, %r8
movq %rsi, %r10
addq %r8, %r10
movq (%r10), %r9
movq $0, %r8
movq %rdx, %r10
addq %r8, %r10
movq (%r10), %r10
cmpq %r10, %r9
jl L5
L6:
movq $8, %r8
movq %rsi, %r10
addq %r8, %r10
movq (%r10), %r10
movq %r10, %r10
L7:
movq %r10, %r10
L17:
movq $0, %r8
cmpq %r8, %r10
jne L16
L8:
movq $0, %r8
movq %r11, %r10
addq %r8, %r10
movq (%r10), %r9
movq $0, %r8
movq %rdx, %r10
addq %r8, %r10
movq (%r10), %r10
cmpq %r10, %r9
jl L20
L21:
movq %rdx, 8(%r11)
movq $0, %r10
movq %r10, %r10
L22:
movq %rsi, %rax
L25:
movq %rax, %rax
jmp L68
L23:
movq %rdx, %rax
jmp L25
L5:
movq $16, %r8
movq %rsi, %r10
addq %r8, %r10
movq (%r10), %r10
movq %r10, %r10
jmp L7
L16:
movq %r10, %r11
movq $0, %r8
movq %r11, %r10
addq %r8, %r10
movq (%r10), %r9
movq $0, %r8
movq %rdx, %r10
addq %r8, %r10
movq (%r10), %r10
cmpq %r10, %r9
jl L13
L14:
movq $8, %r8
movq %r11, %r10
addq %r8, %r10
movq (%r10), %r10
movq %r10, %r10
L15:
movq %r10, %r10
jmp L17
L13:
movq $16, %r8
movq %r11, %r10
addq %r8, %r10
movq (%r10), %r10
movq %r10, %r10
jmp L15
L20:
movq %rdx, 16(%r11)
movq $0, %r10
movq %r10, %r10
jmp L22
L68:
movq %rbx, %rbx
movq %rbp, %rbp
movq %r12, %r12
movq %r13, %r13
movq %r14, %r14
movq %r15, %r15


addq $16, %rsp
retq
.size insert, .-insert
.globl f
.type f, @function
f:
.set f_framesize, 24
subq $24, %rsp
movq %rbx, %rbx
movq %rbx, (f_framesize-24)(%rsp)
movq %rbp, %rbp
movq %r12, %r12
movq %r13, %r13
movq %r14, %r14
movq %r15, %r15
L71:
movq %rsi, %rbx
movq %rdi,(f_framesize-8)(%rsp)
movq $0, %r10
cmpq %r10, %rbx
jg L29
L30:
movq $0, %rax
movq %rax, %rax
jmp L70
L29:
movq $8, %r11
leaq f_framesize(%rsp), %r10
subq %r11, %r10
movq (%r10), %rdi
movq %rdi, %rdi
movq $10, %r10
movq %rbx, %rax
cqto
idivq %r10
movq %rax, %rax
movq %rax, %rsi
callq f
L72:
addq $0, %rsp
movq %rax, %rax
movq $10, %r10
movq %rbx, %rax
cqto
idivq %r10
movq %rax, %rax
movq $10, %r10
movq %rax, %rax
imulq %r10
movq %rax, %rax
movq %rbx, %r10
subq %rax, %r10
movq %r10, %rbx
leaq L28(%rip), %rdi
movq %rdi, %rdi
callq ord
L73:
addq $0, %rsp
movq %rax, %rax
movq %rax, %rax
movq %rbx, %rdi
addq %rax, %rdi
movq %rdi, %rdi
callq chr
L74:
addq $0, %rsp
movq %rax, %rax
movq %rax, %rax
movq %rax, %rdi
callq print
L75:
addq $0, %rsp
movq %rax, %rax
jmp L30
L70:
movq (f_framesize-24)(%rsp), %rbx
movq %rbx, %rbx
movq %rbp, %rbp
movq %r12, %r12
movq %r13, %r13
movq %r14, %r14
movq %r15, %r15


addq $24, %rsp
retq
.size f, .-f
.globl printint
.type printint, @function
printint:
.set printint_framesize, 24
subq $24, %rsp
movq %rbx, %rbx
movq %rbx, (printint_framesize-24)(%rsp)
movq %rbp, %rbp
movq %r12, %r12
movq %r13, %r13
movq %r14, %r14
movq %r15, %r15
L77:
movq %rsi, %rbx
movq %rdi,(printint_framesize-8)(%rsp)
movq $0, %r10
cmpq %r10, %rbx
jl L41
L42:
movq $0, %r10
cmpq %r10, %rbx
jg L38
L39:
leaq L37(%rip), %rdi
movq %rdi, %rdi
callq print
L78:
addq $0, %rsp
movq %rax, %rax
movq %rax, %rax
L40:
movq %rax, %rax
L43:
leaq L44(%rip), %rdi
movq %rdi, %rdi
callq print
L79:
addq $0, %rsp
movq %rax, %rax
movq %rax, %rax
jmp L76
L41:
leaq L34(%rip), %rdi
movq %rdi, %rdi
callq print
L80:
addq $0, %rsp
movq %rax, %rax
leaq printint_framesize(%rsp), %rdi
movq $0, %rsi
movq %rsi, %rsi
subq %rbx, %rsi
movq %rsi, %rsi
callq f
L81:
addq $0, %rsp
movq %rax, %rax
movq %rax, %rax
jmp L43
L38:
leaq printint_framesize(%rsp), %rdi
movq %rbx, %rsi
callq f
L82:
addq $0, %rsp
movq %rax, %rax
movq %rax, %rax
jmp L40
L76:
movq (printint_framesize-24)(%rsp), %rbx
movq %rbx, %rbx
movq %rbp, %rbp
movq %r12, %r12
movq %r13, %r13
movq %r14, %r14
movq %r15, %r15


addq $24, %rsp
retq
.size printint, .-printint
.globl printtree
.type printtree, @function
printtree:
.set printtree_framesize, 24
subq $24, %rsp
movq %rbx, %rbx
movq %rbx, (printtree_framesize-24)(%rsp)
movq %rbp, %rbp
mo