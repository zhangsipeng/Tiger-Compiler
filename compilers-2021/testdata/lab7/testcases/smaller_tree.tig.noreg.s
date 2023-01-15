.text
.globl insert
.type insert, @function
insert:
.set insert_framesize, 16
subq $16, %rsp
movq %rbx, t141
movq %rbp, t142
movq %r12, t143
movq %r13, t144
movq %r14, t145
movq %r15, t146
L55:
movq %rdx, t120
movq %rsi, t119
movq %rdi,(insert_framesize-8)(%rsp)
movq t119, t124
movq t119, t125
movq $0, t147
cmpq t147, t119
je L23
L24:
movq $0, t149
movq t119, t148
addq t149, t148
movq (t148), t150
movq $0, t152
movq t120, t151
addq t152, t151
movq (t151), t153
cmpq t153, t150
jl L5
L6:
movq $8, t155
movq t119, t154
addq t155, t154
movq (t154), t156
movq t156, t126
L7:
movq t126, t125
L17:
movq $0, t157
cmpq t157, t125
jne L16
L8:
movq $0, t159
movq t124, t158
addq t159, t158
movq (t158), t160
movq $0, t162
movq t120, t161
addq t162, t161
movq (t161), t163
cmpq t163, t160
jl L20
L21:
movq t120, 8(t124)
movq $0, t164
movq t164, t128
L22:
movq t119, t129
L25:
movq t129, %rax
jmp L54
L23:
movq t120, t129
jmp L25
L5:
movq $16, t166
movq t119, t165
addq t166, t165
movq (t165), t167
movq t167, t126
jmp L7
L16:
movq t125, t124
movq $0, t169
movq t124, t168
addq t169, t168
movq (t168), t170
movq $0, t172
movq t120, t171
addq t172, t171
movq (t171), t173
cmpq t173, t170
jl L13
L14:
movq $8, t175
movq t124, t174
addq t175, t174
movq (t174), t176
movq t176, t127
L15:
movq t127, t125
jmp L17
L13:
movq $16, t178
movq t124, t177
addq t178, t177
movq (t177), t179
movq t179, t127
jmp L15
L20:
movq t120, 16(t124)
movq $0, t180
movq t180, t128
jmp L22
L54:
movq t141, %rbx
movq t142, %rbp
movq t143, %r12
movq t144, %r13
movq t145, %r14
movq t146, %r15


addq $16, %rsp
retq
.size insert, .-insert
.globl f
.type f, @function
f:
.set f_framesize, 16
subq $16, %rsp
movq %rbx, t184
movq %rbp, t185
movq %r12, t186
movq %r13, t187
movq %r14, t188
movq %r15, t189
L57:
movq %rsi, t130
movq %rdi,(f_framesize-8)(%rsp)
movq $0, t190
cmpq t190, t130
jg L29
L30:
movq $0, t191
movq t191, %rax
jmp L56
L29:
movq $8, t194
leaq f_framesize(%rsp), t193
subq t194, t193
movq (t193), t195
movq t195, %rdi
movq $10, t197
movq t130, %rax
cqto
idivq t197
movq %rax, t196
movq t196, %rsi
callq f
L58:
addq $0, %rsp
movq %rax, t192
movq $10, t201
movq t130, %rax
cqto
idivq t201
movq %rax, t200
movq $10, t202
movq t200, %rax
imulq t202
movq %rax, t199
movq t130, t198
subq t199, t198
movq t198, t183
leaq L28(%rip), t204
movq t204, %rdi
callq ord
L59:
addq $0, %rsp
movq %rax, t203
movq t203, t182
movq t183, t206
addq t182, t206
movq t206, %rdi
callq chr
L60:
addq $0, %rsp
movq %rax, t205
movq t205, t181
movq t181, %rdi
callq print
L61:
addq $0, %rsp
movq %rax, t207
jmp L30
L56:
movq t184, %rbx
movq t185, %rbp
movq t186, %r12
movq t187, %r13
movq t188, %r14
movq t189, %r15


