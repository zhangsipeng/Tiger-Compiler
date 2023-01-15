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
L55:
movq %rdx, %rdx
movq %rsi, %rsi
movq %rdi,(insert_framesize-8)(%rsp)
movq %rsi, %r11
movq %rsi, %r10
movq $0, %r10
cmpq %r10, %rsi
je L23
L24:
movq $8, %r8
movq %rsi, %r10
addq %r8, %r10
movq (%r10), %r9
movq $8, %r8
movq %rdx, %r10
addq %r8, %r10
movq (%r10), %r10
cmpq %r10, %r9
jl L5
L6:
movq $16, %r8
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
movq $8, %r8
movq %r11, %r10
addq %r8, %r10
movq (%r10), %r9
movq $8, %r8
movq %rdx, %r10
addq %r8, %r10
movq (%r10), %r10
cmpq %r10, %r9
jl L20
L21:
movq %rdx, 16(%r11)
movq $0, %r10
movq %r10, %r10
L22:
movq %rsi, %rax
L25:
movq %rax, %rax
jmp L54
L23:
movq %rdx, %rax
jmp L25
L5:
movq $24, %r8
movq %rsi, %r10
addq %r8, %r10
movq (%r10), %r10
movq %r10, %r10
jmp L7
L16:
movq %r10, %r11
movq $8, %r8
movq %r11, %r10
addq %r8, %r10
movq (%r10), %r9
movq $8, %r8
movq %rdx, %r10
addq %r8, %r10
movq (%r10), %r10
cmpq %r10, %r9
jl L13
L14:
movq $16, %r8
movq %r11, %r10
addq %r8, %r10
movq (%r10), %r10
movq %r10, %r10
L15:
movq %r10, %r10
jmp L17
L13:
movq $24, %r8
movq %r11, %r10
addq %r8, %r10
movq (%r10), %r10
movq %r10, %r10
jmp L15
L20:
movq %rdx, 24(%r11)
movq $0, %r10
movq %r10, %r10
jmp L22
L54:
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
L57:
movq %rsi, %rbx
movq %rdi,(f_framesize-8)(%rsp)
movq $0, %r10
cmpq %r10, %rbx
jg L29
L30:
movq $0, %rax
movq %rax, %rax
jmp L56
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
L58:
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
L59:
addq $0, %rsp
movq %rax, %rax
movq %rax, %rax
movq %rbx, %rdi
addq %rax, %rdi
movq %rdi, %rdi
callq chr
L60:
addq $0, %rsp
movq %rax, %rax
movq %rax, %rax
movq %rax, %rdi
callq print
L61:
addq $0, %rsp
movq %rax, %rax
jmp L30
L56:
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
L63:
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
L64:
addq $0, %rsp
movq %rax, %rax
movq %rax, %rax
L40:
movq %rax, %rax
L43:
leaq L44(%rip), %rdi
movq %rdi, %rdi
callq print
L65:
addq $0, %rsp
movq %rax, %rax
movq %rax, %rax
jmp L62
L41:
leaq L34(%rip), %rdi
movq %rdi, %rdi
callq print
L66:
addq $0, %rsp
movq %rax, %rax
leaq printint_framesize(%rsp), %rdi
movq $0, %rsi
movq %rsi, %rsi
subq %rbx, %rsi
movq %rsi, %rsi
callq f
L67:
addq $0, %rsp
movq %rax, %rax
movq %rax, %rax
jmp L43
L38:
leaq printint_framesize(%rsp), %rdi
movq %rbx, %rsi
callq f
L68:
addq $0, %rsp
movq %rax, %rax
movq %rax, %rax
jmp L40
L62:
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
movq %r12, %r12
movq %r13, %r13
movq %r14, %r14
movq %r15, %r15
L70:
movq %rsi, %rbx
movq %rdi,(printtree_framesize-8)(%rsp)
movq $0, %r10
cmpq %r10, %rbx
jne L47
L48:
movq $0, %rax
movq %rax, %rax
jmp L69
L47:
movq $8, %r11
leaq printtree_framesize(%rsp), %r10
subq %r11, %r10
movq (%r10), %rdi
movq %rdi, %rdi
movq $16, %r11
movq %rbx, %r10
addq %r11, %r10
movq (%r10), %rsi
movq %rsi, %rsi
callq printtree
L71:
addq $0, %rsp
movq %rax, %rax
movq $8, %r11
leaq printtree_framesize(%rsp), %r10
subq %r11, %r10
movq (%r10), %rdi
movq %rdi, %rdi
movq $8, %r11
movq %rbx, %r10
addq %r11, %r10
movq (%r10), %rsi
movq %rsi, %rsi
callq printint
L72:
addq $0, %rsp
movq %rax, %rax
movq $8, %r11
leaq printtree_framesize(%rsp), %r10
subq %r11, %r10
movq (%r10), %rdi
movq %rdi, %rdi
movq $24, %r11
movq %rbx, %r10
addq %r11, %r10
movq (%r10), %rsi
movq %rsi, %rsi
callq printtree
L73:
addq $0, %rsp
movq %rax, %rax
jmp L48
L69:
movq (printtree_framesize-24)(%rsp), %rbx
movq %rbx, %rbx
movq %rbp, %rbp
movq %r12, %r12
movq %r13, %r13
movq %r14, %r14
movq %r15, %r15


