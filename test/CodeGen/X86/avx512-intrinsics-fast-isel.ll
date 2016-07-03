; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -fast-isel -mtriple=i386-unknown-unknown -mattr=+avx512f | FileCheck %s --check-prefix=ALL --check-prefix=X32
; RUN: llc < %s -fast-isel -mtriple=x86_64-unknown-unknown -mattr=+avx512f | FileCheck %s --check-prefix=ALL --check-prefix=X64

; NOTE: This should use IR equivalent to what is generated by clang/test/CodeGen/avx512f-builtins.c

define <8 x double> @test_mm512_movddup_pd(<8 x double> %a0) {
; X32-LABEL: test_mm512_movddup_pd:
; X32:       # BB#0:
; X32-NEXT:    vmovddup {{.*#+}} zmm0 = zmm0[0,0,2,2,4,4,6,6]
; X32-NEXT:    retl
;
; X64-LABEL: test_mm512_movddup_pd:
; X64:       # BB#0:
; X64-NEXT:    vmovddup {{.*#+}} zmm0 = zmm0[0,0,2,2,4,4,6,6]
; X64-NEXT:    retq
  %res = shufflevector <8 x double> %a0, <8 x double> undef, <8 x i32> <i32 0, i32 0, i32 2, i32 2, i32 4, i32 4, i32 6, i32 6>
  ret <8 x double> %res
}

define <8 x double> @test_mm512_mask_movddup_pd(<8 x double> %a0, i8 %a1, <8 x double> %a2) {
; X32-LABEL: test_mm512_mask_movddup_pd:
; X32:       # BB#0:
; X32-NEXT:    movb {{[0-9]+}}(%esp), %al
; X32-NEXT:    kmovw %eax, %k1
; X32-NEXT:    vmovddup {{.*#+}} zmm0 {%k1} = zmm1[0,0,2,2,4,4,6,6]
; X32-NEXT:    retl
;
; X64-LABEL: test_mm512_mask_movddup_pd:
; X64:       # BB#0:
; X64-NEXT:    kmovw %edi, %k1
; X64-NEXT:    vmovddup {{.*#+}} zmm0 {%k1} = zmm1[0,0,2,2,4,4,6,6]
; X64-NEXT:    retq
  %arg1 = bitcast i8 %a1 to <8 x i1>
  %res0 = shufflevector <8 x double> %a2, <8 x double> undef, <8 x i32> <i32 0, i32 0, i32 2, i32 2, i32 4, i32 4, i32 6, i32 6>
  %res1 = select <8 x i1> %arg1, <8 x double> %res0, <8 x double> %a0
  ret <8 x double> %res1
}

define <8 x double> @test_mm512_maskz_movddup_pd(i8 %a0, <8 x double> %a1) {
; X32-LABEL: test_mm512_maskz_movddup_pd:
; X32:       # BB#0:
; X32-NEXT:    movb {{[0-9]+}}(%esp), %al
; X32-NEXT:    kmovw %eax, %k1
; X32-NEXT:    vmovddup {{.*#+}} zmm0 {%k1} {z} = zmm0[0,0,2,2,4,4,6,6]
; X32-NEXT:    retl
;
; X64-LABEL: test_mm512_maskz_movddup_pd:
; X64:       # BB#0:
; X64-NEXT:    kmovw %edi, %k1
; X64-NEXT:    vmovddup {{.*#+}} zmm0 {%k1} {z} = zmm0[0,0,2,2,4,4,6,6]
; X64-NEXT:    retq
  %arg0 = bitcast i8 %a0 to <8 x i1>
  %res0 = shufflevector <8 x double> %a1, <8 x double> undef, <8 x i32> <i32 0, i32 0, i32 2, i32 2, i32 4, i32 4, i32 6, i32 6>
  %res1 = select <8 x i1> %arg0, <8 x double> %res0, <8 x double> zeroinitializer
  ret <8 x double> %res1
}

define <16 x float> @test_mm512_movehdup_ps(<16 x float> %a0) {
; X32-LABEL: test_mm512_movehdup_ps:
; X32:       # BB#0:
; X32-NEXT:    vmovshdup {{.*#+}} zmm0 = zmm0[1,1,3,3,5,5,7,7,9,9,11,11,13,13,15,15]
; X32-NEXT:    retl
;
; X64-LABEL: test_mm512_movehdup_ps:
; X64:       # BB#0:
; X64-NEXT:    vmovshdup {{.*#+}} zmm0 = zmm0[1,1,3,3,5,5,7,7,9,9,11,11,13,13,15,15]
; X64-NEXT:    retq
  %res = shufflevector <16 x float> %a0, <16 x float> undef, <16 x i32> <i32 1, i32 1, i32 3, i32 3, i32 5, i32 5, i32 7, i32 7, i32 9, i32 9, i32 11, i32 11, i32 13, i32 13, i32 15, i32 15>
  ret <16 x float> %res
}

define <16 x float> @test_mm512_mask_movehdup_ps(<16 x float> %a0, i16 %a1, <16 x float> %a2) {
; X32-LABEL: test_mm512_mask_movehdup_ps:
; X32:       # BB#0:
; X32-NEXT:    movw {{[0-9]+}}(%esp), %ax
; X32-NEXT:    kmovw %eax, %k1
; X32-NEXT:    vmovshdup {{.*#+}} zmm0 {%k1} = zmm1[1,1,3,3,5,5,7,7,9,9,11,11,13,13,15,15]
; X32-NEXT:    retl
;
; X64-LABEL: test_mm512_mask_movehdup_ps:
; X64:       # BB#0:
; X64-NEXT:    kmovw %edi, %k1
; X64-NEXT:    vmovshdup {{.*#+}} zmm0 {%k1} = zmm1[1,1,3,3,5,5,7,7,9,9,11,11,13,13,15,15]
; X64-NEXT:    retq
  %arg1 = bitcast i16 %a1 to <16 x i1>
  %res0 = shufflevector <16 x float> %a2, <16 x float> undef, <16 x i32> <i32 1, i32 1, i32 3, i32 3, i32 5, i32 5, i32 7, i32 7, i32 9, i32 9, i32 11, i32 11, i32 13, i32 13, i32 15, i32 15>
  %res1 = select <16 x i1> %arg1, <16 x float> %res0, <16 x float> %a0
  ret <16 x float> %res1
}

define <16 x float> @test_mm512_maskz_movehdup_ps(i16 %a0, <16 x float> %a1) {
; X32-LABEL: test_mm512_maskz_movehdup_ps:
; X32:       # BB#0:
; X32-NEXT:    movw {{[0-9]+}}(%esp), %ax
; X32-NEXT:    kmovw %eax, %k1
; X32-NEXT:    vmovshdup {{.*#+}} zmm0 {%k1} {z} = zmm0[1,1,3,3,5,5,7,7,9,9,11,11,13,13,15,15]
; X32-NEXT:    retl
;
; X64-LABEL: test_mm512_maskz_movehdup_ps:
; X64:       # BB#0:
; X64-NEXT:    kmovw %edi, %k1
; X64-NEXT:    vmovshdup {{.*#+}} zmm0 {%k1} {z} = zmm0[1,1,3,3,5,5,7,7,9,9,11,11,13,13,15,15]
; X64-NEXT:    retq
  %arg0 = bitcast i16 %a0 to <16 x i1>
  %res0 = shufflevector <16 x float> %a1, <16 x float> undef, <16 x i32> <i32 1, i32 1, i32 3, i32 3, i32 5, i32 5, i32 7, i32 7, i32 9, i32 9, i32 11, i32 11, i32 13, i32 13, i32 15, i32 15>
  %res1 = select <16 x i1> %arg0, <16 x float> %res0, <16 x float> zeroinitializer
  ret <16 x float> %res1
}

define <16 x float> @test_mm512_moveldup_ps(<16 x float> %a0) {
; X32-LABEL: test_mm512_moveldup_ps:
; X32:       # BB#0:
; X32-NEXT:    vmovsldup {{.*#+}} zmm0 = zmm0[0,0,2,2,4,4,6,6,8,8,10,10,12,12,14,14]
; X32-NEXT:    retl
;
; X64-LABEL: test_mm512_moveldup_ps:
; X64:       # BB#0:
; X64-NEXT:    vmovsldup {{.*#+}} zmm0 = zmm0[0,0,2,2,4,4,6,6,8,8,10,10,12,12,14,14]
; X64-NEXT:    retq
  %res = shufflevector <16 x float> %a0, <16 x float> undef, <16 x i32> <i32 0, i32 0, i32 2, i32 2, i32 4, i32 4, i32 6, i32 6, i32 8, i32 8, i32 10, i32 10, i32 12, i32 12, i32 14, i32 14>
  ret <16 x float> %res
}

define <16 x float> @test_mm512_mask_moveldup_ps(<16 x float> %a0, i16 %a1, <16 x float> %a2) {
; X32-LABEL: test_mm512_mask_moveldup_ps:
; X32:       # BB#0:
; X32-NEXT:    movw {{[0-9]+}}(%esp), %ax
; X32-NEXT:    kmovw %eax, %k1
; X32-NEXT:    vmovsldup {{.*#+}} zmm0 {%k1} = zmm1[0,0,2,2,4,4,6,6,8,8,10,10,12,12,14,14]
; X32-NEXT:    retl
;
; X64-LABEL: test_mm512_mask_moveldup_ps:
; X64:       # BB#0:
; X64-NEXT:    kmovw %edi, %k1
; X64-NEXT:    vmovsldup {{.*#+}} zmm0 {%k1} = zmm1[0,0,2,2,4,4,6,6,8,8,10,10,12,12,14,14]
; X64-NEXT:    retq
  %arg1 = bitcast i16 %a1 to <16 x i1>
  %res0 = shufflevector <16 x float> %a2, <16 x float> undef, <16 x i32> <i32 0, i32 0, i32 2, i32 2, i32 4, i32 4, i32 6, i32 6, i32 8, i32 8, i32 10, i32 10, i32 12, i32 12, i32 14, i32 14>
  %res1 = select <16 x i1> %arg1, <16 x float> %res0, <16 x float> %a0
  ret <16 x float> %res1
}

define <16 x float> @test_mm512_maskz_moveldup_ps(i16 %a0, <16 x float> %a1) {
; X32-LABEL: test_mm512_maskz_moveldup_ps:
; X32:       # BB#0:
; X32-NEXT:    movw {{[0-9]+}}(%esp), %ax
; X32-NEXT:    kmovw %eax, %k1
; X32-NEXT:    vmovsldup {{.*#+}} zmm0 {%k1} {z} = zmm0[0,0,2,2,4,4,6,6,8,8,10,10,12,12,14,14]
; X32-NEXT:    retl
;
; X64-LABEL: test_mm512_maskz_moveldup_ps:
; X64:       # BB#0:
; X64-NEXT:    kmovw %edi, %k1
; X64-NEXT:    vmovsldup {{.*#+}} zmm0 {%k1} {z} = zmm0[0,0,2,2,4,4,6,6,8,8,10,10,12,12,14,14]
; X64-NEXT:    retq
  %arg0 = bitcast i16 %a0 to <16 x i1>
  %res0 = shufflevector <16 x float> %a1, <16 x float> undef, <16 x i32> <i32 0, i32 0, i32 2, i32 2, i32 4, i32 4, i32 6, i32 6, i32 8, i32 8, i32 10, i32 10, i32 12, i32 12, i32 14, i32 14>
  %res1 = select <16 x i1> %arg0, <16 x float> %res0, <16 x float> zeroinitializer
  ret <16 x float> %res1
}

define <8 x i64> @test_mm512_unpackhi_epi32(<8 x i64> %a0, <8 x i64> %a1) {
; X32-LABEL: test_mm512_unpackhi_epi32:
; X32:       # BB#0:
; X32-NEXT:    vpunpckhdq {{.*#+}} zmm0 = zmm0[2],zmm1[2],zmm0[3],zmm1[3],zmm0[6],zmm1[6],zmm0[7],zmm1[7],zmm0[10],zmm1[10],zmm0[11],zmm1[11],zmm0[14],zmm1[14],zmm0[15],zmm1[15]
; X32-NEXT:    retl
;
; X64-LABEL: test_mm512_unpackhi_epi32:
; X64:       # BB#0:
; X64-NEXT:    vpunpckhdq {{.*#+}} zmm0 = zmm0[2],zmm1[2],zmm0[3],zmm1[3],zmm0[6],zmm1[6],zmm0[7],zmm1[7],zmm0[10],zmm1[10],zmm0[11],zmm1[11],zmm0[14],zmm1[14],zmm0[15],zmm1[15]
; X64-NEXT:    retq
  %arg0 = bitcast <8 x i64> %a0 to <16 x i32>
  %arg1 = bitcast <8 x i64> %a1 to <16 x i32>
  %res0 = shufflevector <16 x i32> %arg0, <16 x i32> %arg1, <16 x i32> <i32 2, i32 18, i32 3, i32 19, i32 6, i32 22, i32 7, i32 23, i32 10, i32 26, i32 11, i32 27, i32 14, i32 30, i32 15, i32 31>
  %res1 = bitcast <16 x i32> %res0 to <8 x i64>
  ret <8 x i64> %res1
}

define <8 x i64> @test_mm512_mask_unpackhi_epi32(<8 x i64> %a0, i16 %a1, <8 x i64> %a2, <8 x i64> %a3) {
; X32-LABEL: test_mm512_mask_unpackhi_epi32:
; X32:       # BB#0:
; X32-NEXT:    movw {{[0-9]+}}(%esp), %ax
; X32-NEXT:    kmovw %eax, %k1
; X32-NEXT:    vpunpckhdq {{.*#+}} zmm0 {%k1} = zmm1[2],zmm2[2],zmm1[3],zmm2[3],zmm1[6],zmm2[6],zmm1[7],zmm2[7],zmm1[10],zmm2[10],zmm1[11],zmm2[11],zmm1[14],zmm2[14],zmm1[15],zmm2[15]
; X32-NEXT:    retl
;
; X64-LABEL: test_mm512_mask_unpackhi_epi32:
; X64:       # BB#0:
; X64-NEXT:    kmovw %edi, %k1
; X64-NEXT:    vpunpckhdq {{.*#+}} zmm0 {%k1} = zmm1[2],zmm2[2],zmm1[3],zmm2[3],zmm1[6],zmm2[6],zmm1[7],zmm2[7],zmm1[10],zmm2[10],zmm1[11],zmm2[11],zmm1[14],zmm2[14],zmm1[15],zmm2[15]
; X64-NEXT:    retq
  %arg0 = bitcast <8 x i64> %a0 to <16 x i32>
  %arg1 = bitcast i16 %a1 to <16 x i1>
  %arg2 = bitcast <8 x i64> %a2 to <16 x i32>
  %arg3 = bitcast <8 x i64> %a3 to <16 x i32>
  %res0 = shufflevector <16 x i32> %arg2, <16 x i32> %arg3, <16 x i32> <i32 2, i32 18, i32 3, i32 19, i32 6, i32 22, i32 7, i32 23, i32 10, i32 26, i32 11, i32 27, i32 14, i32 30, i32 15, i32 31>
  %res1 = select <16 x i1> %arg1, <16 x i32> %res0, <16 x i32> %arg0
  %res2 = bitcast <16 x i32> %res1 to <8 x i64>
  ret <8 x i64> %res2
}

define <8 x i64> @test_mm512_maskz_unpackhi_epi32(i16 %a0, <8 x i64> %a1, <8 x i64> %a2) {
; X32-LABEL: test_mm512_maskz_unpackhi_epi32:
; X32:       # BB#0:
; X32-NEXT:    movw {{[0-9]+}}(%esp), %ax
; X32-NEXT:    kmovw %eax, %k1
; X32-NEXT:    vpunpckhdq {{.*#+}} zmm0 {%k1} {z} = zmm0[2],zmm1[2],zmm0[3],zmm1[3],zmm0[6],zmm1[6],zmm0[7],zmm1[7],zmm0[10],zmm1[10],zmm0[11],zmm1[11],zmm0[14],zmm1[14],zmm0[15],zmm1[15]
; X32-NEXT:    retl
;
; X64-LABEL: test_mm512_maskz_unpackhi_epi32:
; X64:       # BB#0:
; X64-NEXT:    kmovw %edi, %k1
; X64-NEXT:    vpunpckhdq {{.*#+}} zmm0 {%k1} {z} = zmm0[2],zmm1[2],zmm0[3],zmm1[3],zmm0[6],zmm1[6],zmm0[7],zmm1[7],zmm0[10],zmm1[10],zmm0[11],zmm1[11],zmm0[14],zmm1[14],zmm0[15],zmm1[15]
; X64-NEXT:    retq
  %arg0 = bitcast i16 %a0 to <16 x i1>
  %arg1 = bitcast <8 x i64> %a1 to <16 x i32>
  %arg2 = bitcast <8 x i64> %a2 to <16 x i32>
  %res0 = shufflevector <16 x i32> %arg1, <16 x i32> %arg2, <16 x i32> <i32 2, i32 18, i32 3, i32 19, i32 6, i32 22, i32 7, i32 23, i32 10, i32 26, i32 11, i32 27, i32 14, i32 30, i32 15, i32 31>
  %res1 = select <16 x i1> %arg0, <16 x i32> %res0, <16 x i32> zeroinitializer
  %res2 = bitcast <16 x i32> %res1 to <8 x i64>
  ret <8 x i64> %res2
}

define <8 x i64> @test_mm512_unpackhi_epi64(<8 x i64> %a0, <8 x i64> %a1) {
; X32-LABEL: test_mm512_unpackhi_epi64:
; X32:       # BB#0:
; X32-NEXT:    vpunpckhqdq {{.*#+}} zmm0 = zmm0[1],zmm1[1],zmm0[3],zmm1[3],zmm0[5],zmm1[5],zmm0[7],zmm1[7]
; X32-NEXT:    retl
;
; X64-LABEL: test_mm512_unpackhi_epi64:
; X64:       # BB#0:
; X64-NEXT:    vpunpckhqdq {{.*#+}} zmm0 = zmm0[1],zmm1[1],zmm0[3],zmm1[3],zmm0[5],zmm1[5],zmm0[7],zmm1[7]
; X64-NEXT:    retq
  %res = shufflevector <8 x i64> %a0, <8 x i64> %a1, <8 x i32> <i32 1, i32 9, i32 3, i32 11, i32 5, i32 13, i32 7, i32 15>
  ret <8 x i64> %res
}

define <8 x i64> @test_mm512_mask_unpackhi_epi64(<8 x i64> %a0, i8 %a1, <8 x i64> %a2, <8 x i64> %a3) {
; X32-LABEL: test_mm512_mask_unpackhi_epi64:
; X32:       # BB#0:
; X32-NEXT:    movb {{[0-9]+}}(%esp), %al
; X32-NEXT:    kmovw %eax, %k1
; X32-NEXT:    vpunpckhqdq {{.*#+}} zmm0 = zmm1[1],zmm2[1],zmm1[3],zmm2[3],zmm1[5],zmm2[5],zmm1[7],zmm2[7]
; X32-NEXT:    retl
;
; X64-LABEL: test_mm512_mask_unpackhi_epi64:
; X64:       # BB#0:
; X64-NEXT:    kmovw %edi, %k1
; X64-NEXT:    vpunpckhqdq {{.*#+}} zmm0 = zmm1[1],zmm2[1],zmm1[3],zmm2[3],zmm1[5],zmm2[5],zmm1[7],zmm2[7]
; X64-NEXT:    retq
  %arg1 = bitcast i8 %a1 to <8 x i1>
  %res0 = shufflevector <8 x i64> %a2, <8 x i64> %a3, <8 x i32> <i32 1, i32 9, i32 3, i32 11, i32 5, i32 13, i32 7, i32 15>
  %res1 = select <8 x i1> %arg1, <8 x i64> %res0, <8 x i64> %a0
  ret <8 x i64> %res1
}

define <8 x i64> @test_mm512_maskz_unpackhi_epi64(i8 %a0, <8 x i64> %a1, <8 x i64> %a2) {
; X32-LABEL: test_mm512_maskz_unpackhi_epi64:
; X32:       # BB#0:
; X32-NEXT:    movb {{[0-9]+}}(%esp), %al
; X32-NEXT:    kmovw %eax, %k1
; X32-NEXT:    vpunpckhqdq {{.*#+}} zmm0 = zmm0[1],zmm1[1],zmm0[3],zmm1[3],zmm0[5],zmm1[5],zmm0[7],zmm1[7]
; X32-NEXT:    retl
;
; X64-LABEL: test_mm512_maskz_unpackhi_epi64:
; X64:       # BB#0:
; X64-NEXT:    kmovw %edi, %k1
; X64-NEXT:    vpunpckhqdq {{.*#+}} zmm0 = zmm0[1],zmm1[1],zmm0[3],zmm1[3],zmm0[5],zmm1[5],zmm0[7],zmm1[7]
; X64-NEXT:    retq
  %arg0 = bitcast i8 %a0 to <8 x i1>
  %res0 = shufflevector <8 x i64> %a1, <8 x i64> %a2, <8 x i32> <i32 1, i32 9, i32 3, i32 11, i32 5, i32 13, i32 7, i32 15>
  %res1 = select <8 x i1> %arg0, <8 x i64> %res0, <8 x i64> zeroinitializer
  ret <8 x i64> %res1
}

define <8 x double> @test_mm512_unpackhi_pd(<8 x double> %a0, <8 x double> %a1) {
; X32-LABEL: test_mm512_unpackhi_pd:
; X32:       # BB#0:
; X32-NEXT:    vunpckhpd {{.*#+}} zmm0 = zmm0[1],zmm1[1],zmm0[3],zmm1[3],zmm0[5],zmm1[5],zmm0[7],zmm1[7]
; X32-NEXT:    retl
;
; X64-LABEL: test_mm512_unpackhi_pd:
; X64:       # BB#0:
; X64-NEXT:    vunpckhpd {{.*#+}} zmm0 = zmm0[1],zmm1[1],zmm0[3],zmm1[3],zmm0[5],zmm1[5],zmm0[7],zmm1[7]
; X64-NEXT:    retq
  %res = shufflevector <8 x double> %a0, <8 x double> %a1, <8 x i32> <i32 1, i32 9, i32 3, i32 11, i32 5, i32 13, i32 7, i32 15>
  ret <8 x double> %res
}

define <8 x double> @test_mm512_mask_unpackhi_pd(<8 x double> %a0, i8 %a1, <8 x double> %a2, <8 x double> %a3) {
; X32-LABEL: test_mm512_mask_unpackhi_pd:
; X32:       # BB#0:
; X32-NEXT:    movb {{[0-9]+}}(%esp), %al
; X32-NEXT:    kmovw %eax, %k1
; X32-NEXT:    vunpckhpd {{.*#+}} zmm0 {%k1} = zmm1[1],zmm2[1],zmm1[3],zmm2[3],zmm1[5],zmm2[5],zmm1[7],zmm2[7]
; X32-NEXT:    retl
;
; X64-LABEL: test_mm512_mask_unpackhi_pd:
; X64:       # BB#0:
; X64-NEXT:    kmovw %edi, %k1
; X64-NEXT:    vunpckhpd {{.*#+}} zmm0 {%k1} = zmm1[1],zmm2[1],zmm1[3],zmm2[3],zmm1[5],zmm2[5],zmm1[7],zmm2[7]
; X64-NEXT:    retq
  %arg1 = bitcast i8 %a1 to <8 x i1>
  %res0 = shufflevector <8 x double> %a2, <8 x double> %a3, <8 x i32> <i32 1, i32 9, i32 3, i32 11, i32 5, i32 13, i32 7, i32 15>
  %res1 = select <8 x i1> %arg1, <8 x double> %res0, <8 x double> %a0
  ret <8 x double> %res1
}

define <8 x double> @test_mm512_maskz_unpackhi_pd(i8 %a0, <8 x double> %a1, <8 x double> %a2) {
; X32-LABEL: test_mm512_maskz_unpackhi_pd:
; X32:       # BB#0:
; X32-NEXT:    movb {{[0-9]+}}(%esp), %al
; X32-NEXT:    kmovw %eax, %k1
; X32-NEXT:    vunpckhpd {{.*#+}} zmm0 {%k1} {z} = zmm0[1],zmm1[1],zmm0[3],zmm1[3],zmm0[5],zmm1[5],zmm0[7],zmm1[7]
; X32-NEXT:    retl
;
; X64-LABEL: test_mm512_maskz_unpackhi_pd:
; X64:       # BB#0:
; X64-NEXT:    kmovw %edi, %k1
; X64-NEXT:    vunpckhpd {{.*#+}} zmm0 {%k1} {z} = zmm0[1],zmm1[1],zmm0[3],zmm1[3],zmm0[5],zmm1[5],zmm0[7],zmm1[7]
; X64-NEXT:    retq
  %arg0 = bitcast i8 %a0 to <8 x i1>
  %res0 = shufflevector <8 x double> %a1, <8 x double> %a2, <8 x i32> <i32 1, i32 9, i32 3, i32 11, i32 5, i32 13, i32 7, i32 15>
  %res1 = select <8 x i1> %arg0, <8 x double> %res0, <8 x double> zeroinitializer
  ret <8 x double> %res1
}

define <16 x float> @test_mm512_unpackhi_ps(<16 x float> %a0, <16 x float> %a1) {
; X32-LABEL: test_mm512_unpackhi_ps:
; X32:       # BB#0:
; X32-NEXT:    vunpckhps {{.*#+}} zmm0 = zmm0[2],zmm1[2],zmm0[3],zmm1[3],zmm0[6],zmm1[6],zmm0[7],zmm1[7],zmm0[10],zmm1[10],zmm0[11],zmm1[11],zmm0[14],zmm1[14],zmm0[15],zmm1[15]
; X32-NEXT:    retl
;
; X64-LABEL: test_mm512_unpackhi_ps:
; X64:       # BB#0:
; X64-NEXT:    vunpckhps {{.*#+}} zmm0 = zmm0[2],zmm1[2],zmm0[3],zmm1[3],zmm0[6],zmm1[6],zmm0[7],zmm1[7],zmm0[10],zmm1[10],zmm0[11],zmm1[11],zmm0[14],zmm1[14],zmm0[15],zmm1[15]
; X64-NEXT:    retq
  %res = shufflevector <16 x float> %a0, <16 x float> %a1, <16 x i32> <i32 2, i32 18, i32 3, i32 19, i32 6, i32 22, i32 7, i32 23, i32 10, i32 26, i32 11, i32 27, i32 14, i32 30, i32 15, i32 31>
  ret <16 x float> %res
}

define <16 x float> @test_mm512_mask_unpackhi_ps(<16 x float> %a0, i16 %a1, <16 x float> %a2, <16 x float> %a3) {
; X32-LABEL: test_mm512_mask_unpackhi_ps:
; X32:       # BB#0:
; X32-NEXT:    movw {{[0-9]+}}(%esp), %ax
; X32-NEXT:    kmovw %eax, %k1
; X32-NEXT:    vunpckhps {{.*#+}} zmm0 {%k1} = zmm1[2],zmm2[2],zmm1[3],zmm2[3],zmm1[6],zmm2[6],zmm1[7],zmm2[7],zmm1[10],zmm2[10],zmm1[11],zmm2[11],zmm1[14],zmm2[14],zmm1[15],zmm2[15]
; X32-NEXT:    retl
;
; X64-LABEL: test_mm512_mask_unpackhi_ps:
; X64:       # BB#0:
; X64-NEXT:    kmovw %edi, %k1
; X64-NEXT:    vunpckhps {{.*#+}} zmm0 {%k1} = zmm1[2],zmm2[2],zmm1[3],zmm2[3],zmm1[6],zmm2[6],zmm1[7],zmm2[7],zmm1[10],zmm2[10],zmm1[11],zmm2[11],zmm1[14],zmm2[14],zmm1[15],zmm2[15]
; X64-NEXT:    retq
  %arg1 = bitcast i16 %a1 to <16 x i1>
  %res0 = shufflevector <16 x float> %a2, <16 x float> %a3, <16 x i32> <i32 2, i32 18, i32 3, i32 19, i32 6, i32 22, i32 7, i32 23, i32 10, i32 26, i32 11, i32 27, i32 14, i32 30, i32 15, i32 31>
  %res1 = select <16 x i1> %arg1, <16 x float> %res0, <16 x float> %a0
  ret <16 x float> %res1
}

define <16 x float> @test_mm512_maskz_unpackhi_ps(i16 %a0, <16 x float> %a1, <16 x float> %a2) {
; X32-LABEL: test_mm512_maskz_unpackhi_ps:
; X32:       # BB#0:
; X32-NEXT:    movw {{[0-9]+}}(%esp), %ax
; X32-NEXT:    kmovw %eax, %k1
; X32-NEXT:    vunpckhps {{.*#+}} zmm0 {%k1} {z} = zmm0[2],zmm1[2],zmm0[3],zmm1[3],zmm0[6],zmm1[6],zmm0[7],zmm1[7],zmm0[10],zmm1[10],zmm0[11],zmm1[11],zmm0[14],zmm1[14],zmm0[15],zmm1[15]
; X32-NEXT:    retl
;
; X64-LABEL: test_mm512_maskz_unpackhi_ps:
; X64:       # BB#0:
; X64-NEXT:    kmovw %edi, %k1
; X64-NEXT:    vunpckhps {{.*#+}} zmm0 {%k1} {z} = zmm0[2],zmm1[2],zmm0[3],zmm1[3],zmm0[6],zmm1[6],zmm0[7],zmm1[7],zmm0[10],zmm1[10],zmm0[11],zmm1[11],zmm0[14],zmm1[14],zmm0[15],zmm1[15]
; X64-NEXT:    retq
  %arg0 = bitcast i16 %a0 to <16 x i1>
  %res0 = shufflevector <16 x float> %a1, <16 x float> %a2, <16 x i32> <i32 2, i32 18, i32 3, i32 19, i32 6, i32 22, i32 7, i32 23, i32 10, i32 26, i32 11, i32 27, i32 14, i32 30, i32 15, i32 31>
  %res1 = select <16 x i1> %arg0, <16 x float> %res0, <16 x float> zeroinitializer
  ret <16 x float> %res1
}

define <8 x i64> @test_mm512_unpacklo_epi32(<8 x i64> %a0, <8 x i64> %a1) {
; X32-LABEL: test_mm512_unpacklo_epi32:
; X32:       # BB#0:
; X32-NEXT:    vpunpckldq {{.*#+}} zmm0 = zmm0[0],zmm1[0],zmm0[1],zmm1[1],zmm0[4],zmm1[4],zmm0[5],zmm1[5],zmm0[8],zmm1[8],zmm0[9],zmm1[9],zmm0[12],zmm1[12],zmm0[13],zmm1[13]
; X32-NEXT:    retl
;
; X64-LABEL: test_mm512_unpacklo_epi32:
; X64:       # BB#0:
; X64-NEXT:    vpunpckldq {{.*#+}} zmm0 = zmm0[0],zmm1[0],zmm0[1],zmm1[1],zmm0[4],zmm1[4],zmm0[5],zmm1[5],zmm0[8],zmm1[8],zmm0[9],zmm1[9],zmm0[12],zmm1[12],zmm0[13],zmm1[13]
; X64-NEXT:    retq
  %arg0 = bitcast <8 x i64> %a0 to <16 x i32>
  %arg1 = bitcast <8 x i64> %a1 to <16 x i32>
  %res0 = shufflevector <16 x i32> %arg0, <16 x i32> %arg1, <16 x i32> <i32 0, i32 16, i32 1, i32 17, i32 4, i32 20, i32 5, i32 21, i32 8, i32 24, i32 9, i32 25, i32 12, i32 28, i32 13, i32 29>
  %res1 = bitcast <16 x i32> %res0 to <8 x i64>
  ret <8 x i64> %res1
}

define <8 x i64> @test_mm512_mask_unpacklo_epi32(<8 x i64> %a0, i16 %a1, <8 x i64> %a2, <8 x i64> %a3) {
; X32-LABEL: test_mm512_mask_unpacklo_epi32:
; X32:       # BB#0:
; X32-NEXT:    movw {{[0-9]+}}(%esp), %ax
; X32-NEXT:    kmovw %eax, %k1
; X32-NEXT:    vpunpckldq {{.*#+}} zmm0 {%k1} = zmm1[0],zmm2[0],zmm1[1],zmm2[1],zmm1[4],zmm2[4],zmm1[5],zmm2[5],zmm1[8],zmm2[8],zmm1[9],zmm2[9],zmm1[12],zmm2[12],zmm1[13],zmm2[13]
; X32-NEXT:    retl
;
; X64-LABEL: test_mm512_mask_unpacklo_epi32:
; X64:       # BB#0:
; X64-NEXT:    kmovw %edi, %k1
; X64-NEXT:    vpunpckldq {{.*#+}} zmm0 {%k1} = zmm1[0],zmm2[0],zmm1[1],zmm2[1],zmm1[4],zmm2[4],zmm1[5],zmm2[5],zmm1[8],zmm2[8],zmm1[9],zmm2[9],zmm1[12],zmm2[12],zmm1[13],zmm2[13]
; X64-NEXT:    retq
  %arg0 = bitcast <8 x i64> %a0 to <16 x i32>
  %arg1 = bitcast i16 %a1 to <16 x i1>
  %arg2 = bitcast <8 x i64> %a2 to <16 x i32>
  %arg3 = bitcast <8 x i64> %a3 to <16 x i32>
  %res0 = shufflevector <16 x i32> %arg2, <16 x i32> %arg3, <16 x i32> <i32 0, i32 16, i32 1, i32 17, i32 4, i32 20, i32 5, i32 21, i32 8, i32 24, i32 9, i32 25, i32 12, i32 28, i32 13, i32 29>
  %res1 = select <16 x i1> %arg1, <16 x i32> %res0, <16 x i32> %arg0
  %res2 = bitcast <16 x i32> %res1 to <8 x i64>
  ret <8 x i64> %res2
}

define <8 x i64> @test_mm512_maskz_unpacklo_epi32(i16 %a0, <8 x i64> %a1, <8 x i64> %a2) {
; X32-LABEL: test_mm512_maskz_unpacklo_epi32:
; X32:       # BB#0:
; X32-NEXT:    movw {{[0-9]+}}(%esp), %ax
; X32-NEXT:    kmovw %eax, %k1
; X32-NEXT:    vpunpckldq {{.*#+}} zmm0 {%k1} {z} = zmm0[0],zmm1[0],zmm0[1],zmm1[1],zmm0[4],zmm1[4],zmm0[5],zmm1[5],zmm0[8],zmm1[8],zmm0[9],zmm1[9],zmm0[12],zmm1[12],zmm0[13],zmm1[13]
; X32-NEXT:    retl
;
; X64-LABEL: test_mm512_maskz_unpacklo_epi32:
; X64:       # BB#0:
; X64-NEXT:    kmovw %edi, %k1
; X64-NEXT:    vpunpckldq {{.*#+}} zmm0 {%k1} {z} = zmm0[0],zmm1[0],zmm0[1],zmm1[1],zmm0[4],zmm1[4],zmm0[5],zmm1[5],zmm0[8],zmm1[8],zmm0[9],zmm1[9],zmm0[12],zmm1[12],zmm0[13],zmm1[13]
; X64-NEXT:    retq
  %arg0 = bitcast i16 %a0 to <16 x i1>
  %arg1 = bitcast <8 x i64> %a1 to <16 x i32>
  %arg2 = bitcast <8 x i64> %a2 to <16 x i32>
  %res0 = shufflevector <16 x i32> %arg1, <16 x i32> %arg2, <16 x i32> <i32 0, i32 16, i32 1, i32 17, i32 4, i32 20, i32 5, i32 21, i32 8, i32 24, i32 9, i32 25, i32 12, i32 28, i32 13, i32 29>
  %res1 = select <16 x i1> %arg0, <16 x i32> %res0, <16 x i32> zeroinitializer
  %res2 = bitcast <16 x i32> %res1 to <8 x i64>
  ret <8 x i64> %res2
}

define <8 x i64> @test_mm512_unpacklo_epi64(<8 x i64> %a0, <8 x i64> %a1) {
; X32-LABEL: test_mm512_unpacklo_epi64:
; X32:       # BB#0:
; X32-NEXT:    vpunpcklqdq {{.*#+}} zmm0 = zmm0[0],zmm1[0],zmm0[2],zmm1[2],zmm0[4],zmm1[4],zmm0[6],zmm1[6]
; X32-NEXT:    retl
;
; X64-LABEL: test_mm512_unpacklo_epi64:
; X64:       # BB#0:
; X64-NEXT:    vpunpcklqdq {{.*#+}} zmm0 = zmm0[0],zmm1[0],zmm0[2],zmm1[2],zmm0[4],zmm1[4],zmm0[6],zmm1[6]
; X64-NEXT:    retq
  %res = shufflevector <8 x i64> %a0, <8 x i64> %a1, <8 x i32> <i32 0, i32 8, i32 2, i32 10, i32 4, i32 12, i32 6, i32 14>
  ret <8 x i64> %res
}

define <8 x i64> @test_mm512_mask_unpacklo_epi64(<8 x i64> %a0, i8 %a1, <8 x i64> %a2, <8 x i64> %a3) {
; X32-LABEL: test_mm512_mask_unpacklo_epi64:
; X32:       # BB#0:
; X32-NEXT:    movb {{[0-9]+}}(%esp), %al
; X32-NEXT:    kmovw %eax, %k1
; X32-NEXT:    vpunpcklqdq {{.*#+}} zmm0 = zmm1[0],zmm2[0],zmm1[2],zmm2[2],zmm1[4],zmm2[4],zmm1[6],zmm2[6]
; X32-NEXT:    retl
;
; X64-LABEL: test_mm512_mask_unpacklo_epi64:
; X64:       # BB#0:
; X64-NEXT:    kmovw %edi, %k1
; X64-NEXT:    vpunpcklqdq {{.*#+}} zmm0 = zmm1[0],zmm2[0],zmm1[2],zmm2[2],zmm1[4],zmm2[4],zmm1[6],zmm2[6]
; X64-NEXT:    retq
  %arg1 = bitcast i8 %a1 to <8 x i1>
  %res0 = shufflevector <8 x i64> %a2, <8 x i64> %a3, <8 x i32> <i32 0, i32 8, i32 2, i32 10, i32 4, i32 12, i32 6, i32 14>
  %res1 = select <8 x i1> %arg1, <8 x i64> %res0, <8 x i64> %a0
  ret <8 x i64> %res1
}

define <8 x i64> @test_mm512_maskz_unpacklo_epi64(i8 %a0, <8 x i64> %a1, <8 x i64> %a2) {
; X32-LABEL: test_mm512_maskz_unpacklo_epi64:
; X32:       # BB#0:
; X32-NEXT:    movb {{[0-9]+}}(%esp), %al
; X32-NEXT:    kmovw %eax, %k1
; X32-NEXT:    vpunpcklqdq {{.*#+}} zmm0 = zmm0[0],zmm1[0],zmm0[2],zmm1[2],zmm0[4],zmm1[4],zmm0[6],zmm1[6]
; X32-NEXT:    retl
;
; X64-LABEL: test_mm512_maskz_unpacklo_epi64:
; X64:       # BB#0:
; X64-NEXT:    kmovw %edi, %k1
; X64-NEXT:    vpunpcklqdq {{.*#+}} zmm0 = zmm0[0],zmm1[0],zmm0[2],zmm1[2],zmm0[4],zmm1[4],zmm0[6],zmm1[6]
; X64-NEXT:    retq
  %arg0 = bitcast i8 %a0 to <8 x i1>
  %res0 = shufflevector <8 x i64> %a1, <8 x i64> %a2, <8 x i32> <i32 0, i32 8, i32 2, i32 10, i32 4, i32 12, i32 6, i32 14>
  %res1 = select <8 x i1> %arg0, <8 x i64> %res0, <8 x i64> zeroinitializer
  ret <8 x i64> %res1
}

define <8 x double> @test_mm512_unpacklo_pd(<8 x double> %a0, <8 x double> %a1) {
; X32-LABEL: test_mm512_unpacklo_pd:
; X32:       # BB#0:
; X32-NEXT:    vunpcklpd {{.*#+}} zmm0 = zmm0[0],zmm1[0],zmm0[2],zmm1[2],zmm0[4],zmm1[4],zmm0[6],zmm1[6]
; X32-NEXT:    retl
;
; X64-LABEL: test_mm512_unpacklo_pd:
; X64:       # BB#0:
; X64-NEXT:    vunpcklpd {{.*#+}} zmm0 = zmm0[0],zmm1[0],zmm0[2],zmm1[2],zmm0[4],zmm1[4],zmm0[6],zmm1[6]
; X64-NEXT:    retq
  %res = shufflevector <8 x double> %a0, <8 x double> %a1, <8 x i32> <i32 0, i32 8, i32 2, i32 10, i32 4, i32 12, i32 6, i32 14>
  ret <8 x double> %res
}

define <8 x double> @test_mm512_mask_unpacklo_pd(<8 x double> %a0, i8 %a1, <8 x double> %a2, <8 x double> %a3) {
; X32-LABEL: test_mm512_mask_unpacklo_pd:
; X32:       # BB#0:
; X32-NEXT:    movb {{[0-9]+}}(%esp), %al
; X32-NEXT:    kmovw %eax, %k1
; X32-NEXT:    vunpcklpd {{.*#+}} zmm0 {%k1} = zmm1[0],zmm2[0],zmm1[2],zmm2[2],zmm1[4],zmm2[4],zmm1[6],zmm2[6]
; X32-NEXT:    retl
;
; X64-LABEL: test_mm512_mask_unpacklo_pd:
; X64:       # BB#0:
; X64-NEXT:    kmovw %edi, %k1
; X64-NEXT:    vunpcklpd {{.*#+}} zmm0 {%k1} = zmm1[0],zmm2[0],zmm1[2],zmm2[2],zmm1[4],zmm2[4],zmm1[6],zmm2[6]
; X64-NEXT:    retq
  %arg1 = bitcast i8 %a1 to <8 x i1>
  %res0 = shufflevector <8 x double> %a2, <8 x double> %a3, <8 x i32> <i32 0, i32 8, i32 2, i32 10, i32 4, i32 12, i32 6, i32 14>
  %res1 = select <8 x i1> %arg1, <8 x double> %res0, <8 x double> %a0
  ret <8 x double> %res1
}

define <8 x double> @test_mm512_maskz_unpacklo_pd(i8 %a0, <8 x double> %a1, <8 x double> %a2) {
; X32-LABEL: test_mm512_maskz_unpacklo_pd:
; X32:       # BB#0:
; X32-NEXT:    movb {{[0-9]+}}(%esp), %al
; X32-NEXT:    kmovw %eax, %k1
; X32-NEXT:    vunpcklpd {{.*#+}} zmm0 {%k1} {z} = zmm0[0],zmm1[0],zmm0[2],zmm1[2],zmm0[4],zmm1[4],zmm0[6],zmm1[6]
; X32-NEXT:    retl
;
; X64-LABEL: test_mm512_maskz_unpacklo_pd:
; X64:       # BB#0:
; X64-NEXT:    kmovw %edi, %k1
; X64-NEXT:    vunpcklpd {{.*#+}} zmm0 {%k1} {z} = zmm0[0],zmm1[0],zmm0[2],zmm1[2],zmm0[4],zmm1[4],zmm0[6],zmm1[6]
; X64-NEXT:    retq
  %arg0 = bitcast i8 %a0 to <8 x i1>
  %res0 = shufflevector <8 x double> %a1, <8 x double> %a2, <8 x i32> <i32 0, i32 8, i32 2, i32 10, i32 4, i32 12, i32 6, i32 14>
  %res1 = select <8 x i1> %arg0, <8 x double> %res0, <8 x double> zeroinitializer
  ret <8 x double> %res1
}

define <16 x float> @test_mm512_unpacklo_ps(<16 x float> %a0, <16 x float> %a1) {
; X32-LABEL: test_mm512_unpacklo_ps:
; X32:       # BB#0:
; X32-NEXT:    vunpcklps {{.*#+}} zmm0 = zmm0[0],zmm1[0],zmm0[1],zmm1[1],zmm0[4],zmm1[4],zmm0[5],zmm1[5],zmm0[8],zmm1[8],zmm0[9],zmm1[9],zmm0[12],zmm1[12],zmm0[13],zmm1[13]
; X32-NEXT:    retl
;
; X64-LABEL: test_mm512_unpacklo_ps:
; X64:       # BB#0:
; X64-NEXT:    vunpcklps {{.*#+}} zmm0 = zmm0[0],zmm1[0],zmm0[1],zmm1[1],zmm0[4],zmm1[4],zmm0[5],zmm1[5],zmm0[8],zmm1[8],zmm0[9],zmm1[9],zmm0[12],zmm1[12],zmm0[13],zmm1[13]
; X64-NEXT:    retq
  %res = shufflevector <16 x float> %a0, <16 x float> %a1, <16 x i32> <i32 0, i32 16, i32 1, i32 17, i32 4, i32 20, i32 5, i32 21, i32 8, i32 24, i32 9, i32 25, i32 12, i32 28, i32 13, i32 29>
  ret <16 x float> %res
}

define <16 x float> @test_mm512_mask_unpacklo_ps(<16 x float> %a0, i16 %a1, <16 x float> %a2, <16 x float> %a3) {
; X32-LABEL: test_mm512_mask_unpacklo_ps:
; X32:       # BB#0:
; X32-NEXT:    movw {{[0-9]+}}(%esp), %ax
; X32-NEXT:    kmovw %eax, %k1
; X32-NEXT:    vunpcklps {{.*#+}} zmm0 {%k1} = zmm1[0],zmm2[0],zmm1[1],zmm2[1],zmm1[4],zmm2[4],zmm1[5],zmm2[5],zmm1[8],zmm2[8],zmm1[9],zmm2[9],zmm1[12],zmm2[12],zmm1[13],zmm2[13]
; X32-NEXT:    retl
;
; X64-LABEL: test_mm512_mask_unpacklo_ps:
; X64:       # BB#0:
; X64-NEXT:    kmovw %edi, %k1
; X64-NEXT:    vunpcklps {{.*#+}} zmm0 {%k1} = zmm1[0],zmm2[0],zmm1[1],zmm2[1],zmm1[4],zmm2[4],zmm1[5],zmm2[5],zmm1[8],zmm2[8],zmm1[9],zmm2[9],zmm1[12],zmm2[12],zmm1[13],zmm2[13]
; X64-NEXT:    retq
  %arg1 = bitcast i16 %a1 to <16 x i1>
  %res0 = shufflevector <16 x float> %a2, <16 x float> %a3, <16 x i32> <i32 0, i32 16, i32 1, i32 17, i32 4, i32 20, i32 5, i32 21, i32 8, i32 24, i32 9, i32 25, i32 12, i32 28, i32 13, i32 29>
  %res1 = select <16 x i1> %arg1, <16 x float> %res0, <16 x float> %a0
  ret <16 x float> %res1
}

define <16 x float> @test_mm512_maskz_unpacklo_ps(i16 %a0, <16 x float> %a1, <16 x float> %a2) {
; X32-LABEL: test_mm512_maskz_unpacklo_ps:
; X32:       # BB#0:
; X32-NEXT:    movw {{[0-9]+}}(%esp), %ax
; X32-NEXT:    kmovw %eax, %k1
; X32-NEXT:    vunpcklps {{.*#+}} zmm0 {%k1} {z} = zmm0[0],zmm1[0],zmm0[1],zmm1[1],zmm0[4],zmm1[4],zmm0[5],zmm1[5],zmm0[8],zmm1[8],zmm0[9],zmm1[9],zmm0[12],zmm1[12],zmm0[13],zmm1[13]
; X32-NEXT:    retl
;
; X64-LABEL: test_mm512_maskz_unpacklo_ps:
; X64:       # BB#0:
; X64-NEXT:    kmovw %edi, %k1
; X64-NEXT:    vunpcklps {{.*#+}} zmm0 {%k1} {z} = zmm0[0],zmm1[0],zmm0[1],zmm1[1],zmm0[4],zmm1[4],zmm0[5],zmm1[5],zmm0[8],zmm1[8],zmm0[9],zmm1[9],zmm0[12],zmm1[12],zmm0[13],zmm1[13]
; X64-NEXT:    retq
  %arg0 = bitcast i16 %a0 to <16 x i1>
  %res0 = shufflevector <16 x float> %a1, <16 x float> %a2, <16 x i32> <i32 0, i32 16, i32 1, i32 17, i32 4, i32 20, i32 5, i32 21, i32 8, i32 24, i32 9, i32 25, i32 12, i32 28, i32 13, i32 29>
  %res1 = select <16 x i1> %arg0, <16 x float> %res0, <16 x float> zeroinitializer
  ret <16 x float> %res1
}

!0 = !{i32 1}

