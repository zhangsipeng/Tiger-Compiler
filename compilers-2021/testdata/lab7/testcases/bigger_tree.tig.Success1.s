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
movq %r12, %r12
movq %r13, %r13
movq %r14, %r14
movq %r15, %r15
L84:
movq %rsi, %rbx
movq %rdi,(printtree_framesize-8)(%rsp)
movq $0, %r10
cmpq %r10, %rbx
jne L47
L48:
movq $0, %rax
movq %rax, %rax
jmp L83
L47:
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
callq printtree
L85:
addq $0, %rsp
movq %rax, %rax
movq $8, %r11
leaq printtree_framesize(%rsp), %r10
subq %r11, %r10
movq (%r10), %rdi
movq %rdi, %rdi
movq $0, %r11
movq %rbx, %r10
addq %r11, %r10
movq (%r10), %rsi
movq %rsi, %rsi
callq printint
L86:
addq $0, %rsp
movq %rax, %rax
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
L87:
addq $0, %rsp
movq %rax, %rax
jmp L48
L83:
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
L89:
movq %rsi, %rbx
movq %rdi,(getnode_framesize-8)(%rsp)
movq $24, %rdi
movq %rdi, %rdi
callq alloc_record
L90:
addq $0, %rsp
movq %rax, %rax
movq %rax, %rax
movq %rbx, 0(%rax)
movq $0, %r10
movq %r10, 8(%rax)
movq $0, %r10
movq %r10, 16(%rax)
movq %rax, %rax
jmp L88
L88:
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
.set tigermain_framesize, 4704
subq $4704, %rsp
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
L92:
callq MaxFree
L93:
addq $0, %rsp
movq %rax, %rax
movq %rax, %r11
movq $1024, %r10
movq %r10, %r15
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
movq %rax, (tigermain_framesize-64)(%rsp)
movq $0, %r10
movq %r10, %rbp
movq $0, %r10
movq %r10, %r13
movq $0, %r10
movq %r10, %r14
movq $0, %r10
movq %r10, %r12
movq $0, %rax
movq %rax, %rax
movq tigermain_framesize(%rsp), %rbx
movq %rbp, %rbp
leaq tigermain_framesize(%rsp), %rdi
movq %r15, %rsi
movq %rbp,(tigermain_framesize-200)(%rsp)
movq %r13,(tigermain_framesize-208)(%rsp)
movq %r14,(tigermain_framesize-216)(%rsp)
movq %r12,(tigermain_framesize-224)(%rsp)
movq %rbp,(tigermain_framesize-232)(%rsp)
movq %r13,(tigermain_framesize-240)(%rsp)
movq %r14,(tigermain_framesize-248)(%rsp)
movq %r12,(tigermain_framesize-256)(%rsp)
callq getnode
L94:
addq $0, %rsp
movq %rax, %rax
movq %rax, %rax
movq %rbx, %rdi
movq %rbp, %rsi
movq %rax, %rdx
movq %r13,(tigermain_framesize-264)(%rsp)
movq %r14,(tigermain_framesize-272)(%rsp)
movq %r12,(tigermain_framesize-280)(%rsp)
movq %r13,(tigermain_framesize-288)(%rsp)
movq %r14,(tigermain_framesize-296)(%rsp)
movq %r12,(tigermain_framesize-304)(%rsp)
callq insert
L95:
addq $0, %rsp
movq %rax, %rax
movq %rax, %rbp
movq tigermain_framesize(%rsp), %rbx
movq %r13, %r13
leaq tigermain_framesize(%rsp), %rdi
movq $2, %rax
movq %rax, %rax
imulq %r15
movq %rax, %rax
movq %rax, %rsi
movq %r13,(tigermain_framesize-312)(%rsp)
movq %r14,(tigermain_framesize-320)(%rsp)
movq %r12,(tigermain_framesize-328)(%rsp)
movq %rbp,(tigermain_framesize-336)(%rsp)
movq %r13,(tigermain_framesize-344)(%rsp)
movq %r14,(tigermain_framesize-352)(%rsp)
movq %r12,(tigermain_framesize-360)(%rsp)
movq %rbp,(tigermain_framesize-368)(%rsp)
callq getnode
L96:
addq $0, %rsp
movq %rax, %rax
movq %rax, %rax
movq %rbx, %rdi
movq %r13, %rsi
movq %rax, %rdx
movq %r14,(tigermain_framesize-376)(%rsp)
movq %r12,(tigermain_framesize-384)(%rsp)
movq %rbp,(tigermain_framesize-392)(%rsp)
movq %r14,(tigermain_framesize-400)(%rsp)
movq %r12,(tigermain_framesize-408)(%rsp)
movq %rbp,(tigermain_framesize-416)(%rsp)
callq insert
L97:
addq $0, %rsp
movq %rax, %rax
movq %rax, %r13
movq tigermain_framesize(%rsp), %rbx
movq %r14, %r14
leaq tigermain_framesize(%rsp), %rdi
movq $3, %rax
movq %rax, %rax
imulq %r15
movq %rax, %rax
movq %rax, %rsi
movq %r14,(tigermain_framesize-424)(%rsp)
movq %r12,(tigermain_framesize-432)(%rsp)
movq %rbp,(tigermain_framesize-440)(%rsp)
movq %r13,(tigermain_framesize-448)(%rsp)
movq %r14,(tigermain_framesize-456)(%rsp)
movq %r12,(tigermain_framesize-464)(%rsp)
movq %rbp,(tigermain_framesize-472)(%rsp)
movq %r13,(tigermain_framesize-480)(%rsp)
callq getnode
L98:
addq $0, %rsp
movq %rax, %rax
movq %rax, %rax
movq %rbx, %rdi
movq %r14, %rsi
movq %rax, %rdx
movq %r12,(tigermain_framesize-488)(%rsp)
movq %rbp,(tigermain_framesize-496)(%rsp)
movq %r13,(tigermain_framesize-504)(%rsp)
movq %r12,(tigermain_framesize-512)(%rsp)
movq %rbp,(tigermain_framesize-520)(%rsp)
movq %r13,(tigermain_framesize-528)(%rsp)
callq insert
L99:
addq $0, %rsp
movq %rax, %rax
movq %rax, %r14
movq tigermain_framesize(%rsp), %rbx
movq %r12, %r12
leaq tigermain_framesize(%rsp), %rdi
movq $4, %rax
movq %rax, %rax
imulq %r15
movq %rax, %rax
movq %rax, %rsi
movq %r12,(tigermain_framesize-536)(%rsp)
movq %rbp,(tigermain_framesize-544)(%rsp)
movq %r13,(tigermain_framesize-552)(%rsp)
movq %r14,(tigermain_framesize-560)(%rsp)
movq %r12,(tigermain_framesize-568)(%rsp)
movq %rbp,(tigermain_framesize-576)(%rsp)
movq %r13,(tigermain_framesize-584)(%rsp)
movq %r14,(tigermain_framesize-592)(%rsp)
callq getnode
L100:
addq $0, %rsp
movq %rax, %rax
movq %rax, %rax
movq %rbx, %rdi
movq %r12, %rsi
movq %rax, %rdx
movq %rbp,(tigermain_framesize-600)(%rsp)
movq %r13,(tigermain_framesize-608)(%rsp)
movq %r14,(tigermain_framesize-616)(%rsp)
movq %rbp,(tigermain_framesize-624)(%rsp)
movq %r13,(tigermain_framesize-632)(%rsp)
movq %r14,(tigermain_framesize-640)(%rsp)
callq insert
L101:
addq $0, %rsp
movq %rax, %rax
movq %rax, %r12
movq tigermain_framesize(%rsp), %rbx
movq %rbp, %rbp
leaq tigermain_framesize(%rsp), %rdi
movq $2, %rax
movq %rax, %rax
imulq %r15
movq %rax, %rax
movq %rax, %rsi
movq %rbp,(tigermain_framesize-648)(%rsp)
movq %r13,(tigermain_framesize-656)(%rsp)
movq %r14,(tigermain_framesize-664)(%rsp)
movq %r12,(tigermain_framesize-672)(%rsp)
movq %rbp,(tigermain_framesize-680)(%rsp)
movq %r13,(tigermain_framesize-688)(%rsp)
movq %r14,(tigermain_framesize-696)(%rsp)
movq %r12,(tigermain_framesize-704)(%rsp)
callq getnode
L102:
addq $0, %rsp
movq %rax, %rax
movq %rax, %rax
movq %rbx, %rdi
movq %rbp, %rsi
movq %rax, %rdx
movq %r13,(tigermain_framesize-712)(%rsp)
movq %r14,(tigermain_framesize-720)(%rsp)
movq %r12,(tigermain_framesize-728)(%rsp)
movq %r13,(tigermain_framesize-736)(%rsp)
movq %r14,(tigermain_framesize-744)(%rsp)
movq %r12,(tigermain_framesize-752)(%rsp)
callq insert
L103:
addq $0, %rsp
movq %rax, %rax
movq %rax, %rbp
movq tigermain_framesize(%rsp), %rbx
movq %r13, %r13
leaq tigermain_framesize(%rsp), %rdi
movq $4, %rax
movq %rax, %rax
imulq %r15
movq %rax, %rax
movq %rax, %rsi
movq %r13,(tigermain_framesize-760)(%rsp)
movq %r14,(tigermain_framesize-768)(%rsp)
movq %r12,(tigermain_framesize-776)(%rsp)
movq %rbp,(tigermain_framesize-784)(%rsp)
movq %r13,(tigermain_framesize-792)(%rsp)
movq %r14,(tigermain_framesize-800)(%rsp)
movq %r12,(tigermain_framesize-808)(%rsp)
movq %rbp,(tigermain_framesize-816)(%rsp)
callq getnode
L104:
addq $0, %rsp
movq %rax, %rax
movq %rax, %rax
movq %rbx, %rdi
movq %r13, %rsi
movq %rax, %rdx
movq %r14,(tigermain_framesize-824)(%rsp)
movq %r12,(tigermain_framesize-832)(%rsp)
movq %rbp,(tigermain_framesize-840)(%rsp)
movq %r14,(tigermain_framesize-848)(%rsp)
movq %r12,(tigermain_framesize-856)(%rsp)
movq %rbp,(tigermain_framesize-864)(%rsp)
callq insert
L105:
addq $0, %rsp
movq %rax, %rax
movq %rax, %r13
movq tigermain_framesize(%rsp), %rbx
movq %r14, %r14
leaq tigermain_framesize(%rsp), %rdi
movq $6, %rax
movq %rax, %rax
imulq %r15
movq %rax, %rax
movq %rax, %rsi
movq %r14,(tigermain_framesize-872)(%rsp)
movq %r12,(tigermain_framesize-880)(%rsp)
movq %rbp,(tigermain_framesize-888)(%rsp)
movq %r13,(tigermain_framesize-896)(%rsp)
movq %r14,(tigermain_framesize-904)(%rsp)
movq %r12,(tigermain_framesize-912)(%rsp)
movq %rbp,(tigermain_framesize-920)(%rsp)
movq %r13,(tigermain_framesize-928)(%rsp)
callq getnode
L106:
addq $0, %rsp
movq %rax, %rax
movq %rax, %rax
movq %rbx, %rdi
movq %r14, %rsi
movq %rax, %rdx
movq %r12,(tigermain_framesize-936)(%rsp)
movq %rbp,(tigermain_framesize-944)(%rsp)
movq %r13,(tigermain_framesize-952)(%rsp)
movq %r12,(tigermain_framesize-960)(%rsp)
movq %rbp,(tigermain_framesize-968)(%rsp)
movq %r13,(tigermain_framesize-976)(%rsp)
callq insert
L107:
addq $0, %rsp
movq %rax, %rax
movq %rax, %r14
movq tigermain_framesize(%rsp), %rbx
movq %r12, %r12
leaq tigermain_framesize(%rsp), %rdi
movq $8, %rax
movq %rax, %rax
imulq %r15
movq %rax, %rax
movq %rax, %rsi
movq %r12,(tigermain_framesize-984)(%rsp)
movq %rbp,(tigermain_framesize-992)(%rsp)
movq %r13,(tigermain_framesize-1000)(%rsp)
movq %r14,(tigermain_framesize-1008)(%rsp)
movq %r12,(tigermain_framesize-1016)(%rsp)
movq %rbp,(tigermain_framesize-1024)(%rsp)
movq %r13,(tigermain_framesize-1032)(%rsp)
movq %r14,(tigermain_framesize-1040)(%rsp)
callq getnode
L108:
addq $0, %rsp
movq %rax, %rax
movq %rax, %rax
movq %rbx, %rdi
movq %r12, %rsi
movq %rax, %rdx
movq %rbp,(tigermain_framesize-1048)(%rsp)
movq %r13,(tigermain_framesize-1056)(%rsp)
movq %r14,(tigermain_framesize-1064)(%rsp)
movq %rbp,(tigermain_framesize-1072)(%rsp)
movq %r13,(tigermain_framesize-1080)(%rsp)
movq %r14,(tigermain_framesize-1088)(%rsp)
callq insert
L109:
addq $0, %rsp
movq %rax, %rax
movq %rax, %r12
movq tigermain_framesize(%rsp), %rbx
movq %rbp, %rbp
leaq tigermain_framesize(%rsp), %rdi
movq $2, %r10
movq %r15, %rax
cqto
idivq %r10
movq %rax, %rax
movq %rax, %rsi
movq %rbp,(tigermain_framesize-1096)(%rsp)
movq %r13,(tigermain_framesize-1104)(%rsp)
movq %r14,(tigermain_framesize-1112)(%rsp)
movq %r12,(tigermain_framesize-1120)(%rsp)
movq %rbp,(tigermain_framesize-1128)(%rsp)
movq %r13,(tigermain_framesize-1136)(%rsp)
movq %r14,(tigermain_framesize-1144)(%rsp)
movq %r12,(tigermain_framesize-1152)(%rsp)
callq getnode
L110:
addq $0, %rsp
movq %rax, %rax
movq %rax, %rax
movq %rbx, %rdi
movq %rbp, %rsi
movq %rax, %rdx
movq %r13,(tigermain_framesize-1160)(%rsp)
movq %r14,(tigermain_framesize-1168)(%rsp)
movq %r12,(tigermain_framesize-1176)(%rsp)
movq %r13,(tigermain_framesize-1184)(%rsp)
movq %r14,(tigermain_framesize-1192)(%rsp)
movq %r12,(tigermain_framesize-1200)(%rsp)
callq insert
L111:
addq $0, %rsp
movq %rax, %rax
movq %rax, %rbp
movq tigermain_framesize(%rsp), %rbx
movq %r13, %r13
leaq tigermain_framesize(%rsp), %rdi
movq %r15, %rsi
movq %r13,(tigermain_framesize-1208)(%rsp)
movq %r14,(tigermain_framesize-1216)(%rsp)
movq %r12,(tigermain_framesize-1224)(%rsp)
movq %rbp,(tigermain_framesize-1232)(%rsp)
movq %r13,(tigermain_framesize-1240)(%rsp)
movq %r14,(tigermain_framesize-1248)(%rsp)
movq %r12,(tigermain_framesize-1256)(%rsp)
movq %rbp,(tigermain_framesize-1264)(%rsp)
callq getnode
L112:
addq $0, %rsp
movq %rax, %rax
movq %rax, %rax
movq %rbx, %rdi
movq %r13, %rsi
movq %rax, %rdx
movq %r14,(tigermain_framesize-1272)(%rsp)
movq %r12,(tigermain_framesize-1280)(%rsp)
movq %rbp,(tigermain_framesize-1288)(%rsp)
movq %r14,(tigermain_framesize-1296)(%rsp)
movq %r12,(tigermain_framesize-1304)(%rsp)
movq %rbp,(tigermain_framesize-1312)(%rsp)
callq insert
L113:
addq $0, %rsp
movq %rax, %rax
movq %rax, %r13
movq tigermain_framesize(%rsp), %rbx
movq %r14, %r14
leaq tigermain_framesize(%rsp), %rdi
movq $3, %rax
movq %rax, %rax
imulq %r15
movq %rax, %rax
movq $2, %r10
movq %rax, %rax
cqto
idivq %r10
movq %rax, %rax
movq %rax, %rsi
movq %r14,(tigermain_framesize-1320)(%rsp)
movq %r12,(tigermain_framesize-1328)(%rsp)
movq %rbp,(tigermain_framesize-1336)(%rsp)
movq %r13,(tigermain_framesize-1344)(%rsp)
movq %r14,(tigermain_framesize-1352)(%rsp)
movq %r12,(tigermain_framesize-1360)(%rsp)
movq %rbp,(tigermain_framesize-1368)(%rsp)
movq %r13,(tigermain_framesize-1376)(%rsp)
callq getnode
L114:
addq $0, %rsp
movq %rax, %rax
movq %rax, %rax
movq %rbx, %rdi
movq %r14, %rsi
movq %rax, %rdx
movq %r12,(tigermain_framesize-1384)(%rsp)
movq %rbp,(tigermain_framesize-1392)(%rsp)
movq %r13,(tigermain_framesize-1400)(%rsp)
movq %r12,(tigermain_framesize-1408)(%rsp)
movq %rbp,(tigermain_framesize-1416)(%rsp)
movq %r13,(tigermain_framesize-1424)(%rsp)
callq insert
L115:
addq $0, %rsp
movq %rax, %rax
movq %rax, %r14
movq tigermain_framesize(%rsp), %rbx
movq %r12, %r12
leaq tigermain_framesize(%rsp), %rdi
movq $2, %rax
movq %rax, %rax
imulq %r15
movq %rax, %rax
movq %rax, %rsi
movq %r12,(tigermain_framesize-1432)(%rsp)
movq %rbp,(tigermain_framesize-1440)(%rsp)
movq %r13,(tigermain_framesize-1448)(%rsp)
movq %r14,(tigermain_framesize-1456)(%rsp)
movq %r12,(tigermain_framesize-1464)(%rsp)
movq %rbp,(tigermain_framesize-1472)(%rsp)
movq %r13,(tigermain_framesize-1480)(%rsp)
movq %r14,(tigermain_framesize-1488)(%rsp)
callq getnode
L116:
addq $0, %rsp
movq %rax, %rax
movq %rax, %rax
movq %rbx, %rdi
movq %r12, %rsi
movq %rax, %rdx
movq %rbp,(tigermain_framesize-1496)(%rsp)
movq %r13,(tigermain_framesize-1504)(%rsp)
movq %r14,(tigermain_framesize-1512)(%rsp)
movq %rbp,(tigermain_framesize-1520)(%rsp)
movq %r13,(tigermain_framesize-1528)(%rsp)
movq %r14,(tigermain_framesize-1536)(%rsp)
callq insert
L117:
addq $0, %rsp
movq %rax, %rax
movq %rax, %r12
movq tigermain_framesize(%rsp), %rbx
movq %rbp, %rbp
leaq tigermain_framesize(%rsp), %rdi
movq $3, %rax
movq %rax, %rax
imulq %r15
movq %rax, %rax
movq $2, %r10
movq %rax, %rax
cqto
idivq %r10
movq %rax, %rax
movq %rax, %rsi
movq %rbp,(tigermain_framesize-1544)(%rsp)
movq %r13,(tigermain_framesize-1552)(%rsp)
movq %r14,(tigermain_framesize-1560)(%rsp)
movq %r12,(tigermain_framesize-1568)(%rsp)
movq %rbp,(tigermain_framesize-1576)(%rsp)
movq %r13,(tigermain_framesize-1584)(%rsp)
movq %r14,(tigermain_framesize-1592)(%rsp)
movq %r12,(tigermain_framesize-1600)(%rsp)
callq getnode
L118:
addq $0, %rsp
movq %rax, %rax
movq %rax, %rax
movq %rbx, %rdi
movq %rbp, %rsi
movq %rax, %rdx
movq %r13,(tigermain_framesize-1608)(%rsp)
movq %r14,(tigermain_framesize-1616)(%rsp)
movq %r12,(tigermain_framesize-1624)(%rsp)
movq %r13,(tigermain_framesize-1632)(%rsp)
movq %r14,(tigermain_framesize-1640)(%rsp)
movq %r12,(tigermain_framesize-1648)(%rsp)
callq insert
L119:
addq $0, %rsp
movq %rax, %rax
movq %rax, %rbp
movq tigermain_framesize(%rsp), %rbx
movq %r13, %r13
leaq tigermain_framesize(%rsp), %rdi
movq $3, %rax
movq %rax, %rax
imulq %r15
movq %rax, %rax
movq %rax, %rsi
movq %r13,(tigermain_framesize-1656)(%rsp)
movq %r14,(tigermain_framesize-1664)(%rsp)
movq %r12,(tigermain_framesize-1672)(%rsp)
movq %rbp,(tigermain_framesize-1680)(%rsp)
movq %r13,(tigermain_framesize-1688)(%rsp)
movq %r14,(tigermain_framesize-1696)(%rsp)
movq %r12,(tigermain_framesize-1704)(%rsp)
movq %rbp,(tigermain_framesize-1712)(%rsp)
callq getnode
L120:
addq $0, %rsp
movq %rax, %rax
movq %rax, %rax
movq %rbx, %rdi
movq %r13, %rsi
movq %rax, %rdx
movq %r14,(tigermain_framesize-1720)(%rsp)
movq %r12,(tigermain_framesize-1728)(%rsp)
movq %rbp,(tigermain_framesize-1736)(%rsp)
movq %r14,(tigermain_framesize-1744)(%rsp)
movq %r12,(tigermain_framesize-1752)(%rsp)
movq %rbp,(tigermain_framesize-1760)(%rsp)
callq insert
L121:
addq $0, %rsp
movq %rax, %rax
movq %rax, %r13
movq tigermain_framesize(%rsp), %rbx
movq %r14, %r14
leaq tigermain_framesize(%rsp), %rdi
movq $9, %rax
movq %rax, %rax
imulq %r15
movq %rax, %rax
movq $2, %r10
movq %rax, %rax
cqto
idivq %r10
movq %rax, %rax
movq %rax, %rsi
movq %r14,(tigermain_framesize-1768)(%rsp)
movq %r12,(tigermain_framesize-1776)(%rsp)
movq %rbp,(tigermain_framesize-1784)(%rsp)
movq %r13,(tigermain_framesize-1792)(%rsp)
movq %r14,(tigermain_framesize-1800)(%rsp)
movq %r12,(tigermain_framesize-1808)(%rsp)
movq %rbp,(tigermain_framesize-1816)(%rsp)
movq %r13,(tigermain_framesize-1824)(%rsp)
callq getnode
L122:
addq $0, %rsp
movq %rax, %rax
movq %rax, %rax
movq %rbx, %rdi
movq %r14, %rsi
movq %rax, %rdx
movq %r12,(tigermain_framesize-1832)(%rsp)
movq %rbp,(tigermain_framesize-1840)(%rsp)
movq %r13,(tigermain_framesize-1848)(%rsp)
movq %r12,(tigermain_framesize-1856)(%rsp)
movq %rbp,(tigermain_framesize-1864)(%rsp)
movq %r13,(tigermain_framesize-1872)(%rsp)
callq insert
L123:
addq $0, %rsp
movq %rax, %rax
movq %rax, %r14
movq tigermain_framesize(%rsp), %rbx
movq %r12, %r12
leaq tigermain_framesize(%rsp), %rdi
movq $6, %rax
movq %rax, %rax
imulq %r15
movq %rax, %rax
movq %rax, %rsi
movq %r12,(tigermain_framesize-1880)(%rsp)
movq %rbp,(tigermain_framesize-1888)(%rsp)
movq %r13,(tigermain_framesize-1896)(%rsp)
movq %r14,(tigermain_framesize-1904)(%rsp)
movq %r12,(tigermain_framesize-1912)(%rsp)
movq %rbp,(tigermain_framesize-1920)(%rsp)
movq %r13,(tigermain_framesize-1928)(%rsp)
movq %r14,(tigermain_framesize-1936)(%rsp)
callq getnode
L124:
addq $0, %rsp
movq %rax, %rax
movq %rax, %rax
movq %rbx, %rdi
movq %r12, %rsi
movq %rax, %rdx
movq %rbp,(tigermain_framesize-1944)(%rsp)
movq %r13,(tigermain_framesize-1952)(%rsp)
movq %r14,(tigermain_framesize-1960)(%rsp)
movq %rbp,(tigermain_framesize-1968)(%rsp)
movq %r13,(tigermain_framesize-1976)(%rsp)
movq %r14,(tigermain_framesize-1984)(%rsp)
callq insert
L125:
addq $0, %rsp
movq %rax, %rax
movq %rax, %r12
movq $0, %r10
movq %r10, %rbx
L52:
movq $2, %r11
movq %r15, %r10
subq %r11, %r10
cmpq %r10, %rbx
jle L51
L50:
movq $0, %r10
movq %r10, %rbx
L55:
movq (tigermain_framesize-64)(%rsp), %r10
cmpq %r10, %rbx
jle L54
L53:
leaq tigermain_framesize(%rsp), %rdi
movq %rbp, %rsi
movq %r13,(tigermain_framesize-1992)(%rsp)
movq %r14,(tigermain_framesize-2000)(%rsp)
movq %r12,(tigermain_framesize-2008)(%rsp)
movq %rbp,(tigermain_framesize-2016)(%rsp)
movq %r13,(tigermain_framesize-2024)(%rsp)
movq %r14,(tigermain_framesize-2032)(%rsp)
movq %r12,(tigermain_framesize-2040)(%rsp)
movq %rbp,(tigermain_framesize-2048)(%rsp)
callq printtree
L126:
addq $0, %rsp
movq %rax, %rax
leaq L56(%rip), %rdi
movq %rdi, %rdi
movq %r13,(tigermain_framesize-2056)(%rsp)
movq %r14,(tigermain_framesize-2064)(%rsp)
movq %r12,(tigermain_framesize-2072)(%rsp)
movq %rbp,(tigermain_framesize-2080)(%rsp)
movq %r13,(tigermain_framesize-2088)(%rsp)
movq %r14,(tigermain_framesize-2096)(%rsp)
movq %r12,(tigermain_framesize-2104)(%rsp)
movq %rbp,(tigermain_framesize-2112)(%rsp)
callq print
L127:
addq $0, %rsp
movq %rax, %rax
leaq tigermain_framesize(%rsp), %rdi
movq %r13, %rsi
movq %r14,(tigermain_framesize-2120)(%rsp)
movq %r12,(tigermain_framesize-2128)(%rsp)
movq %rbp,(tigermain_framesize-2136)(%rsp)
movq %r13,(tigermain_framesize-2144)(%rsp)
movq %r14,(tigermain_framesize-2152)(%rsp)
movq %r12,(tigermain_framesize-2160)(%rsp)
movq %rbp,(tigermain_framesize-2168)(%rsp)
movq %r13,(tigermain_framesize-2176)(%rsp)
callq printtree
L128:
addq $0, %rsp
movq %rax, %rax
leaq L57(%rip), %rdi
movq %rdi, %rdi
movq %r14,(tigermain_framesize-2184)(%rsp)
movq %r12,(tigermain_framesize-2192)(%rsp)
movq %rbp,(tigermain_framesize-2200)(%rsp)
movq %r13,(tigermain_framesize-2208)(%rsp)
movq %r14,(tigermain_framesize-2216)(%rsp)
movq %r12,(tigermain_framesize-2224)(%rsp)
movq %rbp,(tigermain_framesize-2232)(%rsp)
movq %r13,(tigermain_framesize-2240)(%rsp)
callq print
L129:
addq $0, %rsp
movq %rax, %rax
leaq tigermain_framesize(%rsp), %rdi
movq %r14, %rsi
movq %r12,(tigermain_framesize-2248)(%rsp)
movq %rbp,(tigermain_framesize-2256)(%rsp)
movq %r13,(tigermain_framesize-2264)(%rsp)
movq %r12,(tigermain_framesize-2272)(%rsp)
movq %rbp,(tigermain_framesize-2280)(%rsp)
movq %r13,(tigermain_framesize-2288)(%rsp)
callq printtree
L130:
addq $0, %rsp
movq %rax, %rax
leaq L58(%rip), %rdi
movq %rdi, %rdi
movq %r12,(tigermain_framesize-2296)(%rsp)
movq %rbp,(tigermain_framesize-2304)(%rsp)
movq %r13,(tigermain_framesize-2312)(%rsp)
movq %r12,(tigermain_framesize-2320)(%rsp)
movq %rbp,(tigermain_framesize-2328)(%rsp)
movq %r13,(tigermain_framesize-2336)(%rsp)
callq print
L131:
addq $0, %rsp
movq %rax, %rax
leaq tigermain_framesize(%rsp), %rdi
movq %r12, %rsi
movq %rbp,(tigermain_framesize-2344)(%rsp)
movq %r13,(tigermain_framesize-2352)(%rsp)
movq %rbp,(tigermain_framesize-2360)(%rsp)
movq %r13,(tigermain_framesize-2368)(%rsp)
callq printtree
L132:
addq $0, %rsp
movq %rax, %rax
leaq L59(%rip), %rdi
movq %rdi, %rdi
movq %rbp,(tigermain_framesize-2376)(%rsp)
movq %r13,(tigermain_framesize-2384)(%rsp)
movq %rbp,(tigermain_framesize-2392)(%rsp)
movq %r13,(tigermain_framesize-2400)(%rsp)
callq print
L133:
addq $0, %rsp
movq %rax, %rax
movq $0, %r10
movq %r10, %r14
L62:
movq $1, %r11
movq %r15, %r10
subq %r11, %r10
cmpq %r10, %r14
jle L61
L60:
movq $0, %r12
movq %r12, %r12
L65:
movq (tigermain_framesize-64)(%rsp), %r10
cmpq %r10, %r12
jle L64
L63:
leaq tigermain_framesize(%rsp), %rdi
movq %rbp, %rsi
movq %r13,(tigermain_framesize-2408)(%rsp)
movq %r13,(tigermain_framesize-2416)(%rsp)
callq printtree
L134:
addq $0, %rsp
movq %rax, %rax
leaq L66(%rip), %rdi
movq %rdi, %rdi
movq %r13,(tigermain_framesize-2424)(%rsp)
movq %r13,(tigermain_framesize-2432)(%rsp)
callq print
L135:
addq $0, %rsp
movq %rax, %rax
leaq tigermain_framesize(%rsp), %rdi
movq %r13, %rsi
callq printtree
L136:
addq $0, %rsp
movq %rax, %rax
leaq L67(%rip), %rdi
movq %rdi, %rdi
callq print
L137:
addq $0, %rsp
movq %rax, %rax
movq %rax, %rax
jmp L91
L51:
movq tigermain_framesize(%rsp), %r10
movq %r10, (tigermain_framesize-72)(%rsp)
movq %rbp, %rbp
leaq tigermain_framesize(%rsp), %rdi
movq %rbx, %rsi
movq %rbp,(tigermain_framesize-2440)(%rsp)
movq %r13,(tigermain_framesize-2448)(%rsp)
movq %r14,(tigermain_framesize-2456)(%rsp)
movq %r12,(tigermain_framesize-2464)(%rsp)
movq %rbp,(tigermain_framesize-2472)(%rsp)
movq %r13,(tigermain_framesize-2480)(%rsp)
movq %r14,(tigermain_framesize-2488)(%rsp)
movq %r12,(tigermain_framesize-2496)(%rsp)
callq getnode
L138:
addq $0, %rsp
movq %rax, %rax
movq %rax, %rax
movq (tigermain_framesize-72)(%rsp), %rdi
movq %rdi, %rdi
movq %rbp, %rsi
movq %rax, %rdx
movq %r13,(tigermain_framesize-2504)(%rsp)
movq %r14,(tigermain_framesize-2512)(%rsp)
movq %r12,(tigermain_framesize-2520)(%rsp)
movq %r13,(tigermain_framesize-2528)(%rsp)
movq %r14,(tigermain_framesize-2536)(%rsp)
movq %r12,(tigermain_framesize-2544)(%rsp)
callq insert
L139:
addq $0, %rsp
movq %rax, %rax
movq %rax, %rbp
movq tigermain_framesize(%rsp), %r10
movq %r10, (tigermain_framesize-80)(%rsp)
movq %r13, %r13
leaq tigermain_framesize(%rsp), %rdi
movq $2, %rax
movq %rax, %rax
imulq %rbx
movq %rax, %rax
movq %rax, %rsi
movq %r13,(tigermain_framesize-2552)(%rsp)
movq %r14,(tigermain_framesize-2560)(%rsp)
movq %r12,(tigermain_framesize-2568)(%rsp)
movq %rbp,(tigermain_framesize-2576)(%rsp)
movq %r13,(tigermain_framesize-2584)(%rsp)
movq %r14,(tigermain_framesize-2592)(%rsp)
movq %r12,(tigermain_framesize-2600)(%rsp)
movq %rbp,(tigermain_framesize-2608)(%rsp)
callq getnode
L140:
addq $0, %rsp
movq %rax, %rax
movq %rax, %rax
movq (tigermain_framesize-80)(%rsp), %rdi
movq %rdi, %rdi
movq %r13, %rsi
movq %rax, %rdx
movq %r14,(tigermain_framesize-2616)(%rsp)
movq %r12,(tigermain_framesize-2624)(%rsp)
movq %rbp,(tigermain_framesize-2632)(%rsp)
movq %r14,(tigermain_framesize-2640)(%rsp)
movq %r12,(tigermain_framesize-2648)(%rsp)
movq %rbp,(tigermain_framesize-2656)(%rsp)
callq insert
L141:
addq $0, %rsp
movq %rax, %rax
movq %rax, %r13
movq tigermain_framesize(%rsp), %r10
movq %r10, (tigermain_framesize-88)(%rsp)
movq %r14, %r14
leaq tigermain_framesize(%rsp), %rdi
movq $3, %rax
movq %rax, %rax
imulq %rbx
movq %rax, %rax
movq %rax, %rsi
movq %r14,(tigermain_framesize-2664)(%rsp)
movq %r12,(tigermain_framesize-2672)(%rsp)
movq %rbp,(tigermain_framesize-2680)(%rsp)
movq %r13,(tigermain_framesize-2688)(%rsp)
movq %r14,(tigermain_framesize-2696)(%rsp)
movq %r12,(tigermain_framesize-2704)(%rsp)
movq %rbp,(tigermain_framesize-2712)(%rsp)
movq %r13,(tigermain_framesize-2720)(%rsp)
callq getnode
L142:
addq $0, %rsp
movq %rax, %rax
movq %rax, %rax
movq (tigermain_framesize-88)(%rsp), %rdi
movq %rdi, %rdi
movq %r14, %rsi
movq %rax, %rdx
movq %r12,(tigermain_framesize-2728)(%rsp)
movq %rbp,(tigermain_framesize-2736)(%rsp)
movq %r13,(tigermain_framesize-2744)(%rsp)
movq %r12,(tigermain_framesize-2752)(%rsp)
movq %rbp,(tigermain_framesize-2760)(%rsp)
movq %r13,(tigermain_framesize-2768)(%rsp)
callq insert
L143:
addq $0, %rsp
movq %rax, %rax
movq %rax, %r14
movq tigermain_framesize(%rsp), %r10
movq %r10, (tigermain_framesize-96)(%rsp)
movq %r12, %r12
leaq tigermain_framesize(%rsp), %rdi
movq $4, %rax
movq %rax, %rax
imulq %rbx
movq %rax, %rax
movq %rax, %rsi
movq %r12,(tigermain_framesize-2776)(%rsp)
movq %rbp,(tigermain_framesize-2784)(%rsp)
movq %r13,(tigermain_framesize-2792)(%rsp)
movq %r14,(tigermain_framesize-2800)(%rsp)
movq %r12,(tigermain_framesize-2808)(%rsp)
movq %rbp,(tigermain_framesize-2816)(%rsp)
movq %r13,(tigermain_framesize-2824)(%rsp)
movq %r14,(tigermain_framesize-2832)(%rsp)
callq getnode
L144:
addq $0, %rsp
movq %rax, %rax
movq %rax, %rax
movq (tigermain_framesize-96)(%rsp), %rdi
movq %rdi, %rdi
movq %r12, %rsi
movq %rax, %rdx
movq %rbp,(tigermain_framesize-2840)(%rsp)
movq %r13,(tigermain_framesize-2848)(%rsp)
movq %r14,(tigermain_framesize-2856)(%rsp)
movq %rbp,(tigermain_framesize-2864)(%rsp)
movq %r13,(tigermain_framesize-2872)(%rsp)
movq %r14,(tigermain_framesize-2880)(%rsp)
callq insert
L145:
addq $0, %rsp
movq %rax, %rax
movq %rax, %r12
movq tigermain_framesize(%rsp), %r10
movq %r10, (tigermain_framesize-104)(%rsp)
movq %rbp, %rbp
leaq tigermain_framesize(%rsp), %rdi
movq %r15, %rsi
addq %rbx, %rsi
movq %rsi, %rsi
movq %rbp,(tigermain_framesize-2888)(%rsp)
movq %r13,(tigermain_framesize-2896)(%rsp)
movq %r14,(tigermain_framesize-2904)(%rsp)
movq %r12,(tigermain_framesize-2912)(%rsp)
movq %rbp,(tigermain_framesize-2920)(%rsp)
movq %r13,(tigermain_framesize-2928)(%rsp)
movq %r14,(tigermain_framesize-2936)(%rsp)
movq %r12,(tigermain_framesize-2944)(%rsp)
callq getnode
L146:
addq $0, %rsp
movq %rax, %rax
movq %rax, %rax
movq (tigermain_framesize-104)(%rsp), %rdi
movq %rdi, %rdi
movq %rbp, %rsi
movq %rax, %rdx
movq %r13,(tigermain_framesize-2952)(%rsp)
movq %r14,(tigermain_framesize-2960)(%rsp)
movq %r12,(tigermain_framesize-2968)(%rsp)
movq %r13,(tigermain_framesize-2976)(%rsp)
movq %r14,(tigermain_framesize-2984)(%rsp)
movq %r12,(tigermain_framesize-2992)(%rsp)
callq insert
L147:
addq $0, %rsp
movq %rax, %rax
movq %rax, %rbp
movq tigermain_framesize(%rsp), %r10
movq %r10, (tigermain_framesize-112)(%rsp)
movq %r13, %r13
leaq tigermain_framesize(%rsp), %rdi
movq $2, %rax
movq %r15, %r10
addq %rbx, %r10
movq %rax, %rax
imulq %r10
movq %rax, %rax
movq %rax, %rsi
movq %r13,(tigermain_framesize-3000)(%rsp)
movq %r14,(tigermain_framesize-3008)(%rsp)
movq %r12,(tigermain_framesize-3016)(%rsp)
movq %rbp,(tigermain_framesize-3024)(%rsp)
movq %r13,(tigermain_framesize-3032)(%rsp)
movq %r14,(tigermain_framesize-3040)(%rsp)
movq %r12,(tigermain_framesize-3048)(%rsp)
movq %rbp,(tigermain_framesize-3056)(%rsp)
callq getnode
L148:
addq $0, %rsp
movq %rax, %rax
movq %rax, %rax
movq (tigermain_framesize-112)(%rsp), %rdi
movq %rdi, %rdi
movq %r13, %rsi
movq %rax, %rdx
movq %r14,(tigermain_framesize-3064)(%rsp)
movq %r12,(tigermain_framesize-3072)(%rsp)
movq %rbp,(tigermain_framesize-3080)(%rsp)
movq %r14,(tigermain_framesize-3088)(%rsp)
movq %r12,(tigermain_framesize-3096)(%rsp)
movq %rbp,(tigermain_framesize-3104)(%rsp)
callq insert
L149:
addq $0, %rsp
movq %rax, %rax
movq %rax, %r13
movq tigermain_framesize(%rsp), %r10
movq %r10, (tigermain_framesize-120)(%rsp)
movq %r14, %r14
leaq tigermain_framesize(%rsp), %rdi
movq $3, %rax
movq %r15, %r10
addq %rbx, %r10
movq %rax, %rax
imulq %r10
movq %rax, %rax
movq %rax, %rsi
movq %r14,(tigermain_framesize-3112)(%rsp)
movq %r12,(tigermain_framesize-3120)(%rsp)
movq %rbp,(tigermain_framesize-3128)(%rsp)
movq %r13,(tigermain_framesize-3136)(%rsp)
movq %r14,(tigermain_framesize-3144)(%rsp)
movq %r12,(tigermain_framesize-3152)(%rsp)
movq %rbp,(tigermain_framesize-3160)(%rsp)
movq %r13,(tigermain_framesize-3168)(%rsp)
callq getnode
L150:
addq $0, %rsp
movq %rax, %rax
movq %rax, %rax
movq (tigermain_framesize-120)(%rsp), %rdi
movq %rdi, %rdi
movq %r14, %rsi
movq %rax, %rdx
movq %r12,(tigermain_framesize-3176)(%rsp)
movq %rbp,(tigermain_framesize-3184)(%rsp)
movq %r13,(tigermain_framesize-3192)(%rsp)
movq %r12,(tigermain_framesize-3200)(%rsp)
movq %rbp,(tigermain_framesize-3208)(%rsp)
movq %r13,(tigermain_framesize-3216)(%rsp)
callq insert
L151:
addq $0, %rsp
movq %rax, %rax
movq %rax, %r14
movq tigermain_framesize(%rsp), %r10
movq %r10, (tigermain_framesize-128)(%rsp)
movq %r12, %r12
leaq tigermain_framesize(%rsp), %rdi
movq $4, %rax
movq %r15, %r10
addq %rbx, %r10
movq %rax, %rax
imulq %r10
movq %rax, %rax
movq %rax, %rsi
movq %r12,(tigermain_framesize-3224)(%rsp)
movq %rbp,(tigermain_framesize-3232)(%rsp)
movq %r13,(tigermain_framesize-3240)(%rsp)
movq %r14,(tigermain_framesize-3248)(%rsp)
movq %r12,(tigermain_framesize-3256)(%rsp)
movq %rbp,(tigermain_framesize-3264)(%rsp)
movq %r13,(tigermain_framesize-3272)(%rsp)
movq %r14,(tigermain_framesize-3280)(%rsp)
callq getnode
L152:
addq $0, %rsp
movq %rax, %rax
movq %rax, %rax
movq (tigermain_framesize-128)(%rsp), %rdi
movq %rdi, %rdi
movq %r12, %rsi
movq %rax, %rdx
movq %rbp,(tigermain_framesize-3288)(%rsp)
movq %r13,(tigermain_framesize-3296)(%rsp)
movq %r14,(tigermain_framesize-3304)(%rsp)
movq %rbp,(tigermain_framesize-3312)(%rsp)
movq %r13,(tigermain_framesize-3320)(%rsp)
movq %r14,(tigermain_framesize-3328)(%rsp)
callq insert
L153:
addq $0, %rsp
movq %rax, %rax
movq %rax, %r12
movq tigermain_framesize(%rsp), %r10
movq %r10, (tigermain_framesize-136)(%rsp)
movq %rbp, %rbp
leaq tigermain_framesize(%rsp), %rdi
movq %rbx, %rsi
movq %rbp,(tigermain_framesize-3336)(%rsp)
movq %r13,(tigermain_framesize-3344)(%rsp)
movq %r14,(tigermain_framesize-3352)(%rsp)
movq %r12,(tigermain_framesize-3360)(%rsp)
movq %rbp,(tigermain_framesize-3368)(%rsp)
movq %r13,(tigermain_framesize-3376)(%rsp)
movq %r14,(tigermain_framesize-3384)(%rsp)
movq %r12,(tigermain_framesize-3392)(%rsp)
callq getnode
L154:
addq $0, %rsp
movq %rax, %rax
movq %rax, %rax
movq (tigermain_framesize-136)(%rsp), %rdi
movq %rdi, %rdi
movq %rbp, %rsi
movq %rax, %rdx
movq %r13,(tigermain_framesize-3400)(%rsp)
movq %r14,(tigermain_framesize-3408)(%rsp)
movq %r12,(tigermain_framesize-3416)(%rsp)
movq %r13,(tigermain_framesize-3424)(%rsp)
movq %r14,(tigermain_framesize-3432)(%rsp)
movq %r12,(tigermain_framesize-3440)(%rsp)
callq insert
L155:
addq $0, %rsp
movq %rax, %rax
movq %rax, %rbp
movq tigermain_framesize(%rsp), %r10
movq %r10, (tigermain_framesize-144)(%rsp)
movq %r13, %r13
leaq tigermain_framesize(%rsp), %rdi
movq $2, %rax
movq %rax, %rax
imulq %rbx
movq %rax, %rax
movq %rax, %rsi
movq %r13,(tigermain_framesize-3448)(%rsp)
movq %r14,(tigermain_framesize-3456)(%rsp)
movq %r12,(tigermain_framesize-3464)(%rsp)
movq %rbp,(tigermain_framesize-3472)(%rsp)
movq %r13,(tigermain_framesize-3480)(%rsp)
movq %r14,(tigermain_framesize-3488)(%rsp)
movq %r12,(tigermain_framesize-3496)(%rsp)
movq %rbp,(tigermain_framesize-3504)(%rsp)
callq getnode
L156:
addq $0, %rsp
movq %rax, %rax
movq %rax, %rax
movq (tigermain_framesize-144)(%rsp), %rdi
movq %rdi, %rdi
movq %r13, %rsi
movq %rax, %rdx
movq %r14,(tigermain_framesize-3512)(%rsp)
movq %r12,(tigermain_framesize-3520)(%rsp)
movq %rbp,(tigermain_framesize-3528)(%rsp)
movq %r14,(tigermain_framesize-3536)(%rsp)
movq %r12,(tigermain_framesize-3544)(%rsp)
movq %rbp,(tigermain_framesize-3552)(%rsp)
callq insert
L157:
addq $0, %rsp
movq %rax, %rax
movq %rax, %r13
movq tigermain_framesize(%rsp), %r10
movq %r10, (tigermain_framesize-152)(%rsp)
movq %r14, %r14
leaq tigermain_framesize(%rsp), %rdi
movq $3, %rax
movq %rax, %rax
imulq %rbx
movq %rax, %rax
movq %rax, %rsi
movq %r14,(tigermain_framesize-3560)(%rsp)
movq %r12,(tigermain_framesize-3568)(%rsp)
movq %rbp,(tigermain_framesize-3576)(%rsp)
movq %r13,(tigermain_framesize-3584)(%rsp)
movq %r14,(tigermain_framesize-3592)(%rsp)
movq %r12,(tigermain_framesize-3600)(%rsp)
movq %rbp,(tigermain_framesize-3608)(%rsp)
movq %r13,(tigermain_framesize-3616)(%rsp)
callq getnode
L158:
addq $0, %rsp
movq %rax, %rax
movq %rax, %rax
movq (tigermain_framesize-152)(%rsp), %rdi
movq %rdi, %rdi
movq %r14, %rsi
movq %rax, %rdx
movq %r12,(tigermain_framesize-3624)(%rsp)
movq %rbp,(tigermain_framesize-3632)(%rsp)
movq %r13,(tigermain_framesize-3640)(%rsp)
movq %r12,(tigermain_framesize-3648)(%rsp)
movq %rbp,(tigermain_framesize-3656)(%rsp)
movq %r13,(tigermain_framesize-3664)(%rsp)
callq insert
L159:
addq $0, %rsp
movq %rax, %rax
movq %rax, %r14
movq tigermain_framesize(%rsp), %r10
movq %r10, (tigermain_framesize-160)(%rsp)
movq %r12, %r12
leaq tigermain_framesize(%rsp), %rdi
movq $4, %rax
movq %rax, %rax
imulq %rbx
movq %rax, %rax
movq %rax, %rsi
movq %r12,(tigermain_framesize-3672)(%rsp)
movq %rbp,(tigermain_framesize-3680)(%rsp)
movq %r13,(tigermain_framesize-3688)(%rsp)
movq %r14,(tigermain_framesize-3696)(%rsp)
movq %r12,(tigermain_framesize-3704)(%rsp)
movq %rbp,(tigermain_framesize-3712)(%rsp)
movq %r13,(tigermain_framesize-3720)(%rsp)
movq %r14,(tigermain_framesize-3728)(%rsp)
callq getnode
L160:
addq $0, %rsp
movq %rax, %rax
movq %rax, %rax
movq (tigermain_framesize-160)(%rsp), %rdi
movq %rdi, %rdi
movq %r12, %rsi
movq %rax, %rdx
movq %rbp,(tigermain_framesize-3736)(%rsp)
movq %r13,(tigermain_framesize-3744)(%rsp)
movq %r14,(tigermain_framesize-3752)(%rsp)
movq %rbp,(tigermain_framesize-3760)(%rsp)
movq %r13,(tigermain_framesize-3768)(%rsp)
movq %r14,(tigermain_framesize-3776)(%rsp)
callq insert
L161:
addq $0, %rsp
movq %rax, %rax
movq %rax, %r12
movq tigermain_framesize(%rsp), %r10
movq %r10, (tigermain_framesize-168)(%rsp)
movq %rbp, %rbp
leaq tigermain_framesize(%rsp), %rdi
movq %r15, %rsi
addq %rbx, %rsi
movq %rsi, %rsi
movq %rbp,(tigermain_framesize-3784)(%rsp)
movq %r13,(tigermain_framesize-3792)(%rsp)
movq %r14,(tigermain_framesize-3800)(%rsp)
movq %r12,(tigermain_framesize-3808)(%rsp)
movq %rbp,(tigermain_framesize-3816)(%rsp)
movq %r13,(tigermain_framesize-3824)(%rsp)
movq %r14,(tigermain_framesize-3832)(%rsp)
movq %r12,(tigermain_framesize-3840)(%rsp)
callq getnode
L162:
addq $0, %rsp
movq %rax, %rax
movq %rax, %rax
movq (tigermain_framesize-168)(%rsp), %rdi
movq %rdi, %rdi
movq %rbp, %rsi
movq %rax, %rdx
movq %r13,(tigermain_framesize-3848)(%rsp)
movq %r14,(tigermain_framesize-3856)(%rsp)
movq %r12,(tigermain_framesize-3864)(%rsp)
movq %r13,(tigermain_framesize-3872)(%rsp)
movq %r14,(tigermain_framesize-3880)(%rsp)
movq %r12,(tigermain_framesize-3888)(%rsp)
callq insert
L163:
addq $0, %rsp
movq %rax, %rax
movq %rax, %rbp
movq tigermain_framesize(%rsp), %r10
movq %r10, (tigermain_framesize-176)(%rsp)
movq %r13, %r13
leaq tigermain_framesize(%rsp), %rdi
movq $2, %rax
movq %r15, %r10
addq %rbx, %r10
movq %rax, %rax
imulq %r10
movq %rax, %rax
movq %rax, %rsi
movq %r13,(tigermain_framesize-3896)(%rsp)
movq %r14,(tigermain_framesize-3904)(%rsp)
movq %r12,(tigermain_framesize-3912)(%rsp)
movq %rbp,(tigermain_framesize-3920)(%rsp)
movq %r13,(tigermain_framesize-3928)(%rsp)
movq %r14,(tigermain_framesize-3936)(%rsp)
movq %r12,(tigermain_framesize-3944)(%rsp)
movq %rbp,(tigermain_framesize-3952)(%rsp)
callq getnode
L164:
addq $0, %rsp
movq %rax, %rax
movq %rax, %rax
movq (tigermain_framesize-176)(%rsp), %rdi
movq %rdi, %rdi
movq %r13, %rsi
movq %rax, %rdx
movq %r14,(tigermain_framesize-3960)(%rsp)
movq %r12,(tigermain_framesize-3968)(%rsp)
movq %rbp,(tigermain_framesize-3976)(%rsp)
movq %r14,(tigermain_framesize-3984)(%rsp)
movq %r12,(tigermain_framesize-3992)(%rsp)
movq %rbp,(tigermain_framesize-4000)(%rsp)
callq insert
L165:
addq $0, %rsp
movq %rax, %rax
movq %rax, %r13
movq tigermain_framesize(%rsp), %r10
movq %r10, (tigermain_framesize-184)(%rsp)
movq %r14, %r14
leaq tigermain_framesize(%rsp), %rdi
movq $3, %rax
movq %r15, %r10
addq %rbx, %r10
movq %rax, %rax
imulq %r10
movq %rax, %rax
movq %rax, %rsi
movq %r14,(tigermain_framesize-4008)(%rsp)
movq %r12,(tigermain_framesize-4016)(%rsp)
movq %rbp,(tigermain_framesize-4024)(%rsp)
movq %r13,(tigermain_framesize-4032)(%rsp)
movq %r14,(tigermain_framesize-4040)(%rsp)
movq %r12,(tigermain_framesize-4048)(%rsp)
movq %rbp,(tigermain_framesize-4056)(%rsp)
movq %r13,(tigermain_framesize-4064)(%rsp)
callq getnode
L166:
addq $0, %rsp
movq %rax, %rax
movq %rax, %rax
movq (tigermain_framesize-184)(%rsp), %rdi
movq %rdi, %rdi
movq %r14, %rsi
movq %rax, %rdx
movq %r12,(tigermain_framesize-4072)(%rsp)
movq %rbp,(tigermain_framesize-4080)(%rsp)
movq %r13,(tigermain_framesize-4088)(%rsp)
movq %r12,(tigermain_framesize-4096)(%rsp)
movq %rbp,(tigermain_framesize-4104)(%rsp)
movq %r13,(tigermain_framesize-4112)(%rsp)
callq insert
L167:
addq $0, %rsp
movq %rax, %rax
movq %rax, %r14
movq tigermain_framesize(%rsp), %r10
movq %r10, (tigermain_framesize-192)(%rsp)
movq %r12, %r12
leaq tigermain_framesize(%rsp), %rdi
movq $4, %rax
movq %r15, %r10
addq %rbx, %r10
movq %rax, %rax
imulq %r10
movq %rax, %rax
movq %rax, %rsi
movq %r12,(tigermain_framesize-4120)(%rsp)
movq %rbp,(tigermain_framesize-4128)(%rsp)
movq %r13,(tigermain_framesize-4136)(%rsp)
movq %r14,(tigermain_framesize-4144)(%rsp)
movq %r12,(tigermain_framesize-4152)(%rsp)
movq %rbp,(tigermain_framesize-4160)(%rsp)
movq %r13,(tigermain_framesize-4168)(%rsp)
movq %r14,(tigermain_framesize-4176)(%rsp)
callq getnode
L168:
addq $0, %rsp
movq %rax, %rax
movq %rax, %rax
movq (tigermain_framesize-192)(%rsp), %rdi
movq %rdi, %rdi
movq %r12, %rsi
movq %rax, %rdx
movq %rbp,(tigermain_framesize-4184)(%rsp)
movq %r13,(tigermain_framesize-4192)(%rsp)
movq %r14,(tigermain_framesize-4200)(%rsp)
movq %rbp,(tigermain_framesize-4208)(%rsp)
movq %r13,(tigermain_framesize-4216)(%rsp)
movq %r14,(tigermain_framesize-4224)(%rsp)
callq insert
L169:
addq $0, %rsp
movq %rax, %rax
movq %rax, %r12
movq $1, %r11
movq %rbx, %r10
addq %r11, %r10
movq %r10, %rbx
jmp L52
L54:
leaq tigermain_framesize(%rsp), %rdi
movq %rbx, %rsi
movq %rbp,(tigermain_framesize-4232)(%rsp)
movq %r13,(tigermain_framesize-4240)(%rsp)
movq %r14,(tigermain_framesize-4248)(%rsp)
movq %r12,(tigermain_framesize-4256)(%rsp)
movq %rbp,(tigermain_framesize-4264)(%rsp)
movq %r13,(tigermain_framesize-4272)(%rsp)
movq %r14,(tigermain_framesize-4280)(%rsp)
movq %r12,(tigermain_framesize-4288)(%rsp)
callq getnode
L170:
addq $0, %rsp
movq %rax, %rax
movq %rax, %rax
movq $1, %r11
movq %rbx, %r10
addq %r11, %r10
movq %r10, %rbx
jmp L55
L61:
movq tigermain_framesize(%rsp), %rbx
movq %rbp, %r12
leaq tigermain_framesize(%rsp), %rdi
movq %r14, %rsi
movq %r12,(tigermain_framesize-4296)(%rsp)
movq %r13,(tigermain_framesize-4304)(%rsp)
movq %r12,(tigermain_framesize-4312)(%rsp)
movq %r13,(tigermain_framesize-4320)(%rsp)
callq getnode
L171:
addq $0, %rsp
movq %rax, %rax
movq %rax, %rax
movq %rbx, %rdi
movq %r12, %rsi
movq %rax, %rdx
movq %r13,(tigermain_framesize-4328)(%rsp)
movq %r13,(tigermain_framesize-4336)(%rsp)
callq insert
L172:
addq $0, %rsp
movq %rax, %rax
movq %rax, %rbp
movq tigermain_framesize(%rsp), %rbx
movq %r13, %r12
leaq tigermain_framesize(%rsp), %rdi
movq $2, %rax
movq %rax, %rax
imulq %r14
movq %rax, %rax
movq %rax, %rsi
movq %r12,(tigermain_framesize-4344)(%rsp)
movq %rbp,(tigermain_framesize-4352)(%rsp)
movq %r12,(tigermain_framesize-4360)(%rsp)
movq %rbp,(tigermain_framesize-4368)(%rsp)
callq getnode
L173:
addq $0, %rsp
movq %rax, %rax
movq %rax, %rax
movq %rbx, %rdi
movq %r12, %rsi
movq %rax, %rdx
movq %rbp,(tigermain_framesize-4376)(%rsp)
movq %rbp,(tigermain_framesize-4384)(%rsp)
callq insert
L174:
addq $0, %rsp
movq %rax, %rax
movq %rax, %r13
movq tigermain_framesize(%rsp), %rbx
movq %rbp, %r12
leaq tigermain_framesize(%rsp), %rdi
movq %r15, %rsi
addq %r14, %rsi
movq %rsi, %rsi
movq %r12,(tigermain_framesize-4392)(%rsp)
movq %r13,(tigermain_framesize-4400)(%rsp)
movq %r12,(tigermain_framesize-4408)(%rsp)
movq %r13,(tigermain_framesize-4416)(%rsp)
callq getnode
L175:
addq $0, %rsp
movq %rax, %rax
movq %rax, %rax
movq %rbx, %rdi
movq %r12, %rsi
movq %rax, %rdx
movq %r13,(tigermain_framesize-4424)(%rsp)
movq %r13,(tigermain_framesize-4432)(%rsp)
callq insert
L176:
addq $0, %rsp
movq %rax, %rax
movq %rax, %rbp
movq tigermain_framesize(%rsp), %rbx
movq %r13, %r12
leaq tigermain_framesize(%rsp), %rdi
movq $2, %rax
movq %r15, %r10
addq %r14, %r10
movq %rax, %rax
imulq %r10
movq %rax, %rax
movq %rax, %rsi
movq %r12,(tigermain_framesize-4440)(%rsp)
movq %rbp,(tigermain_framesize-4448)(%rsp)
movq %r12,(tigermain_framesize-4456)(%rsp)
movq %rbp,(tigermain_framesize-4464)(%rsp)
callq getnode
L177:
addq $0, %rsp
movq %rax, %rax
movq %rax, %rax
movq %rbx, %rdi
movq %r12, %rsi
movq %rax, %rdx
movq %rbp,(tigermain_framesize-4472)(%rsp)
movq %rbp,(tigermain_framesize-4480)(%rsp)
callq insert
L178:
addq $0, %rsp
movq %rax, %rax
movq %rax, %r13
movq tigermain_framesize(%rsp), %rbx
movq %rbp, %r12
leaq tigermain_framesize(%rsp), %rdi
movq %r14, %rsi
movq %r12,(tigermain_framesize-4488)(%rsp)
movq %r13,(tigermain_framesize-4496)(%rsp)
movq %r12,(tigermain_framesize-4504)(%rsp)
movq %r13,(tigermain_framesize-4512)(%rsp)
callq getnode
L179:
addq $0, %rsp
movq %rax, %rax
movq %rax, %rax
movq %rbx, %rdi
movq %r12, %rsi
movq %rax, %rdx
movq %r13,(tigermain_framesize-4520)(%rsp)
movq %r13,(tigermain_framesize-4528)(%rsp)
callq insert
L180:
addq $0, %rsp
movq %rax, %rax
movq %rax, %rbp
movq tigermain_framesize(%rsp), %rbx
movq %r13, %r12
leaq tigermain_framesize(%rsp), %rdi
movq $2, %rax
movq %rax, %rax
imulq %r14
movq %rax, %rax
movq %rax, %rsi
movq %r12,(tigermain_framesize-4536)(%rsp)
movq %rbp,(tigermain_framesize-4544)(%rsp)
movq %r12,(tigermain_framesize-4552)(%rsp)
movq %rbp,(tigermain_framesize-4560)(%rsp)
callq getnode
L181:
addq $0, %rsp
movq %rax, %rax
movq %rax, %rax
movq %rbx, %rdi
movq %r12, %rsi
movq %rax, %rdx
movq %rbp,(tigermain_framesize-4568)(%rsp)
movq %rbp,(tigermain_framesize-4576)(%rsp)
callq insert
L182:
addq $0, %rsp
movq %rax, %rax
movq %rax, %r13
movq tigermain_framesize(%rsp), %rbx
movq %rbp, %r12
leaq tigermain_framesize(%rsp), %rdi
movq %r15, %rsi
addq %r14, %rsi
movq %rsi, %rsi
movq %r12,(tigermain_framesize-4584)(%rsp)
movq %r13,(tigermain_framesize-4592)(%rsp)
movq %r12,(tigermain_framesize-4600)(%rsp)
movq %r13,(tigermain_framesize-4608)(%rsp)
callq getnode
L183:
addq $0, %rsp
movq %rax, %rax
movq %rax, %rax
movq %rbx, %rdi
movq %r12, %rsi
movq %rax, %rdx
movq %r13,(tigermain_framesize-4616)(%rsp)
movq %r13,(tigermain_framesize-4624)(%rsp)
callq insert
L184:
addq $0, %rsp
movq %rax, %rax
movq %rax, %rbp
movq tigermain_framesize(%rsp), %rbx
movq %r13, %r12
leaq tigermain_framesize(%rsp), %rdi
movq $2, %rax
movq %r15, %r10
addq %r14, %r10
movq %rax, %rax
imulq %r10
movq %rax, %rax
movq %rax, %rsi
movq %r12,(tigermain_framesize-4632)(%rsp)
movq %rbp,(tigermain_framesize-4640)(%rsp)
movq %r12,(tigermain_framesize-4648)(%rsp)
movq %rbp,(tigermain_framesize-4656)(%rsp)
callq getnode
L185:
addq $0, %rsp
movq %rax, %rax
movq %rax, %rax
movq %rbx, %rdi
movq %r12, %rsi
movq %rax, %rdx
movq %rbp,(tigermain_framesize-4664)(%rsp)
movq %rbp,(tigermain_framesize-4672)(%rsp)
callq insert
L186:
addq $0, %rsp
movq %rax, %rax
movq %rax, %r13
movq $1, %r10
movq %r14, %r14
addq %r10, %r14
movq %r14, %r14
jmp L62
L64:
leaq tigermain_framesize(%rsp), %rdi
movq %r12, %rsi
movq %rbp,(tigermain_framesize-4680)(%rsp)
movq %r13,(tigermain_framesize-4688)(%rsp)
movq %rbp,(tigermain_framesize-4696)(%rsp)
movq %r13,(tigermain_framesize-4704)(%rsp)
callq getnode
L187:
addq $0, %rsp
movq %rax, %rax
movq %rax, %rax
movq $1, %r10
movq %r12, %r12
addq %r10, %r12
movq %r12, %r12
jmp L65
L91:
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