addq $24, %rsp
retq
.size printtree, .-printtree
.globl getnode
.type getnode, @function
getnode:
.set getnode_framesize, 24
subq $24, %rsp
movq %rbx, %rbx
movq %rbx, (getnode_framesize-24)(%rsp)
movq %rbp, %rbp
movq %r12, %r12
movq %r13, %r13
movq %r14, %r14
movq %r15, %r15
L75:
movq %rsi, %rbx
movq %rdi,(getnode_framesize-8)(%rsp)
movq $32, %rdi
movq %rdi, %rdi
callq alloc_record
L76:
addq $0, %rsp
movq %rax, %rax
movq %rax, %rax
movq $1, %r10
movq %r10, (%rax)
movq %rbx, 8(%rax)
movq $0, %r10
movq %r10, 16(%rax)
movq $0, %r10
movq %r10, 24(%rax)
movq %rax, %rax
jmp L74
L74:
movq (getnode_framesize-24)(%rsp), %rbx
movq %rbx, %rbx
movq %rbp, %rbp
movq %r12, %r12
movq %r13, %r13
movq %r14, %r14
movq %r15, %r15


addq $24, %rsp
retq
.size getnode, .-getnode
.globl tigermain
.type tigermain, @function
tigermain:
.set tigermain_framesize, 696
subq $696, %rsp
movq %rbx, %rbx
movq %rbx, (tigermain_framesize-16)(%rsp)
movq %rbp, %rbp
movq %rbp, (tigermain_framesize-24)(%rsp)
movq %r12, %r12
movq %r12, (tigermain_framesize-32)(%rsp)
movq %r13, %r13
movq %r13, (tigermain_framesize-40)(%rsp)
movq %r14, %r14
movq %r14, (tigermain_framesize-48)(%rsp)
movq %r15, %r15
movq %r15, (tigermain_framesize-56)(%rsp)
L78:
callq MaxFree
L79:
addq $0, %rsp
movq %rax, %rax
movq %rax, %r11
movq $1024, %r10
movq %r10, %rbx
movq $512, %rax
movq $1024, %r10
movq %rax, %rax
imulq %r10
movq %rax, %rax
movq %r11, %r11
subq %rax, %r11
movq $32, %r10
movq %r11, %rax
cqto
idivq %r10
movq %rax, %rax
movq %rax, %rax
movq $0, %r10
movq %r10, %rbp
movq $0, %r10
movq %r10, %r15
movq $0, %r10
movq %r10, %r14
movq $0, %r10
movq %r10, %r12
movq $0, %r10
movq %r10, %r10
movq tigermain_framesize(%rsp), %r13
movq %rbp, %rbp
leaq tigermain_framesize(%rsp), %rdi
movq %rbx, %rsi
movq %rbp,(tigermain_framesize-64)(%rsp)
movq %r15,(tigermain_framesize-72)(%rsp)
movq %r14,(tigermain_framesize-80)(%rsp)
movq %r12,(tigermain_framesize-88)(%rsp)
movq %rbp,(tigermain_framesize-96)(%rsp)
movq %r15,(tigermain_framesize-104)(%rsp)
movq %r14,(tigermain_framesize-112)(%rsp)
movq %r12,(tigermain_framesize-120)(%rsp)
callq getnode
L80:
addq $0, %rsp
movq %rax, %rax
movq %rax, %rax
movq %r13, %rdi
movq %rbp, %rsi
movq %rax, %rdx
movq %r15,(tigermain_framesize-128)(%rsp)
movq %r14,(tigermain_framesize-136)(%rsp)
movq %r12,(tigermain_framesize-144)(%rsp)
movq %r15,(tigermain_framesize-152)(%rsp)
movq %r14,(tigermain_framesize-160)(%rsp)
movq %r12,(tigermain_framesize-168)(%rsp)
callq insert
L81:
addq $0, %rsp
movq %rax, %rax
movq %rax, %rbp
movq tigermain_framesize(%rsp), %r13
movq %r15, %r15
leaq tigermain_framesize(%rsp), %rdi
movq $2, %rax
movq %rax, %rax
imulq %rbx
movq %rax, %rax
movq %rax, %rsi
movq %r15,(tigermain_framesize-176)(%rsp)
movq %r14,(tigermain_framesize-184)(%rsp)
movq %r12,(tigermain_framesize-192)(%rsp)
movq %rbp,(tigermain_framesize-200)(%rsp)
movq %r15,(tigermain_framesize-208)(%rsp)
movq %r14,(tigermain_framesize-216)(%rsp)
movq %r12,(tigermain_framesize-224)(%rsp)
movq %rbp,(tigermain_framesize-232)(%rsp)
callq getnode
L82:
addq $0, %rsp
movq %rax, %rax
movq %rax, %rax
movq %r13, %rdi
movq %r15, %rsi
movq %rax, %rdx
movq %r14,(tigermain_framesize-240)(%rsp)
movq %r12,(tigermain_framesize-248)(%rsp)
movq %rbp,(tigermain_framesize-256)(%rsp)
movq %r14,(tigermain_framesize-264)(%rsp)
movq %r12,(tigermain_framesize-272)(%rsp)
movq %rbp,(tigermain_framesize-280)(%rsp)
callq insert
L83:
addq $0, %rsp
movq %rax, %rax
movq %rax, %r15
movq tigermain_framesize(%rsp), %r13
movq %r14, %r14
leaq tigermain_framesize(%rsp), %rdi
movq $3, %rax
movq %rax, %rax
imulq %rbx
movq %rax, %rax
movq %rax, %rsi
movq %r14,(tigermain_framesize-288)(%rsp)
movq %r12,(tigermain_framesize-296)(%rsp)
movq %rbp,(tigermain_framesize-304)(%rsp)
movq %r15,(tigermain_framesize-312)(%rsp)
movq %r14,(tigermain_framesize-320)(%rsp)
movq %r12,(tigermain_framesize-328)(%rsp)
movq %rbp,(tigermain_framesize-336)(%rsp)
movq %r15,(tigermain_framesize-344)(%rsp)
callq getnode
L84:
addq $0, %rsp
movq %rax, %rax
movq %rax, %rax
movq %r13, %rdi
movq %r14, %rsi
movq %rax, %rdx
movq %r12,(tigermain_framesize-352)(%rsp)
movq %rbp,(tigermain_framesize-360)(%rsp)
movq %r15,(tigermain_framesize-368)(%rsp)
movq %r12,(tigermain_framesize-376)(%rsp)
movq %rbp,(tigermain_framesize-384)(%rsp)
movq %r15,(tigermain_framesize-392)(%rsp)
callq insert
L85:
addq $0, %rsp
movq %rax, %rax
movq %rax, %r14
movq tigermain_framesize(%rsp), %r13
movq %r12, %r12
leaq tigermain_framesize(%rsp), %rdi
movq $4, %rax
movq %rax, %rax
imulq %rbx
movq %rax, %rax
movq %rax, %rsi
movq %r12,(tigermain_framesize-400)(%rsp)
movq %rbp,(tigermain_framesize-408)(%rsp)
movq %r15,(tigermain_framesize-416)(%rsp)
movq %r14,(tigermain_framesize-424)(%rsp)
movq %r12,(tigermain_framesize-432)(%rsp)
movq %rbp,(tigermain_framesize-440)(%rsp)
movq %r15,(tigermain_framesize-448)(%rsp)
movq %r14,(tigermain_framesize-456)(%rsp)
callq getnode
L86:
addq $0, %rsp
movq %rax, %rax
movq %rax, %rax
movq %r13, %rdi
movq %r12, %rsi
movq %rax, %rdx
movq %rbp,(tigermain_framesize-464)(%rsp)
movq %r15,(tigermain_framesize-472)(%rsp)
movq %r14,(tigermain_framesize-480)(%rsp)
movq %rbp,(tigermain_framesize-488)(%rsp)
movq %r15,(tigermain_framesize-496)(%rsp)
movq %r14,(tigermain_framesize-504)(%rsp)
callq insert
L87:
addq $0, %rsp
movq %rax, %rax
movq %rax, %r12
leaq tigermain_framesize(%rsp), %rdi
movq %rbp, %rsi
movq %r15,(tigermain_framesize-512)(%rsp)
movq %r14,(tigermain_framesize-520)(%rsp)
movq %r12,(tigermain_framesize-528)(%rsp)
movq %r15,(tigermain_framesize-536)(%rsp)
movq %r14,(tigermain_framesize-544)(%rsp)
movq %r12,(tigermain_framesize-552)(%rsp)
callq printtree
L88:
addq $0, %rsp
movq %rax, %rax
leaq L50(%rip), %rdi
movq %rdi, %rdi
movq %r15,(tigermain_framesize-560)(%rsp)
movq %r14,(tigermain_framesize-568)(%rsp)
movq %r12,(tigermain_framesize-576)(%rsp)
movq %r15,(tigermain_framesize-584)(%rsp)
movq %r14,(tigermain_framesize-592)(%rsp)
movq %r12,(tigermain_framesize-600)(%rsp)
callq print
L89:
addq $0, %rsp
movq %rax, %rax
leaq tigermain_framesize(%rsp), %rdi
movq %r15, %rsi
movq %r14,(tigermain_framesize-608)(%rsp)
movq %r12,(tigermain_framesize-616)(%rsp)
movq %r14,(tigermain_framesize-624)(%rsp)
movq %r12,(tigermain_framesize-632)(%rsp)
callq printtree
L90:
addq $0, %rsp
movq %rax, %rax
leaq L51(%rip), %rdi
movq %rdi, %rdi
movq %r14,(tigermain_framesize-640)(%rsp)
movq %r12,(tigermain_framesize-648)(%rsp)
movq %r14,(tigermain_framesize-656)(%rsp)
movq %r12,(tigermain_framesize-664)(%rsp)
callq print
L91:
addq $0, %rsp
movq %rax, %rax
leaq tigermain_framesize(%rsp), %rdi
movq %r14, %rsi
movq %r12,(tigermain_framesize-672)(%rsp)
movq %r12,(tigermain_framesize-680)(%rsp)
callq printtree
L92:
addq $0, %rsp
movq %rax, %rax
leaq L52(%rip), %rdi
movq %rdi, %rdi
movq %r12,(tigermain_framesize-688)(%rsp)
movq %r12,(tigermain_framesize-696)(%rsp)
callq print
L93:
addq $0, %rsp
movq %rax, %rax
leaq tigermain_framesize(%rsp), %rdi
movq %r12, %rsi
callq printtree
L94:
addq $0, %rsp
movq %rax, %rax
leaq L53(%rip), %rdi
movq %rdi, %rdi
callq print
L95:
addq $0, %rsp
movq %rax, %rax
movq %rax, %rax
jmp L77
L77:
movq (tigermain_framesize-16)(%rsp), %rbx
movq %rbx, %rbx
movq (tigermain_framesize-24)(%rsp), %rbp
movq %rbp, %rbp
movq (tigermain_framesize-32)(%rsp), %r12
movq %r12, %r12
movq (tigermain_framesize-40)(%rsp), %r13
movq %r13, %r13
movq (tigermain_framesize-48)(%rsp), %r14
movq %r14, %r14
movq (tigermain_framesize-56)(%rsp), %r15
movq %r15, %r15


