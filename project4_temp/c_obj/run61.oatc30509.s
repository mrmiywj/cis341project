	.file	"<stdin>"
	.text
	.globl	oat_init
	.align	16, 0x90
	.type	oat_init,@function
oat_init:                               # @oat_init
.Ltmp1:
# BB#0:                                 # %__fresh103
	subl	$12, %esp
.Ltmp2:
	calll	s507.init
	addl	$12, %esp
	ret
.Ltmp3:
	.size	oat_init, .Ltmp3-oat_init
.Ltmp4:

	.globl	program
	.align	16, 0x90
	.type	program,@function
program:                                # @program
.Ltmp6:
# BB#0:                                 # %__fresh102
	subl	$12, %esp
.Ltmp7:
	movl	20(%esp), %eax
	movl	16(%esp), %ecx
	movl	%ecx, 8(%esp)
	movl	%eax, 4(%esp)
	movl	s507, %eax
	movl	%eax, (%esp)
	calll	print_string
	movl	$0, %eax
	addl	$12, %esp
	ret
.Ltmp8:
	.size	program, .Ltmp8-program
.Ltmp9:

	.globl	s507.init
	.align	16, 0x90
	.type	s507.init,@function
s507.init:                              # @s507.init
.Ltmp10:
# BB#0:                                 # %__fresh101
	movl	_oat_string505, %eax
	movl	%eax, s507
	ret
.Ltmp11:
	.size	s507.init, .Ltmp11-s507.init
.Ltmp12:

	.type	s507,@object            # @s507
	.bss
	.globl	s507
	.align	4
s507:
	.long	0
	.size	s507, 4

	.type	.L_oat_string505.str.,@object # @_oat_string505.str.
	.section	.rodata.str1.4,"aMS",@progbits,1
	.align	4
.L_oat_string505.str.:
	.asciz	"341"
	.size	.L_oat_string505.str., 4

	.type	_oat_string505,@object  # @_oat_string505
	.data
	.globl	_oat_string505
	.align	4
_oat_string505:
	.long	.L_oat_string505.str.
	.size	_oat_string505, 4


	.section	".note.GNU-stack","",@progbits
	.section	.eh_frame,"a",@progbits
.Ltmp13:
.Ltmp14:
	.long	(.Ltmp15-.Ltmp14)-4     # CIE Length
	.long	0                       # CIE ID Tag
	.byte	1                       # DW_CIE_VERSION
	.ascii	"zR"                    # CIE Augmentation
	.byte	0
	.byte	1                       # CIE Code Alignment Factor
	.byte	124                     # CIE Data Alignment Factor
	.byte	8                       # CIE Return Address Column
	.byte	1                       # Augmentation Size
	.byte	0                       # FDE Encoding = absptr
	.byte	12                      # DW_CFA_def_cfa
	.byte	4                       # Reg 4
	.byte	4                       # Offset 4
	.byte	136                     # DW_CFA_offset + Reg(8)
	.byte	1                       # Offset 1
	.align	4
.Ltmp15:
	.long	(.Ltmp17-.Ltmp16)-0     # FDE Length
.Ltmp16:
	.long	(.Ltmp16-.Ltmp14)-0     # FDE CIE Offset
	.long	.Ltmp1                  # FDE initial location
	.long	(.Ltmp4-.Ltmp1)-0       # FDE address range
	.byte	0                       # Augmentation size
	.byte	4                       # DW_CFA_advance_loc4
	.long	.Ltmp2-.Ltmp1
	.byte	14                      # DW_CFA_def_cfa_offset
	.byte	16                      # Offset 16
	.align	4
.Ltmp17:
	.long	(.Ltmp19-.Ltmp18)-0     # FDE Length
.Ltmp18:
	.long	(.Ltmp18-.Ltmp14)-0     # FDE CIE Offset
	.long	.Ltmp6                  # FDE initial location
	.long	(.Ltmp9-.Ltmp6)-0       # FDE address range
	.byte	0                       # Augmentation size
	.byte	4                       # DW_CFA_advance_loc4
	.long	.Ltmp7-.Ltmp6
	.byte	14                      # DW_CFA_def_cfa_offset
	.byte	16                      # Offset 16
	.align	4
.Ltmp19:
	.long	(.Ltmp21-.Ltmp20)-0     # FDE Length
.Ltmp20:
	.long	(.Ltmp20-.Ltmp14)-0     # FDE CIE Offset
	.long	.Ltmp10                 # FDE initial location
	.long	(.Ltmp12-.Ltmp10)-0     # FDE address range
	.byte	0                       # Augmentation size
	.align	4
	.align	4
.Ltmp21:
