	.global	_start
_start:	mov	r0,#123
	bl	v_dec		@goto subroutine

	mov	r0,#-123
	bl	v_dec

	mov	r0,#12345
	bl	v_dec


	mov	r0,#0
	mov	r7,#1
	svc	0		@terminate prog

@subroutine v_dec to display a decimal value 
@	r0: value to be displayed 
@	lr: return address 
@	registers are preserved 

	
	.end

