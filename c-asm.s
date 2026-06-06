	.file	"c-asm.c"
	.option nopic
	.attribute arch, "rv32i2p1"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	2
	.globl	Anirban
	.type	Anirban, @function
Anirban:
	addi	sp,sp,-32
	sw	s0,28(sp)
	addi	s0,sp,32
	li	a5,10
	sw	a5,-20(s0)
	nop
.L2:
	lw	a5,-20(s0)
	addi	a5,a5,21
	sw	a5,-20(s0)
	nop
	lw	s0,28(sp)
	addi	sp,sp,32
	jr	ra
	.size	Anirban, .-Anirban
	.ident	"GCC: (13.2.0-11ubuntu1+12) 13.2.0"
