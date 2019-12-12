main:
addi 	$s0,	$s0,	33
addi 	$s1,	$s1,	1
and 	$s2,	$s0,	$s1
addi	$s3,	$s3,	1
beq 	$s3,	$s2,	jump
jump:
addi	$s5,	$s5,	0x00000014
jr	$s5