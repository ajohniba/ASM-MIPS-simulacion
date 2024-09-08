.data
prompt_n:      .asciiz "Ingrese el numero de valores a comparar (3 a 5): "  			# Mensaje 
prompt_num:    .asciiz "Ingrese numero       "  										# Mensaje 
colon:         .asciiz ": "  															# Dos puntos, que se muestran despues del mensaje para pedir un numero
max_result:    .asciiz "El numero mayor es    : "  										# Mensaje que se muestra antes de mostrar el numero mayor
newline:       .asciiz "\n"  															# Nueva línea
error_msg:     .asciiz "Entrada invalida! Intente nuevamente.\n"  						# Mensaje de error 

.text
.globl main  																			# Indica que la etiqueta 'main' es global, lo que significa que puede ser llamada desde fuera de este archivo de codigo

main:
    # Pedir la cantidad de valores a solicitar
    li $v0, 4              																# Syscall para imprimir una cadena (4)
    la $a0, prompt_n       																# Carga la direccion del mensaje 'prompt_n' en $a0 (primer argumento de la syscall)
    syscall                																# Llama a la syscall para imprimir el mensaje
			
    # Leer el numero de valores a comparar
read_num_values:
    li $v0, 5              																# Syscall para leer un entero desde la entrada estandar (5)
    syscall                																# Llama a la syscall para leer el numero ingresado por el usuario
    move $t0, $v0          																# Mueve el valor leído desde $v0 a $t0

    # Validar que el numero este entre 3 y 5
    li $t1, 3              																# Carga 3 en $t1
    li $t2, 5              																# Carga 5 en $t2
    blt $t0, $t1, invalid_input_num_values  											# Si el valor en $t0 es menor que 3, salta a 'invalid_input_num_values'
    bgt $t0, $t2, invalid_input_num_values  											# Si el valor en $t0 es mayor que 5, salta a 'invalid_input_num_values'
    j start_comparison     																# Si el número es valido, salta a 'start_comparison'

invalid_input_num_values:
    # Mostrar mensaje de error y volver a pedir el numero de valores
    li $v0, 4              																# Syscall para imprimir una cadena (4)
    la $a0, error_msg      																# Carga la direccion del mensaje 'error_msg' en $a0
    syscall                																# Llama a la syscall para imprimir el mensaje
    j read_num_values      																# Salta de nuevo a 'read_num_values' para pedir un numero valido

start_comparison:
    # Inicializar maximo 
    li $t3, -2147483648    																# Inicializa el maximo (t3) con el menor valor posible para un entero (minimo valor de un entero de 32 bits)

    # Ciclo para capturar y comparar los numeros
    li $t5, 1              																# Inicializa un contador en $t5 con 1
input_loop_max:
    ble $t5, $t0, continue_input_max  													# Si el contador $t5 es menor o igual al numero de valores en $t0, salta a 'continue_input_max'
    j display_result_max   																# Si el contador es mayor, salta a 'display_result_max' para mostrar el maximo
			
continue_input_max:
    # Imprimir "Ingrese numero x:"
    li $v0, 4              																# Syscall para imprimir una cadena (4)
    la $a0, prompt_num     																# Carga la direccion del mensaje 'prompt_num' en $a0
    syscall                																# Llama a la syscall para imprimir el mensaje

    move $a0, $t5          																# Mueve el contador $t5 a $a0 (primer argumento)
    li $v0, 1              																# Syscall para imprimir un entero (1)
    syscall                																# Llama a la syscall para imprimir el numero actual del contador
			
    li $v0, 4              																# Syscall para imprimir una cadena (4)
    la $a0, colon          																# Carga la direccion del mensaje 'colon' (dos puntos) en $a0
    syscall                																# Llama a la syscall para imprimir los dos puntos

read_number:
    li $v0, 5              																# Syscall para leer un entero desde la entrada estandar (5)
    syscall                																# Llama a la syscall para leer el numero ingresado por el usuario
    move $t6, $v0          																# Mueve el valor leido desde $v0 a $t6

    # Validar que la entrada es un numero valido
    # Si no es un numero valido, mostrar el mensaje de error y pedir de nuevo
    bltz $t6, invalid_input  															# Si el numero en $t6 es menor que 0, salta a 'invalid_input'
    bgtz $t6, valid_input    															# Si el numero en $t6 es mayor que 0, salta a 'valid_input'
    j invalid_input          															# Si el numero no es valido, salta a 'invalid_input'

valid_input:
    # Comparar el numero ingresado con el maximo
    bgt $t6, $t3, update_max  															# Si el numero en $t6 es mayor que el maximo actual en $t3, salta a 'update_max'
    j next_input_max          															# Si no, salta a 'next_input_max'

update_max:
    move $t3, $t6          																# Actualiza el maximo con el valor en $t6
    j next_input_max       																# Salta a 'next_input_max'

next_input_max:
    addi $t5, $t5, 1       																# Incrementa el contador $t5 en 1
    j input_loop_max       																# Salta de nuevo a 'input_loop_max' para continuar con el ciclo

invalid_input:
    # Mostrar mensaje de error y volver a pedir el numero
    li $v0, 4              																# Syscall para imprimir una cadena (4)
    la $a0, error_msg      																# Carga la direccion del mensaje 'error_msg' en $a0
    syscall                																# Llama a la syscall para imprimir el mensaje
    j read_number          																# Salta de nuevo a 'read_number' para pedir un numero valido

display_result_max:
    li $v0, 4              																# Syscall para imprimir una cadena (4)
    la $a0, max_result     																# Carga la direccion del mensaje 'max_result' en $a0
    syscall               																# Llama a la syscall para imprimir el mensaje

    move $a0, $t3          																# Mueve el valor del maximo $t3 a $a0 (primer argumento)
    li $v0, 1              																# Syscall para imprimir un entero (1)
    syscall                																# Llama a la syscall para imprimir el numero maximo

    li $v0, 4              																# Syscall para imprimir una cadena (4)
    la $a0, newline																		# Carga la direccion del mensaje 'newline' en $a0
    syscall                																# Llama a la syscall para imprimir una nueva línea

exit_program:
    li $v0, 10             																# Syscall para terminar el programa (10)
    syscall                																# Llama a la syscall para salir del programa
