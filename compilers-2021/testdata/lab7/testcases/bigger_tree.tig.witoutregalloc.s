.text
.globl insert
.type insert, @function
insert:
.set insert_framesize, 16
subq $16, %rsp
movq %rbx, t145
movq %rbp, t146
movq %r12, t147
movq %r13, t148
movq %r14, t149
movq %r15, t150
L69:
movq %rdx, t120
movq %rsi, t119
movq %rdi,(insert_framesize-8)(%rsp)
movq t119, t124
movq t119, t125
movq $0, t151
cmpq t151, t119
je L23
L24:
movq $0, t153
movq t119, t152
addq t153, t152
movq (t152), t154
movq $0, t156
movq t120, t155
addq t156, t155
movq (t155), t157
cmpq t157, t154
jl L5
L6:
movq $8, t159
movq t119, t158
addq t159, t158
movq (t158), t160
movq t160, t126
L7:
movq t126, t125
L17:
movq $0, t161
cmpq t161, t125
jne L16
L8:
movq $0, t163
movq t124, t162
addq t163, t162
movq (t162), t164
movq $0, t166
movq t120, t165
addq t166, t165
movq (t165), t167
cmpq t167, t164
jl L20
L21:
movq t120, 8(t124)
movq $0, t168
movq t168, t128
L22:
movq t119, t129
L25:
movq t129, %rax
jmp L68
L23:
movq t120, t129
jmp L25
L5:
movq $16, t170
movq t119, t169
addq t170, t169
movq (t169), t171
movq t171, t126
jmp L7
L16:
movq t125, t124
movq $0, t173
movq t124, t172
addq t173, t172
movq (t172), t174
movq $0, t176
movq t120, t175
addq t176, t175
movq (t175), t177
cmpq t177, t174
jl L13
L14:
movq $8, t179
movq t124, t178
addq t179, t178
movq (t178), t180
movq t180, t127
L15:
movq t127, t125
jmp L17
L13:
movq $16, t182
movq t124, t181
addq t182, t181
movq (t181), t183
movq t183, t127
jmp L15
L20:
movq t120, 16(t124)
movq $0, t184
movq t184, t128
jmp L22
L68:
movq t145, %rbx
movq t146, %rbp
movq t147, %r12
movq t148, %r13
movq t149, %r14
movq t150, %r15


addq $16, %rsp
retq
.size insert, .-insert
.globl f
.type f, @function
f:
.set f_framesize, 16
subq $16, %rsp
movq %rbx, t188
movq %rbp, t189
movq %r12, t190
movq %r13, t191
movq %r14, t192
movq %r15, t193
L71:
movq %rsi, t130
movq %rdi,(f_framesize-8)(%rsp)
movq $0, t194
cmpq t194, t130
jg L29
L30:
movq $0, t195
movq t195, %rax
jmp L70
L29:
movq $8, t198
leaq f_framesize(%rsp), t197
subq t198, t197
movq (t197), t199
movq t199, %rdi
movq $10, t201
movq t130, %rax
cqto
idivq t201
movq %rax, t200
movq t200, %rsi
callq f
L72:
addq $0, %rsp
movq %rax, t196
movq $10, t205
movq t130, %rax
cqto
idivq t205
movq %rax, t204
movq $10, t206
movq t204, %rax
imulq t206
movq %rax, t203
movq t130, t202
subq t203, t202
movq t202, t187
leaq L28(%rip), t208
movq t208, %rdi
callq ord
L73:
addq $0, %rsp
movq %rax, t207
movq t207, t186
movq t187, t210
addq t186, t210
movq t210, %rdi
callq chr
L74:
addq $0, %rsp
movq %rax, t209
movq t209, t185
movq t185, %rdi
callq print
L75:
addq $0, %rsp
movq %rax, t211
jmp L30
L70:
movq t188, %rbx
movq t189, %rbp
movq t190, %r12
movq t191, %r13
movq t192, %r14
movq t193, %r15


addq $16, %rsp
retq
.size f, .-f
.globl printint
.type printint, @function
printint:
.set printint_framesize, 16
subq $16, %rsp
movq %rbx, t212
movq %rbp, t213
movq %r12, t214
movq %r13, t215
movq %r14, t216
movq %r15, t217
L77:
movq %rsi, t121
movq %rdi,(printint_framesize-8)(%rsp)
movq $0, t218
cmpq t218, t121
jl L41
L42:
movq $0, t219
cmpq t219, t121
jg L38
L39:
leaq L37(%rip), t221
movq t221, %rdi
callq print
L78:
addq $0, %rsp
movq %rax, t220
movq t220, t132
L40:
movq t132, t133
L43:
leaq L44(%rip), t223
movq t223, %rdi
callq print
L79:
addq $0, %rsp
movq %rax, t222
movq t222, %rax
jmp L76
L41:
leaq L34(%rip), t225
movq t225, %rdi
callq print
L80:
addq $0, %rsp
movq %rax, t224
leaq printint_framesize(%rsp), %rdi
movq $0, t228
movq t228, t227
subq t121, t227
movq t227, %rsi
callq f
L81:
addq $0, %rsp
movq %rax, t226
movq t226, t133
jmp L43
L38:
leaq printint_framesize(%rsp), %rdi
movq t121, %rsi
callq f
L82:
addq $0, %rsp
movq %rax, t229
movq t229, t132
jmp L40
L76:
movq t212, %rbx
movq t213, %rbp
movq t214, %r12
movq t215, %r13
movq t216, %r14
movq t217, %r15


