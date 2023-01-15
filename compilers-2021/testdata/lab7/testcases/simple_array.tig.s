.text
.globl tigermain
.type tigermain, @function
tigermain:
.set tigermain_framesize, 56
subq $56, %rsp
movq %rbx, %rbx
movq %rbx, (tigermain_framesize-16)(%rsp)
movq %rbp, %rbp
movq %rbp, (tigermain_framesize-24)(%rsp)
movq %r12, %r12
movq %r12, (tigermain_framesize-32)(%rsp)
movq %r13, %r13
movq %r13, (tigermain_framesize-40)(%rsp)
movq %r14, %r14
movq %r15, %r15
L6:
movq $1024, %r10
movq %r10, %rbp
callq MaxFree
L7:
addq $0, %rsp
movq %rax, %rax
movq %rax, %rax
movq %rax, %rax
cqto
idivq %rbp
movq %rax, %rax
movq $8, %r10
movq %rax, %rax
cqto
idivq %r10
movq %rax, %rax
movq %rax, %r13
movq $1, %r10
movq %rbp, %rdi
addq %r10, %rdi
movq %rdi, %rdi
movq $1, %rsi
movq %rsi, %rsi
callq init_array
L8:
addq $0, %rsp
movq %rax, %rax
movq %rax, %rax
movq $1, %r10
movq %rbp, %rdi
addq %r10, %rdi
movq %rdi, %rdi
movq $2, %rsi
movq %rsi, %rsi
callq init_array
L9:
addq $0, %rsp
movq %rax, %rax
movq %rax, %r12
movq $0, %r10
movq %r10, %rbx
L3:
cmpq %r13, %rbx
jle L2
L1:
movq $512, %rax
movq $1, %r10
movq %rax, %rax
addq %r10, %rax
movq $8, %r10
movq %rax, %rax
imulq %r10
movq %rax, %rax
movq %r12, %r12
addq %rax, %r12
movq (%r12), %rdi
movq %rdi, %rdi
callq printi
L10:
addq $0, %rsp
movq %rax, %rax
leaq L4(%rip), %rdi
movq %rdi, %rdi
callq print
L11:
addq $0, %rsp
movq %rax, %rax
movq %rax, %rax
jmp L5
L2:
movq $1, %r10
movq %rbp, %rdi
addq %r10, %rdi
movq %rdi, %rdi
movq %rbx, %rsi
movq %r12,(tigermain_framesize-48)(%rsp)
movq %r12,(tigermain_framesize-56)(%rsp)
callq init_array
L12:
addq $0, %rsp
movq %rax, %rax
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
movq (tigermain_framesize-40)(%rsp), %r13
movq %r13, %r13
movq %r14, %r14
movq %r15, %r15


addq $56, %rsp
retq
.size tigermain, .-tigermain
.section .rodata
L4:
.long 1
.string "\n"
.globl GLOBAL_REC_DEC
GLOBAL_REC_DEC:
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
.quad GC6
.quad L11
.quad tigermain_framesize
.quad -1
GC6:
.quad -1
.quad L12
.quad tigermain_framesize
.quad tigermain_framesize-48
.quad tigermain_framesize-56
.quad -1
