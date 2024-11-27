.data
	PerSaque: .asciiz "Qual será o valor do saque? "
.text

	#Vai ser o que vai ser impresso
	li $s0, 0	#50
	li $s1, 0	#20				
	li $s2, 0	#10				
	li $s3, 0	#5
	li $s4, 0	#1
	
	#Valores usados na conta
	li $t0, 50	 
	li $t1, 20					
	li $t2, 10					
	li $t3, 5	
	li $t4, 1	
	
	#Valor do saqui a ser realziado
	li $v0, 4
	la $a0, PerSaque
	syscall
	
	li $v0, 5
	syscall
	
	#Valor digitado
	move $t5, $v0
	
	#50
	move $a1, $t0   #Move o valor correspondente a nota
	move $a2, $t5   #Manda o valor atual do saque
	jal conta	#Chama a função que ira retornar:
	move $s0, $v0   #A quantidade de cédulas do valor passado
	move $t5, $v1   #O valor do saque atualizado
	
	#20
	move $a1, $t1
	move $a2, $t5
	jal conta
	move $s1, $v0
	move $t5, $v1
	
	#10
	move $a1, $t2
	move $a2, $t5
	jal conta
	move $s2, $v0
	move $t5, $v1
	
	#5
	move $a1, $t3
	move $a2, $t5
	jal conta
	move $s3, $v0
	move $t5, $v1
	
	#1
	move $a1, $t4
	move $a2, $t5
	jal conta
	move $s4, $v0
	move $t5, $v1
									
	result:								
		move $a1, $s0	#Move a quantidade de cédulas para $a1 como parametro para impressão					
		jal print
		jal espaco
		
		move $a1, $s1							
		jal print
		jal espaco
		
		move $a1, $s2							
		jal print
		jal espaco
		
		move $a1, $s3							
		jal print
		jal espaco
		
		move $a1, $s4							
		jal print
		jal espaco
		
		li $v0, 10 #Finaliza o programa
		syscall
	
	
	print:
		li $v0, 1	#Imprime um inteiro
		move $a0, $a1	#Movemos o parametro para $a1
		syscall		#chamamos o sistema para realizar a impressão
		jr $ra
		
	espaco:
		li $v0, 11	#Imprimir caracteres
		li $a0, 32	#Caracter do espaço " "
		syscall		#chamamos o sistema para realizar a impressão
		jr $ra
		
	conta: 
		div $a2, $a1	#Dividimos o valor do Saque pelo valor da cédula passada por parâmetro
		mflo $v0	#O resultado da divisão será a quantidade de cédulas, retornamos o valor da função por $v0
		mfhi $v1	#O resto da divisão será o saque atualizado informando o quanto sobrou, retornamos o valor da função por $v0
		jr $ra