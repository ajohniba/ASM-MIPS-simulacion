.data
prompt_n:      .asciiz "Ingrese el numero de Fibonacci a generar : "  								# Mensaje 
fib_series:    .asciiz "Fibonacci serie         : "                   								# Etiqueta 
fib_sum:       .asciiz "Suma de Fibonacci serie : "                   								# Etiqueta 
comma:         .asciiz ", "                                             							# Coma usada para separar los numeros de la serie
newline:       .asciiz "\n"                                             							# Salto de línea
error_msg:     .asciiz "Entrada Invalida! Entre el numero mayor a 0.\n" 							# Mensaje de error para entradas invalidas

.text
.globl main

main:
    # Solicitar al usuario el numero de terminos de Fibonacci
    li $v0, 4               																		# Preparar syscall para imprimir cadena
    la $a0, prompt_n        																		# Cargar la direccion del mensaje de solicitud
    syscall

    li $v0, 5               																		# Preparar syscall para leer entero
    syscall
    move $t0, $v0           																		# Guardar el numero de terminos en $t0

    blez $t0, invalid_input 																		# Si el numero es <= 0, ir a entrada invalida

    # Inicializar variables
    li $t1, 0               																		# $t1 = Fibonacci(0) (primer numero de la serie)
    li $t2, 1               																		# $t2 = Fibonacci(1) (segundo numero de la serie)
    li $t3, 0               																		# $t3 = suma (inicialmente 0)
    li $t4, 0               																		# $t4 = contador (empieza en 0)

    # Imprimir etiqueta de la serie de Fibonacci
    li $v0, 4               																		# Preparar syscall para imprimir cadena
    la $a0, fib_series      																		# Cargar la direccion del mensaje
    syscall

    # Manejar el primer termino
    move $a0, $t1           																		# Mover el valor de Fibonacci(0) a $a0 para imprimir
    li $v0, 1               																		# Preparar syscall para imprimir entero
    syscall
    add $t3, $t3, $t1       																		# Sumar el primer termino a la suma total
    addi $t4, $t4, 1        																		# Incrementar el contador

    # Imprimir coma si hay mas terminos
    beq $t0, 1, print_sum   																		# Si el numero de terminos es 1, saltar a imprimir la suma
    li $v0, 4               																		# Preparar syscall para imprimir cadena
    la $a0, comma           																		# Cargar la direccion de la coma
    syscall

    # Imprimir el segundo termino
    move $a0, $t2           																		# Mover el valor de Fibonacci(1) a $a0 para imprimir
    li $v0, 1               																		# Preparar syscall para imprimir entero
    syscall
    add $t3, $t3, $t2       																		# Sumar el segundo termino a la suma total
    addi $t4, $t4, 1        																		# Incrementar el contador

    # Imprimir coma si hay mas terminos
    bge $t0, 3, print_comma 																		# Si el numero de terminos es >= 3, imprimir coma

    # Saltar a imprimir la suma si solo hay 2 terminos
    j print_sum

print_comma:
    # Imprimir una coma
    li $v0, 4               																		# Preparar syscall para imprimir cadena
    la $a0, comma           																		# Cargar la direccion de la coma
    syscall

    # Generar la serie de Fibonacci y calcular la suma
fib_loop:
    add $t6, $t1, $t2       																		# $t6 = Fibonacci(i-2) + Fibonacci(i-1)
    move $t1, $t2           																		# $t1 = Fibonacci(i-1)
    move $t2, $t6           																		# $t2 = Fibonacci(i)
    add $t3, $t3, $t6       																		# adicionar el nuevo termino a la suma

    # Imprimir el nuevo termino
    move $a0, $t6           																		# Mover el valor de Fibonacci(i) a $a0 para imprimir
    li $v0, 1               																		# Preparar syscall para imprimir entero
    syscall

    # Imprimir coma si no es el ultimo termino
    addi $t4, $t4, 1        																		# Incrementar el contador
    bge $t4, $t0, print_sum 																		# Si el contador >= numero de terminos, saltar a imprimir la suma

    li $v0, 4               																		# Preparar syscall para imprimir cadena
    la $a0, comma           																		# Cargar la direccion de la coma
    syscall
    j fib_loop              																		# Continuar el ciclo

print_sum:
    # Imprimir salto de línea
    li $v0, 4               																		# Preparar syscall para imprimir cadena
    la $a0, newline         																		# Cargar la direccion del salto de línea
    syscall

    # Imprimir etiqueta de la suma de la serie de Fibonacci
    li $v0, 4               																		# Preparar syscall para imprimir cadena
    la $a0, fib_sum         																		# Cargar la direccion del mensaje de suma
    syscall

    # Imprimir la suma
    move $a0, $t3           																		# Mover la suma a $a0 para imprimir
    li $v0, 1               																		# Preparar syscall para imprimir entero
    syscall

    # Imprimir salto de línea
    li $v0, 4               																		# Preparar syscall para imprimir cadena
    la $a0, newline         																		# Cargar la direccion del salto de línea
    syscall

    # Salir del programa
    li $v0, 10              																		# Preparar syscall para salir
    syscall

invalid_input:
    # Imprimir mensaje de error para entrada invalida
    li $v0, 4               																		# Preparar syscall para imprimir cadena
    la $a0, error_msg       																		# Cargar la direccion del mensaje de error
    syscall
    j exit_program          																		# Saltar a la salida del programa

exit_program:
    # Salir del programa
    li $v0, 10              																		# Preparar syscall para salir
    syscall
