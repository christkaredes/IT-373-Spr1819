	.file	"t0.c"
	.text
	.section	.rodata
.LC0:
	.string	"../include/common.h"
.LC1:
	.string	"rc == 0"
	.text
	.globl	GetTime
	.type	GetTime, @function
GetTime:
.LFB2:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	leaq	-32(%rbp), %rax
	movl	$0, %esi
	movq	%rax, %rdi
	call	gettimeofday
	movl	%eax, -36(%rbp)
	cmpl	$0, -36(%rbp)
	je	.L2
	movl	$__PRETTY_FUNCTION__.3431, %ecx
	movl	$11, %edx
	movl	$.LC0, %esi
	movl	$.LC1, %edi
	call	__assert_fail
.L2:
	movq	-32(%rbp), %rax
	cvtsi2sdq	%rax, %xmm1
	movq	-24(%rbp), %rax
	cvtsi2sdq	%rax, %xmm0
	movsd	.LC2(%rip), %xmm2
	divsd	%xmm2, %xmm0
	addsd	%xmm1, %xmm0
	movq	-8(%rbp), %rax
	xorq	%fs:40, %rax
	je	.L4
	call	__stack_chk_fail
.L4:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	GetTime, .-GetTime
	.globl	Spin
	.type	Spin, @function
Spin:
.LFB3:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movl	%edi, -20(%rbp)
	movl	$0, %eax
	call	GetTime
	movq	%xmm0, %rax
	movq	%rax, -8(%rbp)
	nop
.L6:
	movl	$0, %eax
	call	GetTime
	movapd	%xmm0, %xmm1
	subsd	-8(%rbp), %xmm1
	cvtsi2sd	-20(%rbp), %xmm0
	ucomisd	%xmm1, %xmm0
	ja	.L6
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3:
	.size	Spin, .-Spin
	.globl	mythread
	.type	mythread, @function
mythread:
.LFB4:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	puts
	movl	$0, %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4:
	.size	mythread, .-mythread
	.section	.rodata
.LC3:
	.string	"usage: main\n"
.LC4:
	.string	"main: begin"
.LC5:
	.string	"A"
.LC6:
	.string	"t0.c"
	.align 8
.LC7:
	.string	"pthread_create(&p1, ((void *)0), mythread, \"A\") == 0"
.LC8:
	.string	"B"
	.align 8
.LC9:
	.string	"pthread_create(&p2, ((void *)0), mythread, \"B\") == 0"
	.align 8
.LC10:
	.string	"pthread_join(p1, ((void *)0)) == 0"
	.align 8
.LC11:
	.string	"pthread_join(p2, ((void *)0)) == 0"
.LC12:
	.string	"main: end"
	.text
	.globl	main
	.type	main, @function
main:
.LFB5:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movl	%edi, -36(%rbp)
	movq	%rsi, -48(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	cmpl	$1, -36(%rbp)
	je	.L10
	movq	stderr(%rip), %rax
	movq	%rax, %rcx
	movl	$12, %edx
	movl	$1, %esi
	movl	$.LC3, %edi
	call	fwrite
	movl	$1, %edi
	call	exit
.L10:
	movl	$.LC4, %edi
	call	puts
	leaq	-24(%rbp), %rax
	movl	$.LC5, %ecx
	movl	$mythread, %edx
	movl	$0, %esi
	movq	%rax, %rdi
	call	pthread_create
	testl	%eax, %eax
	je	.L11
	movl	$__PRETTY_FUNCTION__.3477, %ecx
	movl	$21, %edx
	movl	$.LC6, %esi
	movl	$.LC7, %edi
	call	__assert_fail
.L11:
	leaq	-16(%rbp), %rax
	movl	$.LC8, %ecx
	movl	$mythread, %edx
	movl	$0, %esi
	movq	%rax, %rdi
	call	pthread_create
	testl	%eax, %eax
	je	.L12
	movl	$__PRETTY_FUNCTION__.3477, %ecx
	movl	$22, %edx
	movl	$.LC6, %esi
	movl	$.LC9, %edi
	call	__assert_fail
.L12:
	movq	-24(%rbp), %rax
	movl	$0, %esi
	movq	%rax, %rdi
	call	pthread_join
	testl	%eax, %eax
	je	.L13
	movl	$__PRETTY_FUNCTION__.3477, %ecx
	movl	$24, %edx
	movl	$.LC6, %esi
	movl	$.LC10, %edi
	call	__assert_fail
.L13:
	movq	-16(%rbp), %rax
	movl	$0, %esi
	movq	%rax, %rdi
	call	pthread_join
	testl	%eax, %eax
	je	.L14
	movl	$__PRETTY_FUNCTION__.3477, %ecx
	movl	$25, %edx
	movl	$.LC6, %esi
	movl	$.LC11, %edi
	call	__assert_fail
.L14:
	movl	$.LC12, %edi
	call	puts
	movl	$0, %eax
	movq	-8(%rbp), %rdx
	xorq	%fs:40, %rdx
	je	.L16
	call	__stack_chk_fail
.L16:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE5:
	.size	main, .-main
	.section	.rodata
	.align 8
	.type	__PRETTY_FUNCTION__.3431, @object
	.size	__PRETTY_FUNCTION__.3431, 8
__PRETTY_FUNCTION__.3431:
	.string	"GetTime"
	.type	__PRETTY_FUNCTION__.3477, @object
	.size	__PRETTY_FUNCTION__.3477, 5
__PRETTY_FUNCTION__.3477:
	.string	"main"
	.align 8
.LC2:
	.long	0
	.long	1093567616
	.ident	"GCC: (Ubuntu 7.3.0-23ubuntu2~16.04.york0) 7.3.0"
	.section	.note.GNU-stack,"",@progbits