addq $16, %rsp
retq
.size printint, .-printint
.globl printtree
.type printtree, @function
printtree:
.set printtree_framesize, 16
subq $16, %rsp
movq %rbx, t230
movq %rbp, t231
movq %r12, t232
movq %r13, t233
movq %r14, t234
movq %r15, t235
L84:
movq %rsi, t122
movq %rdi,(printtree_framesize-8)(%rsp)
movq $0, t236
cmpq t236, t122
jne L47
L48:
movq $0, t237
movq t237, %rax
jmp L83
L47:
movq $8, t240
leaq printtree_framesize(%rsp), t239
subq t240, t239
movq (t239), t241
movq t241, %rdi
movq $8, t243
movq t122, t242
addq t243, t242
movq (t242), t244
movq t244, %rsi
callq printtree
L85:
addq $0, %rsp
movq %rax, t238
movq $8, t247
leaq printtree_framesize(%rsp), t246
subq t247, t246
movq (t246), t248
movq t248, %rdi
movq $0, t250
movq t122, t249
addq t250, t249
movq (t249), t251
movq t251, %rsi
callq printint
L86:
addq $0, %rsp
movq %rax, t245
movq $8, t254
leaq printtree_framesize(%rsp), t253
subq t254, t253
movq (t253), t255
movq t255, %rdi
movq $16, t257
movq t122, t256
addq t257, t256
movq (t256), t258
movq t258, %rsi
callq printtree
L87:
addq $0, %rsp
movq %rax, t252
jmp L48
L83:
movq t230, %rbx
movq t231, %rbp
movq t232, %r12
movq t233, %r13
movq t234, %r14
movq t235, %r15


addq $16, %rsp
retq
.size printtree, .-printtree
.globl getnode
.type getnode, @function
getnode:
.set getnode_framesize, 16
subq $16, %rsp
movq %rbx, t259
movq %rbp, t260
movq %r12, t261
movq %r13, t262
movq %r14, t263
movq %r15, t264
L89:
movq %rsi, t123
movq %rdi,(getnode_framesize-8)(%rsp)
movq $24, t266
movq t266, %rdi
callq alloc_record
L90:
addq $0, %rsp
movq %rax, t265
movq t265, t135
movq t123, 0(t135)
movq $0, t267
movq t267, 8(t135)
movq $0, t268
movq t268, 16(t135)
movq t135, %rax
jmp L88
L88:
movq t259, %rbx
movq t260, %rbp
movq t261, %r12
movq t262, %r13
movq t263, %r14
movq t264, %r15