addq $696, %rsp
retq
.size tigermain, .-tigermain
.section .rodata
L28:
.long 1
.string "0"
L34:
.long 1
.string "-"
L37:
.long 1
.string "0"
L44:
.long 1
.string " "
L50:
.long 1
.string "\n"
L51:
.long 1
.string "\n"
L52:
.long 1
.string "\n"
L53:
.long 1
.string "\n"
.globl GLOBAL_REC_DEC
GLOBAL_REC_DEC:
REC_1:
.quad -1
.quad 0
.quad 1
.quad 1
.quad -1
.globl GLOBAL_GC_ROOTS
GLOBAL_GC_ROOTS:
GC1:
.quad GC2
.quad L58
.quad f_framesize
.quad -1
GC2:
.quad GC3
.quad L59
.quad f_framesize
.quad -1
GC3:
.quad GC4
.quad L60
.quad f_framesize
.quad -1
GC4:
.quad GC5
.quad L61
.quad f_framesize
.quad -1
GC5:
.quad GC6
.quad L64
.quad printint_framesize
.quad -1
GC6:
.quad GC7
.quad L65
.quad printint_framesize
.quad -1
GC7:
.quad GC8
.quad L66
.quad printint_framesize
.quad -1
GC8:
.quad GC9
.quad L67
.quad printint_framesize
.quad -1
GC9:
.quad GC10
.quad L68
.quad printint_framesize
.quad -1
GC10:
.quad GC11
.quad L71
.quad printtree_framesize
.quad -1
GC11:
.quad GC12
.quad L72
.quad printtree_framesize
.quad -1
GC12:
.quad GC13
.quad L73
.quad printtree_framesize
.quad -1
GC13:
.quad GC14
.quad L76
.quad getnode_framesize
.quad -1
GC14:
.quad GC15
.quad L79
.quad tigermain_framesize
.quad -1
GC15:
.quad GC16
.quad L80
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-72
.quad tigermain_framesize-80
.quad tigermain_framesize-88
.quad tigermain_framesize-96
.quad tigermain_framesize-104
.quad tigermain_framesize-112
.quad tigermain_framesize-120
.quad -1
GC16:
.quad GC17
.quad L81
.quad tigermain_framesize
.quad tigermain_framesize-128
.quad tigermain_framesize-136
.quad tigermain_framesize-144
.quad tigermain_framesize-152
.quad tigermain_framesize-160
.quad tigermain_framesize-168
.quad -1
GC17:
.quad GC18
.quad L82
.quad tigermain_framesize
.quad tigermain_framesize-176
.quad tigermain_framesize-184
.quad tigermain_framesize-192
.quad tigermain_framesize-200
.quad tigermain_framesize-208
.quad tigermain_framesize-216
.quad tigermain_framesize-224
.quad tigermain_framesize-232
.quad -1
GC18:
.quad GC19
.quad L83
.quad tigermain_framesize
.quad tigermain_framesize-240
.quad tigermain_framesize-248
.quad tigermain_framesize-256
.quad tigermain_framesize-264
.quad tigermain_framesize-272
.quad tigermain_framesize-280
.quad -1
GC19:
.quad GC20
.quad L84
.quad tigermain_framesize
.quad tigermain_framesize-288
.quad tigermain_framesize-296
.quad tigermain_framesize-304
.quad tigermain_framesize-312
.quad tigermain_framesize-320
.quad tigermain_framesize-328
.quad tigermain_framesize-336
.quad tigermain_framesize-344
.quad -1
GC20:
.quad GC21
.quad L85
.quad tigermain_framesize
.quad tigermain_framesize-352
.quad tigermain_framesize-360
.quad tigermain_framesize-368
.quad tigermain_framesize-376
.quad tigermain_framesize-384
.quad tigermain_framesize-392
.quad -1
GC21:
.quad GC22
.quad L86
.quad tigermain_framesize
.quad tigermain_framesize-400
.quad tigermain_framesize-408
.quad tigermain_framesize-416
.quad tigermain_framesize-424
.quad tigermain_framesize-432
.quad tigermain_framesize-440
.quad tigermain_framesize-448
.quad tigermain_framesize-456
.quad -1
GC22:
.quad GC23
.quad L87
.quad tigermain_framesize
.quad tigermain_framesize-464
.quad tigermain_framesize-472
.quad tigermain_framesize-480
.quad tigermain_framesize-488
.quad tigermain_framesize-496
.quad tigermain_framesize-504
.quad -1
GC23:
.quad GC24
.quad L88
.quad tigermain_framesize
.quad tigermain_framesize-512
.quad tigermain_framesize-520
.quad tigermain_framesize-528
.quad tigermain_framesize-536
.quad tigermain_framesize-544
.quad tigermain_framesize-552
.quad -1
GC24:
.quad GC25
.quad L89
.quad tigermain_framesize
.quad tigermain_framesize-560
.quad tigermain_framesize-568
.quad tigermain_framesize-576
.quad tigermain_framesize-584
.quad tigermain_framesize-592
.quad tigermain_framesize-600
.quad -1
GC25:
.quad GC26
.quad L90
.quad tigermain_framesize
.quad tigermain_framesize-608
.quad tigermain_framesize-616
.quad tigermain_framesize-624
.quad tigermain_framesize-632
.quad -1
GC26:
.quad GC27
.quad L91
.quad tigermain_framesize
.quad tigermain_framesize-640
.quad tigermain_framesize-648
.quad tigermain_framesize-656
.quad tigermain_framesize-664
.quad -1
GC27:
.quad GC28
.quad L92
.quad tigermain_framesize
.quad tigermain_framesize-672
.quad tigermain_framesize-680
.quad -1
GC28:
.quad GC29
.quad L93
.quad tigermain_framesize
.quad tigermain_framesize-688
.quad tigermain_framesize-696
.quad -1
GC29:
.quad GC30
.quad L94
.quad tigermain_framesize
.quad -1
GC30:
.quad -1
.quad L95
.quad tigermain_framesize
.quad -1