addq $4704, %rsp
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
L56:
.long 1
.string "\n"
L57:
.long 1
.string "\n"
L58:
.long 1
.string "\n"
L59:
.long 1
.string "\n"
L66:
.long 1
.string "\n"
L67:
.long 1
.string "\n"
.globl GLOBAL_GC_ROOTS
GLOBAL_GC_ROOTS:
GC1:
.quad GC2
.quad L72
.quad f_framesize
.quad -1
GC2:
.quad GC3
.quad L73
.quad f_framesize
.quad -1
GC3:
.quad GC4
.quad L74
.quad f_framesize
.quad -1
GC4:
.quad GC5
.quad L75
.quad f_framesize
.quad -1
GC5:
.quad GC6
.quad L78
.quad printint_framesize
.quad -1
GC6:
.quad GC7
.quad L79
.quad printint_framesize
.quad -1
GC7:
.quad GC8
.quad L80
.quad printint_framesize
.quad -1
GC8:
.quad GC9
.quad L81
.quad printint_framesize
.quad -1
GC9:
.quad GC10
.quad L82
.quad printint_framesize
.quad -1
GC10:
.quad GC11
.quad L85
.quad printtree_framesize
.quad -1
GC11:
.quad GC12
.quad L86
.quad printtree_framesize
.quad -1
GC12:
.quad GC13
.quad L87
.quad printtree_framesize
.quad -1
GC13:
.quad GC14
.quad L90
.quad getnode_framesize
.quad -1
GC14:
.quad GC15
.quad L93
.quad tigermain_framesize
.quad -1
GC15:
.quad GC16
.quad L94
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-200
.quad tigermain_framesize-208
.quad tigermain_framesize-216
.quad tigermain_framesize-224
.quad tigermain_framesize-232
.quad tigermain_framesize-240
.quad tigermain_framesize-248
.quad tigermain_framesize-256
.quad -1
GC16:
.quad GC17
.quad L95
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-264
.quad tigermain_framesize-272
.quad tigermain_framesize-280
.quad tigermain_framesize-288
.quad tigermain_framesize-296
.quad tigermain_framesize-304
.quad -1
GC17:
.quad GC18
.quad L96
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-312
.quad tigermain_framesize-320
.quad tigermain_framesize-328
.quad tigermain_framesize-336
.quad tigermain_framesize-344
.quad tigermain_framesize-352
.quad tigermain_framesize-360
.quad tigermain_framesize-368
.quad -1
GC18:
.quad GC19
.quad L97
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-376
.quad tigermain_framesize-384
.quad tigermain_framesize-392
.quad tigermain_framesize-400
.quad tigermain_framesize-408
.quad tigermain_framesize-416
.quad -1
GC19:
.quad GC20
.quad L98
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-424
.quad tigermain_framesize-432
.quad tigermain_framesize-440
.quad tigermain_framesize-448
.quad tigermain_framesize-456
.quad tigermain_framesize-464
.quad tigermain_framesize-472
.quad tigermain_framesize-480
.quad -1
GC20:
.quad GC21
.quad L99
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-488
.quad tigermain_framesize-496
.quad tigermain_framesize-504
.quad tigermain_framesize-512
.quad tigermain_framesize-520
.quad tigermain_framesize-528
.quad -1
GC21:
.quad GC22
.quad L100
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-536
.quad tigermain_framesize-544
.quad tigermain_framesize-552
.quad tigermain_framesize-560
.quad tigermain_framesize-568
.quad tigermain_framesize-576
.quad tigermain_framesize-584
.quad tigermain_framesize-592
.quad -1
GC22:
.quad GC23
.quad L101
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-600
.quad tigermain_framesize-608
.quad tigermain_framesize-616
.quad tigermain_framesize-624
.quad tigermain_framesize-632
.quad tigermain_framesize-640
.quad -1
GC23:
.quad GC24
.quad L102
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-648
.quad tigermain_framesize-656
.quad tigermain_framesize-664
.quad tigermain_framesize-672
.quad tigermain_framesize-680
.quad tigermain_framesize-688
.quad tigermain_framesize-696
.quad tigermain_framesize-704
.quad -1
GC24:
.quad GC25
.quad L103
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-712
.quad tigermain_framesize-720
.quad tigermain_framesize-728
.quad tigermain_framesize-736
.quad tigermain_framesize-744
.quad tigermain_framesize-752
.quad -1
GC25:
.quad GC26
.quad L104
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-760
.quad tigermain_framesize-768
.quad tigermain_framesize-776
.quad tigermain_framesize-784
.quad tigermain_framesize-792
.quad tigermain_framesize-800
.quad tigermain_framesize-808
.quad tigermain_framesize-816
.quad -1
GC26:
.quad GC27
.quad L105
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-824
.quad tigermain_framesize-832
.quad tigermain_framesize-840
.quad tigermain_framesize-848
.quad tigermain_framesize-856
.quad tigermain_framesize-864
.quad -1
GC27:
.quad GC28
.quad L106
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-872
.quad tigermain_framesize-880
.quad tigermain_framesize-888
.quad tigermain_framesize-896
.quad tigermain_framesize-904
.quad tigermain_framesize-912
.quad tigermain_framesize-920
.quad tigermain_framesize-928
.quad -1
GC28:
.quad GC29
.quad L107
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-936
.quad tigermain_framesize-944
.quad tigermain_framesize-952
.quad tigermain_framesize-960
.quad tigermain_framesize-968
.quad tigermain_framesize-976
.quad -1
GC29:
.quad GC30
.quad L108
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-984
.quad tigermain_framesize-992
.quad tigermain_framesize-1000
.quad tigermain_framesize-1008
.quad tigermain_framesize-1016
.quad tigermain_framesize-1024
.quad tigermain_framesize-1032
.quad tigermain_framesize-1040
.quad -1
GC30:
.quad GC31
.quad L109
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-1048
.quad tigermain_framesize-1056
.quad tigermain_framesize-1064
.quad tigermain_framesize-1072
.quad tigermain_framesize-1080
.quad tigermain_framesize-1088
.quad -1
GC31:
.quad GC32
.quad L110
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-1096
.quad tigermain_framesize-1104
.quad tigermain_framesize-1112
.quad tigermain_framesize-1120
.quad tigermain_framesize-1128
.quad tigermain_framesize-1136
.quad tigermain_framesize-1144
.quad tigermain_framesize-1152
.quad -1
GC32:
.quad GC33
.quad L111
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-1160
.quad tigermain_framesize-1168
.quad tigermain_framesize-1176
.quad tigermain_framesize-1184
.quad tigermain_framesize-1192
.quad tigermain_framesize-1200
.quad -1
GC33:
.quad GC34
.quad L112
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-1208
.quad tigermain_framesize-1216
.quad tigermain_framesize-1224
.quad tigermain_framesize-1232
.quad tigermain_framesize-1240
.quad tigermain_framesize-1248
.quad tigermain_framesize-1256
.quad tigermain_framesize-1264
.quad -1
GC34:
.quad GC35
.quad L113
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-1272
.quad tigermain_framesize-1280
.quad tigermain_framesize-1288
.quad tigermain_framesize-1296
.quad tigermain_framesize-1304
.quad tigermain_framesize-1312
.quad -1
GC35:
.quad GC36
.quad L114
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-1320
.quad tigermain_framesize-1328
.quad tigermain_framesize-1336
.quad tigermain_framesize-1344
.quad tigermain_framesize-1352
.quad tigermain_framesize-1360
.quad tigermain_framesize-1368
.quad tigermain_framesize-1376
.quad -1
GC36:
.quad GC37
.quad L115
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-1384
.quad tigermain_framesize-1392
.quad tigermain_framesize-1400
.quad tigermain_framesize-1408
.quad tigermain_framesize-1416
.quad tigermain_framesize-1424
.quad -1
GC37:
.quad GC38
.quad L116
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-1432
.quad tigermain_framesize-1440
.quad tigermain_framesize-1448
.quad tigermain_framesize-1456
.quad tigermain_framesize-1464
.quad tigermain_framesize-1472
.quad tigermain_framesize-1480
.quad tigermain_framesize-1488
.quad -1
GC38:
.quad GC39
.quad L117
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-1496
.quad tigermain_framesize-1504
.quad tigermain_framesize-1512
.quad tigermain_framesize-1520
.quad tigermain_framesize-1528
.quad tigermain_framesize-1536
.quad -1
GC39:
.quad GC40
.quad L118
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-1544
.quad tigermain_framesize-1552
.quad tigermain_framesize-1560
.quad tigermain_framesize-1568
.quad tigermain_framesize-1576
.quad tigermain_framesize-1584
.quad tigermain_framesize-1592
.quad tigermain_framesize-1600
.quad -1
GC40:
.quad GC41
.quad L119
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-1608
.quad tigermain_framesize-1616
.quad tigermain_framesize-1624
.quad tigermain_framesize-1632
.quad tigermain_framesize-1640
.quad tigermain_framesize-1648
.quad -1
GC41:
.quad GC42
.quad L120
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-1656
.quad tigermain_framesize-1664
.quad tigermain_framesize-1672
.quad tigermain_framesize-1680
.quad tigermain_framesize-1688
.quad tigermain_framesize-1696
.quad tigermain_framesize-1704
.quad tigermain_framesize-1712
.quad -1
GC42:
.quad GC43
.quad L121
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-1720
.quad tigermain_framesize-1728
.quad tigermain_framesize-1736
.quad tigermain_framesize-1744
.quad tigermain_framesize-1752
.quad tigermain_framesize-1760
.quad -1
GC43:
.quad GC44
.quad L122
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-1768
.quad tigermain_framesize-1776
.quad tigermain_framesize-1784
.quad tigermain_framesize-1792
.quad tigermain_framesize-1800
.quad tigermain_framesize-1808
.quad tigermain_framesize-1816
.quad tigermain_framesize-1824
.quad -1
GC44:
.quad GC45
.quad L123
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-1832
.quad tigermain_framesize-1840
.quad tigermain_framesize-1848
.quad tigermain_framesize-1856
.quad tigermain_framesize-1864
.quad tigermain_framesize-1872
.quad -1
GC45:
.quad GC46
.quad L124
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-1880
.quad tigermain_framesize-1888
.quad tigermain_framesize-1896
.quad tigermain_framesize-1904
.quad tigermain_framesize-1912
.quad tigermain_framesize-1920
.quad tigermain_framesize-1928
.quad tigermain_framesize-1936
.quad -1
GC46:
.quad GC47
.quad L125
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-1944
.quad tigermain_framesize-1952
.quad tigermain_framesize-1960
.quad tigermain_framesize-1968
.quad tigermain_framesize-1976
.quad tigermain_framesize-1984
.quad -1
GC47:
.quad GC48
.quad L126
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-1992
.quad tigermain_framesize-2000
.quad tigermain_framesize-2008
.quad tigermain_framesize-2016
.quad tigermain_framesize-2024
.quad tigermain_framesize-2032
.quad tigermain_framesize-2040
.quad tigermain_framesize-2048
.quad -1
GC48:
.quad GC49
.quad L127
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-2056
.quad tigermain_framesize-2064
.quad tigermain_framesize-2072
.quad tigermain_framesize-2080
.quad tigermain_framesize-2088
.quad tigermain_framesize-2096
.quad tigermain_framesize-2104
.quad tigermain_framesize-2112
.quad -1
GC49:
.quad GC50
.quad L128
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-2120
.quad tigermain_framesize-2128
.quad tigermain_framesize-2136
.quad tigermain_framesize-2144
.quad tigermain_framesize-2152
.quad tigermain_framesize-2160
.quad tigermain_framesize-2168
.quad tigermain_framesize-2176
.quad -1
GC50:
.quad GC51
.quad L129
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-2184
.quad tigermain_framesize-2192
.quad tigermain_framesize-2200
.quad tigermain_framesize-2208
.quad tigermain_framesize-2216
.quad tigermain_framesize-2224
.quad tigermain_framesize-2232
.quad tigermain_framesize-2240
.quad -1
GC51:
.quad GC52
.quad L130
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-2248
.quad tigermain_framesize-2256
.quad tigermain_framesize-2264
.quad tigermain_framesize-2272
.quad tigermain_framesize-2280
.quad tigermain_framesize-2288
.quad -1
GC52:
.quad GC53
.quad L131
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-2296
.quad tigermain_framesize-2304
.quad tigermain_framesize-2312
.quad tigermain_framesize-2320
.quad tigermain_framesize-2328
.quad tigermain_framesize-2336
.quad -1
GC53:
.quad GC54
.quad L132
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-2344
.quad tigermain_framesize-2352
.quad tigermain_framesize-2360
.quad tigermain_framesize-2368
.quad -1
GC54:
.quad GC55
.quad L133
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-2376
.quad tigermain_framesize-2384
.quad tigermain_framesize-2392
.quad tigermain_framesize-2400
.quad -1
GC55:
.quad GC56
.quad L134
.quad tigermain_framesize
.quad tigermain_framesize-2408
.quad tigermain_framesize-2416
.quad -1
GC56:
.quad GC57
.quad L135
.quad tigermain_framesize
.quad tigermain_framesize-2424
.quad tigermain_framesize-2432
.quad -1
GC57:
.quad GC58
.quad L136
.quad tigermain_framesize
.quad -1
GC58:
.quad GC59
.quad L137
.quad tigermain_framesize
.quad -1
GC59:
.quad GC60
.quad L138
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-2440
.quad tigermain_framesize-2448
.quad tigermain_framesize-2456
.quad tigermain_framesize-2464
.quad tigermain_framesize-2472
.quad tigermain_framesize-2480
.quad tigermain_framesize-2488
.quad tigermain_framesize-2496
.quad -1
GC60:
.quad GC61
.quad L139
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-2504
.quad tigermain_framesize-2512
.quad tigermain_framesize-2520
.quad tigermain_framesize-2528
.quad tigermain_framesize-2536
.quad tigermain_framesize-2544
.quad -1
GC61:
.quad GC62
.quad L140
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-2552
.quad tigermain_framesize-2560
.quad tigermain_framesize-2568
.quad tigermain_framesize-2576
.quad tigermain_framesize-2584
.quad tigermain_framesize-2592
.quad tigermain_framesize-2600
.quad tigermain_framesize-2608
.quad -1
GC62:
.quad GC63
.quad L141
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-2616
.quad tigermain_framesize-2624
.quad tigermain_framesize-2632
.quad tigermain_framesize-2640
.quad tigermain_framesize-2648
.quad tigermain_framesize-2656
.quad -1
GC63:
.quad GC64
.quad L142
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-2664
.quad tigermain_framesize-2672
.quad tigermain_framesize-2680
.quad tigermain_framesize-2688
.quad tigermain_framesize-2696
.quad tigermain_framesize-2704
.quad tigermain_framesize-2712
.quad tigermain_framesize-2720
.quad -1
GC64:
.quad GC65
.quad L143
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-2728
.quad tigermain_framesize-2736
.quad tigermain_framesize-2744
.quad tigermain_framesize-2752
.quad tigermain_framesize-2760
.quad tigermain_framesize-2768
.quad -1
GC65:
.quad GC66
.quad L144
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-2776
.quad tigermain_framesize-2784
.quad tigermain_framesize-2792
.quad tigermain_framesize-2800
.quad tigermain_framesize-2808
.quad tigermain_framesize-2816
.quad tigermain_framesize-2824
.quad tigermain_framesize-2832
.quad -1
GC66:
.quad GC67
.quad L145
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-2840
.quad tigermain_framesize-2848
.quad tigermain_framesize-2856
.quad tigermain_framesize-2864
.quad tigermain_framesize-2872
.quad tigermain_framesize-2880
.quad -1
GC67:
.quad GC68
.quad L146
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-2888
.quad tigermain_framesize-2896
.quad tigermain_framesize-2904
.quad tigermain_framesize-2912
.quad tigermain_framesize-2920
.quad tigermain_framesize-2928
.quad tigermain_framesize-2936
.quad tigermain_framesize-2944
.quad -1
GC68:
.quad GC69
.quad L147
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-2952
.quad tigermain_framesize-2960
.quad tigermain_framesize-2968
.quad tigermain_framesize-2976
.quad tigermain_framesize-2984
.quad tigermain_framesize-2992
.quad -1
GC69:
.quad GC70
.quad L148
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-3000
.quad tigermain_framesize-3008
.quad tigermain_framesize-3016
.quad tigermain_framesize-3024
.quad tigermain_framesize-3032
.quad tigermain_framesize-3040
.quad tigermain_framesize-3048
.quad tigermain_framesize-3056
.quad -1
GC70:
.quad GC71
.quad L149
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-3064
.quad tigermain_framesize-3072
.quad tigermain_framesize-3080
.quad tigermain_framesize-3088
.quad tigermain_framesize-3096
.quad tigermain_framesize-3104
.quad -1
GC71:
.quad GC72
.quad L150
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-3112
.quad tigermain_framesize-3120
.quad tigermain_framesize-3128
.quad tigermain_framesize-3136
.quad tigermain_framesize-3144
.quad tigermain_framesize-3152
.quad tigermain_framesize-3160
.quad tigermain_framesize-3168
.quad -1
GC72:
.quad GC73
.quad L151
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-3176
.quad tigermain_framesize-3184
.quad tigermain_framesize-3192
.quad tigermain_framesize-3200
.quad tigermain_framesize-3208
.quad tigermain_framesize-3216
.quad -1
GC73:
.quad GC74
.quad L152
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-3224
.quad tigermain_framesize-3232
.quad tigermain_framesize-3240
.quad tigermain_framesize-3248
.quad tigermain_framesize-3256
.quad tigermain_framesize-3264
.quad tigermain_framesize-3272
.quad tigermain_framesize-3280
.quad -1
GC74:
.quad GC75
.quad L153
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-3288
.quad tigermain_framesize-3296
.quad tigermain_framesize-3304
.quad tigermain_framesize-3312
.quad tigermain_framesize-3320
.quad tigermain_framesize-3328
.quad -1
GC75:
.quad GC76
.quad L154
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-3336
.quad tigermain_framesize-3344
.quad tigermain_framesize-3352
.quad tigermain_framesize-3360
.quad tigermain_framesize-3368
.quad tigermain_framesize-3376
.quad tigermain_framesize-3384
.quad tigermain_framesize-3392
.quad -1
GC76:
.quad GC77
.quad L155
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-3400
.quad tigermain_framesize-3408
.quad tigermain_framesize-3416
.quad tigermain_framesize-3424
.quad tigermain_framesize-3432
.quad tigermain_framesize-3440
.quad -1
GC77:
.quad GC78
.quad L156
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-3448
.quad tigermain_framesize-3456
.quad tigermain_framesize-3464
.quad tigermain_framesize-3472
.quad tigermain_framesize-3480
.quad tigermain_framesize-3488
.quad tigermain_framesize-3496
.quad tigermain_framesize-3504
.quad -1
GC78:
.quad GC79
.quad L157
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-3512
.quad tigermain_framesize-3520
.quad tigermain_framesize-3528
.quad tigermain_framesize-3536
.quad tigermain_framesize-3544
.quad tigermain_framesize-3552
.quad -1
GC79:
.quad GC80
.quad L158
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-3560
.quad tigermain_framesize-3568
.quad tigermain_framesize-3576
.quad tigermain_framesize-3584
.quad tigermain_framesize-3592
.quad tigermain_framesize-3600
.quad tigermain_framesize-3608
.quad tigermain_framesize-3616
.quad -1
GC80:
.quad GC81
.quad L159
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-3624
.quad tigermain_framesize-3632
.quad tigermain_framesize-3640
.quad tigermain_framesize-3648
.quad tigermain_framesize-3656
.quad tigermain_framesize-3664
.quad -1
GC81:
.quad GC82
.quad L160
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-3672
.quad tigermain_framesize-3680
.quad tigermain_framesize-3688
.quad tigermain_framesize-3696
.quad tigermain_framesize-3704
.quad tigermain_framesize-3712
.quad tigermain_framesize-3720
.quad tigermain_framesize-3728
.quad -1
GC82:
.quad GC83
.quad L161
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-3736
.quad tigermain_framesize-3744
.quad tigermain_framesize-3752
.quad tigermain_framesize-3760
.quad tigermain_framesize-3768
.quad tigermain_framesize-3776
.quad -1
GC83:
.quad GC84
.quad L162
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-3784
.quad tigermain_framesize-3792
.quad tigermain_framesize-3800
.quad tigermain_framesize-3808
.quad tigermain_framesize-3816
.quad tigermain_framesize-3824
.quad tigermain_framesize-3832
.quad tigermain_framesize-3840
.quad -1
GC84:
.quad GC85
.quad L163
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-3848
.quad tigermain_framesize-3856
.quad tigermain_framesize-3864
.quad tigermain_framesize-3872
.quad tigermain_framesize-3880
.quad tigermain_framesize-3888
.quad -1
GC85:
.quad GC86
.quad L164
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-3896
.quad tigermain_framesize-3904
.quad tigermain_framesize-3912
.quad tigermain_framesize-3920
.quad tigermain_framesize-3928
.quad tigermain_framesize-3936
.quad tigermain_framesize-3944
.quad tigermain_framesize-3952
.quad -1
GC86:
.quad GC87
.quad L165
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-3960
.quad tigermain_framesize-3968
.quad tigermain_framesize-3976
.quad tigermain_framesize-3984
.quad tigermain_framesize-3992
.quad tigermain_framesize-4000
.quad -1
GC87:
.quad GC88
.quad L166
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-4008
.quad tigermain_framesize-4016
.quad tigermain_framesize-4024
.quad tigermain_framesize-4032
.quad tigermain_framesize-4040
.quad tigermain_framesize-4048
.quad tigermain_framesize-4056
.quad tigermain_framesize-4064
.quad -1
GC88:
.quad GC89
.quad L167
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-4072
.quad tigermain_framesize-4080
.quad tigermain_framesize-4088
.quad tigermain_framesize-4096
.quad tigermain_framesize-4104
.quad tigermain_framesize-4112
.quad -1
GC89:
.quad GC90
.quad L168
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-4120
.quad tigermain_framesize-4128
.quad tigermain_framesize-4136
.quad tigermain_framesize-4144
.quad tigermain_framesize-4152
.quad tigermain_framesize-4160
.quad tigermain_framesize-4168
.quad tigermain_framesize-4176
.quad -1
GC90:
.quad GC91
.quad L169
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-4184
.quad tigermain_framesize-4192
.quad tigermain_framesize-4200
.quad tigermain_framesize-4208
.quad tigermain_framesize-4216
.quad tigermain_framesize-4224
.quad -1
GC91:
.quad GC92
.quad L170
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-4232
.quad tigermain_framesize-4240
.quad tigermain_framesize-4248
.quad tigermain_framesize-4256
.quad tigermain_framesize-4264
.quad tigermain_framesize-4272
.quad tigermain_framesize-4280
.quad tigermain_framesize-4288
.quad -1
GC92:
.quad GC93
.quad L171
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-4296
.quad tigermain_framesize-4304
.quad tigermain_framesize-4312
.quad tigermain_framesize-4320
.quad -1
GC93:
.quad GC94
.quad L172
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-4328
.quad tigermain_framesize-4336
.quad -1
GC94:
.quad GC95
.quad L173
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-4344
.quad tigermain_framesize-4352
.quad tigermain_framesize-4360
.quad tigermain_framesize-4368
.quad -1
GC95:
.quad GC96
.quad L174
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-4376
.quad tigermain_framesize-4384
.quad -1
GC96:
.quad GC97
.quad L175
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-4392
.quad tigermain_framesize-4400
.quad tigermain_framesize-4408
.quad tigermain_framesize-4416
.quad -1
GC97:
.quad GC98
.quad L176
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-4424
.quad tigermain_framesize-4432
.quad -1
GC98:
.quad GC99
.quad L177
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-4440
.quad tigermain_framesize-4448
.quad tigermain_framesize-4456
.quad tigermain_framesize-4464
.quad -1
GC99:
.quad GC100
.quad L178
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-4472
.quad tigermain_framesize-4480
.quad -1
GC100:
.quad GC101
.quad L179
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-4488
.quad tigermain_framesize-4496
.quad tigermain_framesize-4504
.quad tigermain_framesize-4512
.quad -1
GC101:
.quad GC102
.quad L180
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-4520
.quad tigermain_framesize-4528
.quad -1
GC102:
.quad GC103
.quad L181
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-4536
.quad tigermain_framesize-4544
.quad tigermain_framesize-4552
.quad tigermain_framesize-4560
.quad -1
GC103:
.quad GC104
.quad L182
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-4568
.quad tigermain_framesize-4576
.quad -1
GC104:
.quad GC105
.quad L183
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-4584
.quad tigermain_framesize-4592
.quad tigermain_framesize-4600
.quad tigermain_framesize-4608
.quad -1
GC105:
.quad GC106
.quad L184
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-4616
.quad tigermain_framesize-4624
.quad -1
GC106:
.quad GC107
.quad L185
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-4632
.quad tigermain_framesize-4640
.quad tigermain_framesize-4648
.quad tigermain_framesize-4656
.quad -1
GC107:
.quad GC108
.quad L186
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-4664
.quad tigermain_framesize-4672
.quad -1
GC108:
.quad -1
.quad L187
.quad tigermain_framesize
.quad tigermain_framesize-64
.quad tigermain_framesize-4680
.quad tigermain_framesize-4688
.quad tigermain_framesize-4696
.quad tigermain_framesize-4704
.quad -1
