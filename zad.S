.section .data

poruka1: 
	.ascii "Unesite izraz"
    n1 = . -poruka1
baza: .long 10
    
unos:
	.fill 100 , 1 , 42
niz:
	.fill 7 , 4 , 0
greska: 
	.long 0
suma:
	.long 0
pros:
	.long 0
min:
	.long 0
min_i:
	.long 0
max:
	.long 0
max_i:
	.long 0

.section .text
.global main
main:

	movl $4 , %eax
	movl $1 , %ebx
	movl $poruka1 , %ecx
	movl $n1 , %edx
	int $0x80

	movl $3 , %eax
	movl $0 , %ebx
	movl $unos , %ecx
	movl $100 , %edx
	int $0x80

	movl $0 , %esi # brojac kroz string
	movl $0 , %edi # dan 	
	movl $0 , %ebx
	movl $0 , %eax
	movl $0 , %edx
	
	

petlja1:

	movb unos(,%esi,1) , %bl
	incl %esi
	
	cmpb $10 , %bl
	je izlaz1
	cmpb $' ' , %bl
	je obrada
konvertovanje:
	
	cmpb $'0' , %bl
	jb greska99
	cmpb $'9' , %bl
	ja greska99
	
	jmp nastavi99
	
greska99:

	movl $1 , greska
	jmp kraj

nastavi99:
	
	mull baza
	subb $'0' , %bl
	addl %ebx , %eax

	jmp petlja1
obrada:
	
	movl %eax , niz(,%edi,4)
	movl $0 , %eax
	incl %edi
	
	jmp petlja1
izlaz1:
    movl %eax , niz(,%edi,4)
	movl $0 , %eax
	
	
	

# konvertovano u niz

movl $0 , %edi
movl niz(,%edi,4) , %eax
movl %eax , min
movl %eax , max
addl %eax , suma
incl %edi

	petlja2:
	
		movl niz(,%edi,4) , %eax
		
		cmpl min , %eax
		jnb dalje1
		
		movl %eax , min
		movl %edi , min_i
		
dalje1:

		cmpl max , %eax
		jna dalje2
		
		movl %eax , max
		movl %edi , max_i
		
dalje2:

	addl %eax , suma
	incl %edi
	
	cmpl $7 , %edi
	jne petlja2

movl $0 , %edx
movl suma, %eax
movl $7 , %ecx

divl %ecx
movl %eax , pros



kraj:
movl $1 , %eax
movl greska , %ebx
int $0x80
