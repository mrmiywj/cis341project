	.align 4
	.text
.globl program
program:
	movl 4(%esp), %edx
	movl $17, %eax
	pushl %eax
	movl %edx, %eax
	movl %eax, %ecx
	sarl %cl, 0(%esp)
	movl 0(%esp), %eax
	addl $4, %esp
	ret
