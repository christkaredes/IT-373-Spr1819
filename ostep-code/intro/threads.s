	.file	"threads.c"
	.text
	.section	.rodata
.LC0:
	.string	"common.h"
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
	movl	$__PRETTY_FUNCTION__.2925, %ecx
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
	.globl	counter
	.bss
	.align 4
	.type	counter, @object
	.size	counter, 4
counter:
	.zero	4
	.comm	loops,4,4
	.text
	.globl	worker
	.type	worker, @function
worker:
.LFB4:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)
	movl	$0, -4(%rbp)
	jmp	.L8
.L9:
	movl	counter(%rip), %eax
	addl	$1, %eax
	movl	%eax, counter(%rip)
	addl	$1, -4(%rbp)
.L8:
	movl	loops(%rip), %eax
	cmpl	%eax, -4(%rbp)
	jl	.L9
	movl	$0, %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4:
	.size	worker, .-worker
	.section	.rodata
.LC3:
	.string	"usage: threads <loops>\n"
.LC4:
	.string	"Initial value : %d\n"
.LC5:
	.string	"threads.c"
	.align 8
.LC6:
	.string	"pthread_create(&p1, ((void *)0), worker, ((void *)0)) == 0"
	.align 8
.LC7:
	.string	"pthread_create(&p2, ((void *)0), worker, ((void *)0)) == 0"
	.align 8
.LC8:
	.string	"pthread_join(p1, ((void *)0)) == 0"
	.align 8
.LC9:
	.string	"pthread_join(p2, ((void *)0)) == 0"
.LC10:
	.string	"Final value   : %d\n"
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
	je	.L12
	movq	stderr(%rip), %rax
	movq	%rax, %rcx
	movl	$23, %edx
	movl	$1, %esi
	movl	$.LC3, %edi
	call	fwrite
	movl	$1, %edi
	call	exit
.L12:
	movq	-48(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	atoi
	movl	%eax, loops(%rip)
	movl	counter(%rip), %eax
	movl	%eax, %esi
	movl	$.LC4, %edi
	movl	$0, %eax
	call	printf
	leaq	-24(%rbp), %rax
	movl	$0, %ecx
	movl	$worker, %edx
	movl	$0, %esi
	movq	%rax, %rdi
	call	pthread_create
	testl	%eax, %eax
	je	.L13
	movl	$__PRETTY_FUNCTION__.3483, %ecx
	movl	$25, %edx
	movl	$.LC5, %esi
	movl	$.LC6, %edi
	call	__assert_fail
.L13:
	leaq	-16(%rbp), %rax
	movl	$0, %ecx
	movl	$worker, %edx
	movl	$0, %esi
	movq	%rax, %rdi
	call	pthread_create
	testl	%eax, %eax
	je	.L14
	movl	$__PRETTY_FUNCTION__.3483, %ecx
	movl	$26, %edx
	movl	$.LC5, %esi
	movl	$.LC7, %edi
	call	__assert_fail
.L14:
	movq	-24(%rbp), %rax
	movl	$0, %esi
	movq	%rax, %rdi
	call	pthread_join
	testl	%eax, %eax
	je	.L15
	movl	$__PRETTY_FUNCTION__.3483, %ecx
	movl	$27, %edx
	movl	$.LC5, %esi
	movl	$.LC8, %edi
	call	__assert_fail
.L15:
	movq	-16(%rbp), %rax
	movl	$0, %esi
	movq	%rax, %rdi
	call	pthread_join
	testl	%eax, %eax
	je	.L16
	movl	$__PRETTY_FUNCTION__.3483, %ecx
	movl	$28, %edx
	movl	$.LC5, %esi
	movl	$.LC9, %edi
	call	__assert_fail
.L16:
	movl	counter(%rip), %eax
	movl	%eax, %esi
	movl	$.LC10, %edi
	movl	$0, %eax
	call	printf
	movl	$0, %eax
	movq	-8(%rbp), %rdx
	xorq	%fs:40, %rdx
	je	.L18
	call	__stack_chk_fail
.L18:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE5:
	.size	main, .-main
	.section	.rodata
	.align 8
	.type	__PRETTY_FUNCTION__.2925, @object
	.size	__PRETTY_FUNCTION__.2925, 8
__PRETTY_FUNCTION__.2925:
	.string	"GetTime"
	.type	__PRETTY_FUNCTION__.3483, @object
	.size	__PRETTY_FUNCTION__.3483, 5
__PRETTY_FUNCTION__.3483:
	.string	"main"
	.align 8
.LC2:
	.long	0
	.long	1093567616
	.ident	"GCC: (Ubuntu 7.3.0-23ubuntu2~16.04.york0) 7.3.0"
	.section	.note.GNU-stack,"",@progbits
