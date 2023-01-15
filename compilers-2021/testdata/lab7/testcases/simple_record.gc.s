.text
.globl tigermain
.type tigermain, @function
tigermain:
.set tigermain_framesize, 32
subq $32, %rsp
movq %rbx, %rbx
movq %rbx, (tigermain_framesize-16)(%rsp)
movq %rbp, %rbp
movq %rbp, (tigermain_framesize-24)(%rsp)
movq %r12, %r12
movq %r12, (tigermain_framesize-32)(%rsp)
movq %r13, %r13
movq %r14, %r14
movq %r15, %r15
L6:
movq $40960, %r10
movq %r10, %rbp
movq $24, %rdi
movq %rdi, %rdi
callq alloc_record
L7:
addq $0, %rsp
movq %rax, %rax
movq %rax, %rax
movq $1, %r10
movq %r10, 0(%rax)
movq $2, %r10
movq %r10, 8(%rax)
movq $3, %r10
movq %r10, 16(%rax)
movq %rax, %rax
movq $24, %rdi
movq %rdi, %rdi
callq alloc_record
L8:
addq $0, %rsp
movq %rax, %rax
movq %rax, %rax
movq $4, %r10
movq %r10, 0(%rax)
movq $5, %r10
movq %r10, 8(%rax)
movq $6, %r10
movq %r10, 16(%rax)
movq %rax, %r12
movq $0, %r10
movq %r10, %rbx
L3:
cmpq %rbp, %rbx
jle L2
L1:
movq $0, %r11
movq %r12, %r10
addq %r11, %r10
movq (%r10), %rdi
movq %rdi, %rdi
callq printi
L9:
addq $0, %rsp
movq %rax, %rax
leaq L4(%rip), %rdi
movq %rdi, %rdi
callq print
L10:
addq $0, %rsp
movq %rax, %rax
movq %rax, %rax
jmp L5
L2:
movq $24, %rdi
movq %rdi, %rdi
callq alloc_record
L11:
addq $0, %rsp
movq %rax, %rax
movq %rax, %rax
movq $1, %r10
movq %r10, 0(%rax)
movq $2, %r10
movq %r10, 8(%rax)
movq $3, %r10
movq %r10, 16(%rax)
movq %rax, %rax
movq $1, %r11
movq %rbx, %r10
addq %r11, %r10
movq %r10, %rbx
jmp L3
L5:
movq (tigermain_framesize-16)(%rsp), %rbx
movq %rbx, %rbx
movq (tigermain_framesize-24)(%rsp), %rbp
movq %rbp, %rbp
movq (tigermain_framesize-32)(%rsp), %r12
movq %r12, %r12
movq %r13, %r13
movq %r14, %r14
movq %r15, %r15


addq $32, %rsp
retq
.size tigermain, .-tigermain
.section .rodata
L4:
.long 1
.string "\n"
.globl GLOBAL_GC_ROOTS
GLOBAL_GC_ROOTS:
GC1:
.quad GC2
.quad L7
.quad tigermain_framesize
.quad -1
GC2:
.quad GC3
.quad L8
.quad tigermain_framesize
.quad -1
GC3:
.quad GC4
.quad L9
.quad tigermain_framesize
.quad -1
GC4:
.quad GC5
.quad L10
.quad tigermain_framesize
.quad -1
GC5:
.quad -1
.quad L11
.quad tigermain_framesize
.quad -1
