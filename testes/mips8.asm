inicio:
bne	$s1,	$s0,	main
addi 	$s0,	$s0,	100
addi	$s1,	$s1,	200
bne	$s1,	$s0,	main
main:
j	inicio
 