addq $16, %rsp
retq
.size f, .-f
.globl printint
.type printint, @function
printint:
.set printint_framesize, 16
subq $16, %rsp
movq %rbx, t208
movq %rbp, t209
movq %r12, t210
movq %r13, t211
movq %r14, t212
movq %r15, t213
L63:
movq %rsi, t121
movq %rdi,(printint_framesize-8)(%rsp)
movq $0, t214
cmpq t214, t121
jl L41
L42:
movq $0, t215
cmpq t215, t121
jg L38
L39:
leaq L37(%rip), t217
movq t217, %rdi
callq print
L64:
addq $0, %rsp
movq %rax, t216
movq t216, t132
L40:
movq t132, t133
L43:
leaq L44(%rip), t219
movq t219, %rdi
callq print
L65:
addq $0, %rsp
movq %rax, t218
movq t218, %rax
jmp L62
L41:
leaq L34(%rip), t221
movq t221, %rdi
callq print
L66:
addq $0, %rsp
movq %rax, t220
leaq printint_framesize(%rsp), %rdi
movq $0, t224
movq t224, t223
subq t121, t223
movq t223, %rsi
callq f
L67:
addq $0, %rsp
movq %rax, t222
movq t222, t133
jmp L43
L38:
leaq printint_framesize(%rsp), %rdi
movq t121, %rsi
callq f
L68:
addq $0, %rsp
movq %rax, t225
movq t225, t132
jmp L40
L62:
movq t208, %rbx
movq t209, %rbp
movq t210, %r12
movq t211, %r13
movq t212, %r14
movq t213, %r15


addq $16, %rsp
retq
.size printint, .-printint
.globl printtree
.type printtree, @function
printtree:
.set printtree_framesize, 16
subq $16, %rsp
movq %rbx, t226
movq %rbp, t227
movq %r12, t228
movq %r13, t229
movq %r14, t230
movq %r15, t231
L70:
movq %rsi, t122
movq %rdi,(printtree_framesize-8)(%rsp)
movq $0, t232
cmpq t232, t122
jne L47
L48:
movq $0, t233
movq t233, %rax
jmp L69
L47:
movq $8, t236
leaq printtree_framesize(%rsp), t235
subq t236, t235
movq (t235), t237
movq t237, %rdi
movq $8, t239
movq t122, t238
addq t239, t238
movq (t238), t240
movq t240, %rsi
callq printtree
L71:
addq $0, %rsp
movq %rax, t234
movq $8, t243
leaq printtree_framesize(%rsp), t242
subq t243, t242
movq (t242), t244
movq t244, %rdi
movq $0, t246
movq t122, t245
addq t246, t245
movq (t245), t247
movq t247, %rsi
callq printint
L72:
addq $0, %rsp
movq %rax, t241
movq $8, t250
leaq printtree_framesize(%rsp), t249
subq t250, t249
movq (t249), t251
movq t251, %rdi
movq $16, t253
movq t122, t252
addq t253, t252
movq (t252), t254
movq t254, %rsi
callq printtree
L73:
addq $0, %rsp
movq %rax, t248
jmp L48
L69:
movq t226, %rbx
movq t227, %rbp
movq t228, %r12
movq t229, %r13
movq t230, %r14
movq t231, %r15


addq $16, %rsp
retq
.size printtree, .-printtree
.globl getnode
.type getnode, @function
getnode:
.set getnode_framesize, 16
subq $16, %rsp
movq %rbx, t255
movq %rbp, t256
movq %r12, t257
movq %r13, t258
movq %r14, t259
movq %r15, t260
L75:
movq %rsi, t123
movq %rdi,(getnode_framesize-8)(%rsp)
movq $24, t262
movq t262, %rdi
callq alloc_record
L76:
addq $0, %rsp
movq %rax, t261
movq t261, t135
movq t123, 0(t135)
movq $0, t263
movq t263, 8(t135)
movq $0, t264
movq t264, 16(t135)
movq t135, %rax
jmp L74
L74:
movq t255, %rbx
movq t256, %rbp
movq t257, %r12
movq t258, %r13
movq t259, %r14
movq t260, %r15


