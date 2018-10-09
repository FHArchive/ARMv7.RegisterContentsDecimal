

@subroutine v_dec to display a decimal value 
@	r0: value to be displayed 
@	lr: return address 
@	registers are preserved 

	.global	v_dec
v_dec: 	push 	{r0-r8}		@save
	mov 	r3,r0		@copy r0
	mov	r2,#1		@print setup
	mov	r0,#1
	mov	r7,#4
	mov	r8,#0		@is-negative flag 

@	is the number negative?
	cmp	r3,#0	
	bge	absval		@ if r3 >= 0 then branch to absval:

@ 	print "(" and set a flag to print ")" at the end of the program 
	
	add 	r8,#1		@ set the is-negative flag 
	ldr	r1,=brckts	@ print "("
	svc 	0
	rsb	r3,r3,#0	@ get abs value 

absval:	cmp	r3,#10
	blt	onecol		@ if r3 < 10 goto onecol

@ 	get highest power of 10 the number needs 
	ldr	r6,=pow10 + 8	@ point to the 100s column 

high10:	ldr	r5,[r6],#4	@ load next higher power of 10
	cmp	r3,r5
	bge	high10		@ if our number is greater then the power of 10 being 
				@ tested
	sub	r6, #8		@ we went too far 

@	loop through power of 10 and output them 

nxtdec:	ldr	r1,=dig-1	@ point to a byte before "0123456789" string 
	ldr	r5,[r6],#-4	@ load next lower power of 10

@ 	loop through digit to be displayed 

mod10:	add	r1,#1		@ point to the next digit (this is our counter)
	subs	r3,r5		
	bge	mod10		@ subtract the power of 10 until the value is negative 
	addlt	r3,r5		@ we went one too far (it was -ve) 
	svc	0		@ print 


@ insert "," if r9%12 = 0 
	mov 	r9,r6			@ r6 holds an initial value of 65836 (0)
	movhi	r10,#0b1		@ mov 65836 into r10 (as it has more than 16 bits 
	mov	r10,#0b0000000100101100	@ do it in two parts 65 836 = 0b1 + 0b0000000100101100)
	sub 	r9,r10
	add 	r9,#4			@ gone too far
	ldr	r1,=comma
modulo:	sub	r9,#12
	cmp 	r9,#0
	svceq	0
	bgt	modulo		@ go again if the number is greater than 0



	cmp	r5,#10
	bgt	nxtdec		@ if not in the ones column go again 

@	display the ones digit
onecol:	ldr	r1,=dig		@ point to start of dig
	add	r1,r3		@ r3 now holds a unit value so r1 will point to said
				@ unit  
	svc	0		@ print r1
	ldr	r1,=brckts
	add	r1,#1
	cmp	r8,#1
	svceq	0		@ print ")" if the number is negative 
	
	pop	{r0-r8}		@ restore because i have to...
	bx	lr		@ exit subroutine 



pow10:	.word	1		@10^0 (0)
	.word	10		@10^1
	.word	100		@10^2
	.word	1000		@10^3 thousand (12) insert "," 
	.word	10000		@10^4
	.word	100000		@10^5
	.word	1000000		@10^6 million (24)
	.word	10000000	@10^7
	.word	100000000	@10^8
	.word	1000000000	@10^9 billion (36)
	.word	0x7FFFFFFF	@largest int 
dig:	.ascii	"0123456789"	
msign:	.ascii	"-"
brckts:	.ascii	"()"		@ will be needed for -ve numbers 
comma:	.ascii	","		
	.end