addq $16, %rsp
retq
.size getnode, .-getnode
.globl tigermain
.type tigermain, @function
tigermain:
.set tigermain_framesize, 8
subq $8, %rsp
movq %rbx, t389
movq %rbp, t390
movq %r12, t391
movq %r13, t392
movq %r14, t393
movq %r15, t394
L92:
callq MaxFree
L93:
addq $0, %rsp
movq %rax, t395
movq t395, t116
movq $1024, t396
movq t396, t117
movq $512, t400
movq $1024, t401
movq t400, %rax
imulq t401
movq %rax, t399
movq t116, t398
subq t399, t398
movq $32, t402
movq t398, %rax
cqto
idivq t402
movq %rax, t397
movq t397, t118
movq $0, t403
movq t403, t136
movq $0, t404
movq t404, t137
movq $0, t405
movq t405, t138
movq $0, t406
movq t406, t139
movq $0, t407
movq t407, t140
movq tigermain_framesize(%rsp), t388
movq t136, t387
leaq tigermain_framesize(%rsp), %rdi
movq t117, %rsi
callq getnode
L94:
addq $0, %rsp
movq %rax, t408
movq t408, t386
movq t388, %rdi
movq t387, %rsi
movq t386, %rdx
callq insert
L95:
addq $0, %rsp
movq %rax, t409
movq t409, t136
movq tigermain_framesize(%rsp), t385
movq t137, t384
leaq tigermain_framesize(%rsp), %rdi
movq $2, t412
movq t412, %rax
imulq t117
movq %rax, t411
movq t411, %rsi
callq getnode
L96:
addq $0, %rsp
movq %rax, t410
movq t410, t383
movq t385, %rdi
movq t384, %rsi
movq t383, %rdx
callq insert
L97:
addq $0, %rsp
movq %rax, t413
movq t413, t137
movq tigermain_framesize(%rsp), t382
movq t138, t381
leaq tigermain_framesize(%rsp), %rdi
movq $3, t416
movq t416, %rax
imulq t117
movq %rax, t415
movq t415, %rsi
callq getnode
L98:
addq $0, %rsp
movq %rax, t414
movq t414, t380
movq t382, %rdi
movq t381, %rsi
movq t380, %rdx
callq insert
L99:
addq $0, %rsp
movq %rax, t417
movq t417, t138
movq tigermain_framesize(%rsp), t379
movq t139, t378
leaq tigermain_framesize(%rsp), %rdi
movq $4, t420
movq t420, %rax
imulq t117
movq %rax, t419
movq t419, %rsi
callq getnode
L100:
addq $0, %rsp
movq %rax, t418
movq t418, t377
movq t379, %rdi
movq t378, %rsi
movq t377, %rdx
callq insert
L101:
addq $0, %rsp
movq %rax, t421
movq t421, t139
movq tigermain_framesize(%rsp), t376
movq t136, t375
leaq tigermain_framesize(%rsp), %rdi
movq $2, t424
movq t424, %rax
imulq t117
movq %rax, t423
movq t423, %rsi
callq getnode
L102:
addq $0, %rsp
movq %rax, t422
movq t422, t374
movq t376, %rdi
movq t375, %rsi
movq t374, %rdx
callq insert
L103:
addq $0, %rsp
movq %rax, t425
movq t425, t136
movq tigermain_framesize(%rsp), t373
movq t137, t372
leaq tigermain_framesize(%rsp), %rdi
movq $4, t428
movq t428, %rax
imulq t117
movq %rax, t427
movq t427, %rsi
callq getnode
L104:
addq $0, %rsp
movq %rax, t426
movq t426, t371
movq t373, %rdi
movq t372, %rsi
movq t371, %rdx
callq insert
L105:
addq $0, %rsp
movq %rax, t429
movq t429, t137
movq tigermain_framesize(%rsp), t370
movq t138, t369
leaq tigermain_framesize(%rsp), %rdi
movq $6, t432
movq t432, %rax
imulq t117
movq %rax, t431
movq t431, %rsi
callq getnode
L106:
addq $0, %rsp
movq %rax, t430
movq t430, t368
movq t370, %rdi
movq t369, %rsi
movq t368, %rdx
callq insert
L107:
addq $0, %rsp
movq %rax, t433
movq t433, t138
movq tigermain_framesize(%rsp), t367
movq t139, t366
leaq tigermain_framesize(%rsp), %rdi
movq $8, t436
movq t436, %rax
imulq t117
movq %rax, t435
movq t435, %rsi
callq getnode
L108:
addq $0, %rsp
movq %rax, t434
movq t434, t365
movq t367, %rdi
movq t366, %rsi
movq t365, %rdx
callq insert
L109:
addq $0, %rsp
movq %rax, t437
movq t437, t139
movq tigermain_framesize(%rsp), t364
movq t136, t363
leaq tigermain_framesize(%rsp), %rdi
movq $2, t440
movq t117, %rax
cqto
idivq t440
movq %rax, t439
movq t439, %rsi
callq getnode
L110:
addq $0, %rsp
movq %rax, t438
movq t438, t362
movq t364, %rdi
movq t363, %rsi
movq t362, %rdx
callq insert
L111:
addq $0, %rsp
movq %rax, t441
movq t441, t136
movq tigermain_framesize(%rsp), t361
movq t137, t360
leaq tigermain_framesize(%rsp), %rdi
movq t117, %rsi
callq getnode
L112:
addq $0, %rsp
movq %rax, t442
movq t442, t359
movq t361, %rdi
movq t360, %rsi
movq t359, %rdx
callq insert
L113:
addq $0, %rsp
movq %rax, t443
movq t443, t137
movq tigermain_framesize(%rsp), t358
movq t138, t357
leaq tigermain_framesize(%rsp), %rdi
movq $3, t447
movq t447, %rax
imulq t117
movq %rax, t446
movq $2, t448
movq t446, %rax
cqto
idivq t448
movq %rax, t445
movq t445, %rsi
callq getnode
L114:
addq $0, %rsp
movq %rax, t444
movq t444, t356
movq t358, %rdi
movq t357, %rsi
movq t356, %rdx
callq insert
L115:
addq $0, %rsp
movq %rax, t449
movq t449, t138
movq tigermain_framesize(%rsp), t355
movq t139, t354
leaq tigermain_framesize(%rsp), %rdi
movq $2, t452
movq t452, %rax
imulq t117
movq %rax, t451
movq t451, %rsi
callq getnode
L116:
addq $0, %rsp
movq %rax, t450
movq t450, t353
movq t355, %rdi
movq t354, %rsi
movq t353, %rdx
callq insert
L117:
addq $0, %rsp
movq %rax, t453
movq t453, t139
movq tigermain_framesize(%rsp), t352
movq t136, t351
leaq tigermain_framesize(%rsp), %rdi
movq $3, t457
movq t457, %rax
imulq t117
movq %rax, t456
movq $2, t458
movq t456, %rax
cqto
idivq t458
movq %rax, t455
movq t455, %rsi
callq getnode
L118:
addq $0, %rsp
movq %rax, t454
movq t454, t350
movq t352, %rdi
movq t351, %rsi
movq t350, %rdx
callq insert
L119:
addq $0, %rsp
movq %rax, t459
movq t459, t136
movq tigermain_framesize(%rsp), t349
movq t137, t348
leaq tigermain_framesize(%rsp), %rdi
movq $3, t462
movq t462, %rax
imulq t117
movq %rax, t461
movq t461, %rsi
callq getnode
L120:
addq $0, %rsp
movq %rax, t460
movq t460, t347
movq t349, %rdi
movq t348, %rsi
movq t347, %rdx
callq insert
L121:
addq $0, %rsp
movq %rax, t463
movq t463, t137
movq tigermain_framesize(%rsp), t346
movq t138, t345
leaq tigermain_framesize(%rsp), %rdi
movq $9, t467
movq t467, %rax
imulq t117
movq %rax, t466
movq $2, t468
movq t466, %rax
cqto
idivq t468
movq %rax, t465
movq t465, %rsi
callq getnode
L122:
addq $0, %rsp
movq %rax, t464
movq t464, t344
movq t346, %rdi
movq t345, %rsi
movq t344, %rdx
callq insert
L123:
addq $0, %rsp
movq %rax, t469
movq t469, t138
movq tigermain_framesize(%rsp), t343
movq t139, t342
leaq tigermain_framesize(%rsp), %rdi
movq $6, t472
movq t472, %rax
imulq t117
movq %rax, t471
movq t471, %rsi
callq getnode
L124:
addq $0, %rsp
movq %rax, t470
movq t470, t341
movq t343, %rdi
movq t342, %rsi
movq t341, %rdx
callq insert
L125:
addq $0, %rsp
movq %rax, t473
movq t473, t139
movq $0, t474
movq t474, t141
L52:
movq $2, t476
movq t117, t475
subq t476, t475
cmpq t475, t141
jle L51
L50:
movq $0, t477
movq t477, t142
L55:
cmpq t118, t142
jle L54
L53:
leaq tigermain_framesize(%rsp), %rdi
movq t136, %rsi
callq printtree
L126:
addq $0, %rsp
movq %rax, t478
leaq L56(%rip), t480
movq t480, %rdi
callq print
L127:
addq $0, %rsp
movq %rax, t479
leaq tigermain_framesize(%rsp), %rdi
movq t137, %rsi
callq printtree
L128:
addq $0, %rsp
movq %rax, t481
leaq L57(%rip), t483
movq t483, %rdi
callq print
L129:
addq $0, %rsp
movq %rax, t482
leaq tigermain_framesize(%rsp), %rdi
movq t138, %rsi
callq printtree
L130:
addq $0, %rsp
movq %rax, t484
leaq L58(%rip), t486
movq t486, %rdi
callq print
L131:
addq $0, %rsp
movq %rax, t485
leaq tigermain_framesize(%rsp), %rdi
movq t139, %rsi
callq printtree
L132:
addq $0, %rsp
movq %rax, t487
leaq L59(%rip), t489
movq t489, %rdi
callq print
L133:
addq $0, %rsp
movq %rax, t488
movq $0, t490
movq t490, t143
L62:
movq $1, t492
movq t117, t491
subq t492, t491
cmpq t491, t143
jle L61
L60:
movq $0, t493
movq t493, t144
L65:
cmpq t118, t144
jle L64
L63:
leaq tigermain_framesize(%rsp), %rdi
movq t136, %rsi
callq printtree
L134:
addq $0, %rsp
movq %rax, t494
leaq L66(%rip), t496
movq t496, %rdi
callq print
L135:
addq $0, %rsp
movq %rax, t495
leaq tigermain_framesize(%rsp), %rdi
movq t137, %rsi
callq printtree
L136:
addq $0, %rsp
movq %rax, t497
leaq L67(%rip), t499
movq t499, %rdi
callq print
L137:
addq $0, %rsp
movq %rax, t498
movq t498, %rax
jmp L91
L51:
movq tigermain_framesize(%rsp), t340
movq t136, t339
leaq tigermain_framesize(%rsp), %rdi
movq t141, %rsi
callq getnode
L138:
addq $0, %rsp
movq %rax, t500
movq t500, t338
movq t340, %rdi
movq t339, %rsi
movq t338, %rdx
callq insert
L139:
addq $0, %rsp
movq %rax, t501
movq t501, t136
movq tigermain_framesize(%rsp), t337
movq t137, t336
leaq tigermain_framesize(%rsp), %rdi
movq $2, t504
movq t504, %rax
imulq t141
movq %rax, t503
movq t503, %rsi
callq getnode
L140:
addq $0, %rsp
movq %rax, t502
movq t502, t335
movq t337, %rdi
movq t336, %rsi
movq t335, %rdx
callq insert
L141:
addq $0, %rsp
movq %rax, t505
movq t505, t137
movq tigermain_framesize(%rsp), t334
movq t138, t333
leaq tigermain_framesize(%rsp), %rdi
movq $3, t508
movq t508, %rax
imulq t141
movq %rax, t507
movq t507, %rsi
callq getnode
L142:
addq $0, %rsp
movq %rax, t506
movq t506, t332
movq t334, %rdi
movq t333, %rsi
movq t332, %rdx
callq insert
L143:
addq $0, %rsp
movq %rax, t509
movq t509, t138
movq tigermain_framesize(%rsp), t331
movq t139, t330
leaq tigermain_framesize(%rsp), %rdi
movq $4, t512
movq t512, %rax
imulq t141
movq %rax, t511
movq t511, %rsi
callq getnode
L144:
addq $0, %rsp
movq %rax, t510
movq t510, t329
movq t331, %rdi
movq t330, %rsi
movq t329, %rdx
callq insert
L145:
addq $0, %rsp
movq %rax, t513
movq t513, t139
movq tigermain_framesize(%rsp), t328
movq t136, t327
leaq tigermain_framesize(%rsp), %rdi
movq t117, t515
addq t141, t515
movq t515, %rsi
callq getnode
L146:
addq $0, %rsp
movq %rax, t514
movq t514, t326
movq t328, %rdi
movq t327, %rsi
movq t326, %rdx
callq insert
L147:
addq $0, %rsp
movq %rax, t516
movq t516, t136
movq tigermain_framesize(%rsp), t325
movq t137, t324
leaq tigermain_framesize(%rsp), %rdi
movq $2, t519
movq t117, t520
addq t141, t520
movq t519, %rax
imulq t520
movq %rax, t518
movq t518, %rsi
callq getnode
L148:
addq $0, %rsp
movq %rax, t517
movq t517, t323
movq t325, %rdi
movq t324, %rsi
movq t323, %rdx
callq insert
L149:
addq $0, %rsp
movq %rax, t521
movq t521, t137
movq tigermain_framesize(%rsp), t322
movq t138, t321
leaq tigermain_framesize(%rsp), %rdi
movq $3, t524
movq t117, t525
addq t141, t525
movq t524, %rax
imulq t525
movq %rax, t523
movq t523, %rsi
callq getnode
L150:
addq $0, %rsp
movq %rax, t522
movq t522, t320
movq t322, %rdi
movq t321, %rsi
movq t320, %rdx
callq insert
L151:
addq $0, %rsp
movq %rax, t526
movq t526, t138
movq tigermain_framesize(%rsp), t319
movq t139, t318
leaq tigermain_framesize(%rsp), %rdi
movq $4, t529
movq t117, t530
addq t141, t530
movq t529, %rax
imulq t530
movq %rax, t528
movq t528, %rsi
callq getnode
L152:
addq $0, %rsp
movq %rax, t527
movq t527, t317
movq t319, %rdi
movq t318, %rsi
movq t317, %rdx
callq insert
L153:
addq $0, %rsp
movq %rax, t531
movq t531, t139
movq tigermain_framesize(%rsp), t316
movq t136, t315
leaq tigermain_framesize(%rsp), %rdi
movq t141, %rsi
callq getnode
L154:
addq $0, %rsp
movq %rax, t532
movq t532, t314
movq t316, %rdi
movq t315, %rsi
movq t314, %rdx
callq insert
L155:
addq $0, %rsp
movq %rax, t533
movq t533, t136
movq tigermain_framesize(%rsp), t313
movq t137, t312
leaq tigermain_framesize(%rsp), %rdi
movq $2, t536
movq t536, %rax
imulq t141
movq %rax, t535
movq t535, %rsi
callq getnode
L156:
addq $0, %rsp
movq %rax, t534
movq t534, t311
movq t313, %rdi
movq t312, %rsi
movq t311, %rdx
callq insert
L157:
addq $0, %rsp
movq %rax, t537
movq t537, t137
movq tigermain_framesize(%rsp), t310
movq t138, t309
leaq tigermain_framesize(%rsp), %rdi
movq $3, t540
movq t540, %rax
imulq t141
movq %rax, t539
movq t539, %rsi
callq getnode
L158:
addq $0, %rsp
movq %rax, t538
movq t538, t308
movq t310, %rdi
movq t309, %rsi
movq t308, %rdx
callq insert
L159:
addq $0, %rsp
movq %rax, t541
movq t541, t138
movq tigermain_framesize(%rsp), t307
movq t139, t306
leaq tigermain_framesize(%rsp), %rdi
movq $4, t544
movq t544, %rax
imulq t141
movq %rax, t543
movq t543, %rsi
callq getnode
L160:
addq $0, %rsp
movq %rax, t542
movq t542, t305
movq t307, %rdi
movq t306, %rsi
movq t305, %rdx
callq insert
L161:
addq $0, %rsp
movq %rax, t545
movq t545, t139
movq tigermain_framesize(%rsp), t304
movq t136, t303
leaq tigermain_framesize(%rsp), %rdi
movq t117, t547
addq t141, t547
movq t547, %rsi
callq getnode
L162:
addq $0, %rsp
movq %rax, t546
movq t546, t302
movq t304, %rdi
movq t303, %rsi
movq t302, %rdx
callq insert
L163:
addq $0, %rsp
movq %rax, t548
movq t548, t136
movq tigermain_framesize(%rsp), t301
movq t137, t300
leaq tigermain_framesize(%rsp), %rdi
movq $2, t551
movq t117, t552
addq t141, t552
movq t551, %rax
imulq t552
movq %rax, t550
movq t550, %rsi
callq getnode
L164:
addq $0, %rsp
movq %rax, t549
movq t549, t299
movq t301, %rdi
movq t300, %rsi
movq t299, %rdx
callq insert
L165:
addq $0, %rsp
movq %rax, t553
movq t553, t137
movq tigermain_framesize(%rsp), t298
movq t138, t297
leaq tigermain_framesize(%rsp), %rdi
movq $3, t556
movq t117, t557
addq t141, t557
movq t556, %rax
imulq t557
movq %rax, t555
movq t555, %rsi
callq getnode
L166:
addq $0, %rsp
movq %rax, t554
movq t554, t296
movq t298, %rdi
movq t297, %rsi
movq t296, %rdx
callq insert
L167:
addq $0, %rsp
movq %rax, t558
movq t558, t138
movq tigermain_framesize(%rsp), t295
movq t139, t294
leaq tigermain_framesize(%rsp), %rdi
movq $4, t561
movq t117, t562
addq t141, t562
movq t561, %rax
imulq t562
movq %rax, t560
movq t560, %rsi
callq getnode
L168:
addq $0, %rsp
movq %rax, t559
movq t559, t293
movq t295, %rdi
movq t294, %rsi
movq t293, %rdx
callq insert
L169:
addq $0, %rsp
movq %rax, t563
movq t563, t139
movq $1, t565
movq t141, t564
addq t565, t564
movq t564, t141
jmp L52
L54:
leaq tigermain_framesize(%rsp), %rdi
movq t142, %rsi
callq getnode
L170:
addq $0, %rsp
movq %rax, t566
movq t566, t140
movq $1, t568
movq t142, t567
addq t568, t567
movq t567, t142
jmp L55
L61:
movq tigermain_framesize(%rsp), t292
movq t136, t291
leaq tigermain_framesize(%rsp), %rdi
movq t143, %rsi
callq getnode
L171:
addq $0, %rsp
movq %rax, t569
movq t569, t290
movq t292, %rdi
movq t291, %rsi
movq t290, %rdx
callq insert
L172:
addq $0, %rsp
movq %rax, t570
movq t570, t136
movq tigermain_framesize(%rsp), t289
movq t137, t288
leaq tigermain_framesize(%rsp), %rdi
movq $2, t573
movq t573, %rax
imulq t143
movq %rax, t572
movq t572, %rsi
callq getnode
L173:
addq $0, %rsp
movq %rax, t571
movq t571, t287
movq t289, %rdi
movq t288, %rsi
movq t287, %rdx
callq insert
L174:
addq $0, %rsp
movq %rax, t574
movq t574, t137
movq tigermain_framesize(%rsp), t286
movq t136, t285
leaq tigermain_framesize(%rsp), %rdi
movq t117, t576
addq t143, t576
movq t576, %rsi
callq getnode
L175:
addq $0, %rsp
movq %rax, t575
movq t575, t284
movq t286, %rdi
movq t285, %rsi
movq t284, %rdx
callq insert
L176:
addq $0, %rsp
movq %rax, t577
movq t577, t136
movq tigermain_framesize(%rsp), t283
movq t137, t282
leaq tigermain_framesize(%rsp), %rdi
movq $2, t580
movq t117, t581
addq t143, t581
movq t580, %rax
imulq t581
movq %rax, t579
movq t579, %rsi
callq getnode
L177:
addq $0, %rsp
movq %rax, t578
movq t578, t281
movq t283, %rdi
movq t282, %rsi
movq t281, %rdx
callq insert
L178:
addq $0, %rsp
movq %rax, t582
movq t582, t137
movq tigermain_framesize(%rsp), t280
movq t136, t279
leaq tigermain_framesize(%rsp), %rdi
movq t143, %rsi
callq getnode
L179:
addq $0, %rsp
movq %rax, t583
movq t583, t278
movq t280, %rdi
movq t279, %rsi
movq t278, %rdx
callq insert
L180:
addq $0, %rsp
movq %rax, t584
movq t584, t136
movq tigermain_framesize(%rsp), t277
movq t137, t276
leaq tigermain_framesize(%rsp), %rdi
movq $2, t587
movq t587, %rax
imulq t143
movq %rax, t586
movq t586, %rsi
callq getnode
L181:
addq $0, %rsp
movq %rax, t585
movq t585, t275
movq t277, %rdi
movq t276, %rsi
movq t275, %rdx
callq insert
L182:
addq $0, %rsp
movq %rax, t588
movq t588, t137
movq tigermain_framesize(%rsp), t274
movq t136, t273
leaq tigermain_framesize(%rsp), %rdi
movq t117, t590
addq t143, t590
movq t590, %rsi
callq getnode
L183:
addq $0, %rsp
movq %rax, t589
movq t589, t272
movq t274, %rdi
movq t273, %rsi
movq t272, %rdx
callq insert
L184:
addq $0, %rsp
movq %rax, t591
movq t591, t136
movq tigermain_framesize(%rsp), t271
movq t137, t270
leaq tigermain_framesize(%rsp), %rdi
movq $2, t594
movq t117, t595
addq t143, t595
movq t594, %rax
imulq t595
movq %rax, t593
movq t593, %rsi
callq getnode
L185:
addq $0, %rsp
movq %rax, t592
movq t592, t269
movq t271, %rdi
movq t270, %rsi
movq t269, %rdx
callq insert
L186:
addq $0, %rsp
movq %rax, t596
movq t596, t137
movq $1, t598
movq t143, t597
addq t598, t597
movq t597, t143
jmp L62
L64:
leaq tigermain_framesize(%rsp), %rdi
movq t144, %rsi
callq getnode
L187:
addq $0, %rsp
movq %rax, t599
movq t599, t140
movq $1, t601
movq t144, t600
addq t601, t600
movq t600, t144
jmp L65
L91:
movq t389, %rbx
movq t390, %rbp
movq t391, %r12
movq t392, %r13
movq t393, %r14
movq t394, %r15


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
.quad -1
GC16:
.quad GC17
.quad L95
.quad tigermain_framesize
.quad -1
GC17:
.quad GC18
.quad L96
.quad tigermain_framesize
.quad -1
GC18:
.quad GC19
.quad L97
.quad tigermain_framesize
.quad -1
GC19:
.quad GC20
.quad L98
.quad tigermain_framesize
.quad -1
GC20:
.quad GC21
.quad L99
.quad tigermain_framesize
.quad -1
GC21:
.quad GC22
.quad L100
.quad tigermain_framesize
.quad -1
GC22:
.quad GC23
.quad L101
.quad tigermain_framesize
.quad -1
GC23:
.quad GC24
.quad L102
.quad tigermain_framesize
.quad -1
GC24:
.quad GC25
.quad L103
.quad tigermain_framesize
.quad -1
GC25:
.quad GC26
.quad L104
.quad tigermain_framesize
.quad -1
GC26:
.quad GC27
.quad L105
.quad tigermain_framesize
.quad -1
GC27:
.quad GC28
.quad L106
.quad tigermain_framesize
.quad -1
GC28:
.quad GC29
.quad L107
.quad tigermain_framesize
.quad -1
GC29:
.quad GC30
.quad L108
.quad tigermain_framesize
.quad -1
GC30:
.quad GC31
.quad L109
.quad tigermain_framesize
.quad -1
GC31:
.quad GC32
.quad L110
.quad tigermain_framesize
.quad -1
GC32:
.quad GC33
.quad L111
.quad tigermain_framesize
.quad -1
GC33:
.quad GC34
.quad L112
.quad tigermain_framesize
.quad -1
GC34:
.quad GC35
.quad L113
.quad tigermain_framesize
.quad -1
GC35:
.quad GC36
.quad L114
.quad tigermain_framesize
.quad -1
GC36:
.quad GC37
.quad L115
.quad tigermain_framesize
.quad -1
GC37:
.quad GC38
.quad L116
.quad tigermain_framesize
.quad -1
GC38:
.quad GC39
.quad L117
.quad tigermain_framesize
.quad -1
GC39:
.quad GC40
.quad L118
.quad tigermain_framesize
.quad -1
GC40:
.quad GC41
.quad L119
.quad tigermain_framesize
.quad -1
GC41:
.quad GC42
.quad L120
.quad tigermain_framesize
.quad -1
GC42:
.quad GC43
.quad L121
.quad tigermain_framesize
.quad -1
GC43:
.quad GC44
.quad L122
.quad tigermain_framesize
.quad -1
GC44:
.quad GC45
.quad L123
.quad tigermain_framesize
.quad -1
GC45:
.quad GC46
.quad L124
.quad tigermain_framesize
.quad -1
GC46:
.quad GC47
.quad L125
.quad tigermain_framesize
.quad -1
GC47:
.quad GC48
.quad L126
.quad tigermain_framesize
.quad -1
GC48:
.quad GC49
.quad L127
.quad tigermain_framesize
.quad -1
GC49:
.quad GC50
.quad L128
.quad tigermain_framesize
.quad -1
GC50:
.quad GC51
.quad L129
.quad tigermain_framesize
.quad -1
GC51:
.quad GC52
.quad L130
.quad tigermain_framesize
.quad -1
GC52:
.quad GC53
.quad L131
.quad tigermain_framesize
.quad -1
GC53:
.quad GC54
.quad L132
.quad tigermain_framesize
.quad -1
GC54:
.quad GC55
.quad L133
.quad tigermain_framesize
.quad -1
GC55:
.quad GC56
.quad L134
.quad tigermain_framesize
.quad -1
GC56:
.quad GC57
.quad L135
.quad tigermain_framesize
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
.quad -1
GC60:
.quad GC61
.quad L139
.quad tigermain_framesize
.quad -1
GC61:
.quad GC62
.quad L140
.quad tigermain_framesize
.quad -1
GC62:
.quad GC63
.quad L141
.quad tigermain_framesize
.quad -1
GC63:
.quad GC64
.quad L142
.quad tigermain_framesize
.quad -1
GC64:
.quad GC65
.quad L143
.quad tigermain_framesize
.quad -1
GC65:
.quad GC66
.quad L144
.quad tigermain_framesize
.quad -1
GC66:
.quad GC67
.quad L145
.quad tigermain_framesize
.quad -1
GC67:
.quad GC68
.quad L146
.quad tigermain_framesize
.quad -1
GC68:
.quad GC69
.quad L147
.quad tigermain_framesize
.quad -1
GC69:
.quad GC70
.quad L148
.quad tigermain_framesize
.quad -1
GC70:
.quad GC71
.quad L149
.quad tigermain_framesize
.quad -1
GC71:
.quad GC72
.quad L150
.quad tigermain_framesize
.quad -1
GC72:
.quad GC73
.quad L151
.quad tigermain_framesize
.quad -1
GC73:
.quad GC74
.quad L152
.quad tigermain_framesize
.quad -1
GC74:
.quad GC75
.quad L153
.quad tigermain_framesize
.quad -1
GC75:
.quad GC76
.quad L154
.quad tigermain_framesize
.quad -1
GC76:
.quad GC77
.quad L155
.quad tigermain_framesize
.quad -1
GC77:
.quad GC78
.quad L156
.quad tigermain_framesize
.quad -1
GC78:
.quad GC79
.quad L157
.quad tigermain_framesize
.quad -1
GC79:
.quad GC80
.quad L158
.quad tigermain_framesize
.quad -1
GC80:
.quad GC81
.quad L159
.quad tigermain_framesize
.quad -1
GC81:
.quad GC82
.quad L160
.quad tigermain_framesize
.quad -1
GC82:
.quad GC83
.quad L161
.quad tigermain_framesize
.quad -1
GC83:
.quad GC84
.quad L162
.quad tigermain_framesize
.quad -1
GC84:
.quad GC85
.quad L163
.quad tigermain_framesize
.quad -1
GC85:
.quad GC86
.quad L164
.quad tigermain_framesize
.quad -1
GC86:
.quad GC87
.quad L165
.quad tigermain_framesize
.quad -1
GC87:
.quad GC88
.quad L166
.quad tigermain_framesize
.quad -1
GC88:
.quad GC89
.quad L167
.quad tigermain_framesize
.quad -1
GC89:
.quad GC90
.quad L168
.quad tigermain_framesize
.quad -1
GC90:
.quad GC91
.quad L169
.quad tigermain_framesize
.quad -1
GC91:
.quad GC92
.quad L170
.quad tigermain_framesize
.quad -1
GC92:
.quad GC93
.quad L171
.quad tigermain_framesize
.quad -1
GC93:
.quad GC94
.quad L172
.quad tigermain_framesize
.quad -1
GC94:
.quad GC95
.quad L173
.quad tigermain_framesize
.quad -1
GC95:
.quad GC96
.quad L174
.quad tigermain_framesize
.quad -1
GC96:
.quad GC97
.quad L175
.quad tigermain_framesize
.quad -1
GC97:
.quad GC98
.quad L176
.quad tigermain_framesize
.quad -1
GC98:
.quad GC99
.quad L177
.quad tigermain_framesize
.quad -1
GC99:
.quad GC100
.quad L178
.quad tigermain_framesize
.quad -1
GC100:
.quad GC101
.quad L179
.quad tigermain_framesize
.quad -1
GC101:
.quad GC102
.quad L180
.quad tigermain_framesize
.quad -1
GC102:
.quad GC103
.quad L181
.quad tigermain_framesize
.quad -1
GC103:
.quad GC104
.quad L182
.quad tigermain_framesize
.quad -1
GC104:
.quad GC105
.quad L183
.quad tigermain_framesize
.quad -1
GC105:
.quad GC106
.quad L184
.quad tigermain_framesize
.quad -1
GC106:
.quad GC107
.quad L185
.quad tigermain_framesize
.quad -1
GC107:
.quad GC108
.quad L186
.quad tigermain_framesize
.quad -1
GC108:
.quad -1
.quad L187
.quad tigermain_framesize
.quad -1
