addi 	$s0,	$s0,	100
addi	$s1,	$s1,	0x2000
sw 	$s0,	0($s1)
lw 	$s2,	0($s1)
addi	$s3,	$s3,	1
add	$s4,	$s3,	$s2