addq $16, %rsp
retq
.size getnode, .-getnode
.globl tigermain
.type tigermain, @function
tigermain:
.set tigermain_framesize, 8
subq $8, %rsp
movq %rbx, t277
movq %rbp, t278
movq %r12, t279
movq %r13, t280
movq %r14, t281
movq %r15, t282
L78:
callq MaxFree
L79:
addq $0, %rsp
movq %rax, t283
movq t283, t116
movq $1024, t284
movq t284, t117
movq $512, t288
movq $1024, t289
movq t288, %rax
imulq t289
movq %rax, t287
movq t116, t286
subq t287, t286
movq $32, t290
movq t286, %rax
cqto
idivq t290
movq %rax, t285
movq t285, t118
movq $0, t291
movq t291, t136
movq $0, t292
movq t292, t137
movq $0, t293
movq t293, t138
movq $0, t294
movq t294, t139
movq $0, t295
movq t295, t140
movq tigermain_framesize(%rsp), t276
movq t136, t275
leaq tigermain_framesize(%rsp), %rdi
movq t117, %rsi
callq getnode
L80:
addq $0, %rsp
movq %rax, t296
movq t296, t274
movq t276, %rdi
movq t275, %rsi
movq t274, %rdx
callq insert
L81:
addq $0, %rsp
movq %rax, t297
movq t297, t136
movq tigermain_framesize(%rsp), t273
movq t137, t272
leaq tigermain_framesize(%rsp), %rdi
movq $2, t300
movq t300, %rax
imulq t117
movq %rax, t299
movq t299, %rsi
callq getnode
L82:
addq $0, %rsp
movq %rax, t298
movq t298, t271
movq t273, %rdi
movq t272, %rsi
movq t271, %rdx
callq insert
L83:
addq $0, %rsp
movq %rax, t301
movq t301, t137
movq tigermain_framesize(%rsp), t270
movq t138, t269
leaq tigermain_framesize(%rsp), %rdi
movq $3, t304
movq t304, %rax
imulq t117
movq %rax, t303
movq t303, %rsi
callq getnode
L84:
addq $0, %rsp
movq %rax, t302
movq t302, t268
movq t270, %rdi
movq t269, %rsi
movq t268, %rdx
callq insert
L85:
addq $0, %rsp
movq %rax, t305
movq t305, t138
movq tigermain_framesize(%rsp), t267
movq t139, t266
leaq tigermain_framesize(%rsp), %rdi
movq $4, t308
movq t308, %rax
imulq t117
movq %rax, t307
movq t307, %rsi
callq getnode
L86:
addq $0, %rsp
movq %rax, t306
movq t306, t265
movq t267, %rdi
movq t266, %rsi
movq t265, %rdx
callq insert
L87:
addq $0, %rsp
movq %rax, t309
movq t309, t139
leaq tigermain_framesize(%rsp), %rdi
movq t136, %rsi
callq printtree
L88:
addq $0, %rsp
movq %rax, t310
leaq L50(%rip), t312
movq t312, %rdi
callq print
L89:
addq $0, %rsp
movq %rax, t311
leaq tigermain_framesize(%rsp), %rdi
movq t137, %rsi
callq printtree
L90:
addq $0, %rsp
movq %rax, t313
leaq L51(%rip), t315
movq t315, %rdi
callq print
L91:
addq $0, %rsp
movq %rax, t314
leaq tigermain_framesize(%rsp), %rdi
movq t138, %rsi
callq printtree
L92:
addq $0, %rsp
movq %rax, t316
leaq L52(%rip), t318
movq t318, %rdi
callq print
L93:
addq $0, %rsp
movq %rax, t317
leaq tigermain_framesize(%rsp), %rdi
movq t139, %rsi
callq printtree
L94:
addq $0, %rsp
movq %rax, t319
leaq L53(%rip), t321
movq t321, %rdi
callq print
L95:
addq $0, %rsp
movq %rax, t320
movq t320, %rax
jmp L77
L77:
movq t277, %rbx
movq t278, %rbp
movq t279, %r12
movq t280, %r13
movq t281, %r14
movq t282, %r15


addq $8, %rsp
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
.quad -1
GC16:
.quad GC17
.quad L81
.quad tigermain_framesize
.quad -1
GC17:
.quad GC18
.quad L82
.quad tigermain_framesize
.quad -1
GC18:
.quad GC19
.quad L83
.quad tigermain_framesize
.quad -1
GC19:
.quad GC20
.quad L84
.quad tigermain_framesize
.quad -1
GC20:
.quad GC21
.quad L85
.quad tigermain_framesize
.quad -1
GC21:
.quad GC22
.quad L86
.quad tigermain_framesize
.quad -1
GC22:
.quad GC23
.quad L87
.quad tigermain_framesize
.quad -1
GC23:
.quad GC24
.quad L88
.quad tigermain_framesize
.quad -1
GC24:
.quad GC25
.quad L89
.quad tigermain_framesize
.quad -1
GC25:
.quad GC26
.quad L90
.quad tigermain_framesize
.quad -1
GC26:
.quad GC27
.quad L91
.quad tigermain_framesize
.quad -1
GC27:
.quad GC28
.quad L92
.quad tigermain_framesize
.quad -1
GC28:
.quad GC29
.quad L93
.quad tigermain_framesize
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
