	.file	"t1.c"
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
	.comm	max,4,4
	.globl	counter
	.bss
	.align 4
	.type	counter, @object
	.size	counter, 4
counter:
	.zero	4
	.section	.rodata
.LC3:
	.string	"%s: begin [addr of i: %p]\n"
.LC4:
	.string	"%s: done\n"
	.text
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
	subq	$48, %rsp
	movq	%rdi, -40(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movq	-40(%rbp), %rax
	movq	%rax, -16(%rbp)
	leaq	-20(%rbp), %rdx
	movq	-16(%rbp), %rax
	movq	%rax, %rsi
	movl	$.LC3, %edi
	movl	$0, %eax
	call	printf
	movl	$0, -20(%rbp)
	jmp	.L8
.L9:
	movl	counter(%rip), %eax
	addl	$1, %eax
	movl	%eax, counter(%rip)
	movl	-20(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -20(%rbp)
.L8:
	movl	-20(%rbp), %edx
	movl	max(%rip), %eax
	cmpl	%eax, %edx
	jl	.L9
	movq	-16(%rbp), %rax
	movq	%rax, %rsi
	movl	$.LC4, %edi
	movl	$0, %eax
	call	printf
	movl	$0, %eax
	movq	-8(%rbp), %rcx
	xorq	%fs:40, %rcx
	je	.L11
	call	__stack_chk_fail
.L11:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4:
	.size	mythread, .-mythread
	.section	.rodata
	.align 8
.LC5:
	.string	"usage: main-first <loopcount>\n"
	.align 8
.LC6:
	.string	"main: begin [counter = %d] [%x]\n"
.LC7:
	.string	"A"
.LC8:
	.string	"t1.c"
	.align 8
.LC9:
	.string	"pthread_create(&p1, ((void *)0), mythread, \"A\") == 0"
.LC10:
	.string	"B"
	.align 8
.LC11:
	.string	"pthread_create(&p2, ((void *)0), mythread, \"B\") == 0"
	.align 8
.LC12:
	.string	"pthread_join(p1, ((void *)0)) == 0"
	.align 8
.LC13:
	.string	"pthread_join(p2, ((void *)0)) == 0"
	.align 8
.LC14:
	.string	"main: done\n [counter: %d]\n [should: %d]\n"
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
	cmpl	$2, -36(%rbp)
	je	.L13
	movq	stderr(%rip), %rax
	movq	%rax, %rcx
	movl	$30, %edx
	movl	$1, %esi
	movl	$.LC5, %edi
	call	fwrite
	movl	$1, %edi
	call	exit
.L13:
	movq	-48(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	atoi
	movl	%eax, max(%rip)
	movl	$counter, %eax
	movl	%eax, %edx
	movl	counter(%rip), %eax
	movl	%eax, %esi
	movl	$.LC6, %edi
	movl	$0, %eax
	call	printf
	leaq	-24(%rbp), %rax
	movl	$.LC7, %ecx
	movl	$mythread, %edx
	movl	$0, %esi
	movq	%rax, %rdi
	call	pthread_create
	testl	%eax, %eax
	je	.L14
	movl	$__PRETTY_FUNCTION__.3484, %ecx
	movl	$32, %edx
	movl	$.LC8, %esi
	movl	$.LC9, %edi
	call	__assert_fail
.L14:
	leaq	-16(%rbp), %rax
	movl	$.LC10, %ecx
	movl	$mythread, %edx
	movl	$0, %esi
	movq	%rax, %rdi
	call	pthread_create
	testl	%eax, %eax
	je	.L15
	movl	$__PRETTY_FUNCTION__.3484, %ecx
	movl	$33, %edx
	movl	$.LC8, %esi
	movl	$.LC11, %edi
	call	__assert_fail
.L15:
	movq	-24(%rbp), %rax
	movl	$0, %esi
	movq	%rax, %rdi
	call	pthread_join
	testl	%eax, %eax
	je	.L16
	movl	$__PRETTY_FUNCTION__.3484, %ecx
	movl	$35, %edx
	movl	$.LC8, %esi
	movl	$.LC12, %edi
	call	__assert_fail
.L16:
	movq	-16(%rbp), %rax
	movl	$0, %esi
	movq	%rax, %rdi
	call	pthread_join
	testl	%eax, %eax
	je	.L17
	movl	$__PRETTY_FUNCTION__.3484, %ecx
	movl	$36, %edx
	movl	$.LC8, %esi
	movl	$.LC13, %edi
	call	__assert_fail
.L17:
	movl	max(%rip), %eax
	leal	(%rax,%rax), %edx
	movl	counter(%rip), %eax
	movl	%eax, %esi
	movl	$.LC14, %edi
	movl	$0, %eax
	call	printf
	movl	$0, %eax
	movq	-8(%rbp), %rcx
	xorq	%fs:40, %rcx
	je	.L19
	call	__stack_chk_fail
.L19:
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
	.type	__PRETTY_FUNCTION__.3484, @object
	.size	__PRETTY_FUNCTION__.3484, 5
__PRETTY_FUNCTION__.3484:
	.string	"main"
	.align 8
.LC2:
	.long	0
	.long	1093567616
	.ident	"GCC: (Ubuntu 7.3.0-23ubuntu2~16.04.york0) 7.3.0"
	.section	.note.GNU-stack,"",@progbits
