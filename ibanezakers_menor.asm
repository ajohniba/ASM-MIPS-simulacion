.data
prompt_n:      .asciiz "Ingrese el numero de valores a comparar (3 a 5): "  			# Mensaje 
prompt_num:    .asciiz "Ingrese numero       "                             				# Mensaje 
colon:         .asciiz ": "                                                				# Caracter ":" utilizado para formatear la salida
min_result:    .asciiz "El numero menor es    : "                          				# Mensaje que indica el número menor encontrado
newline:       .asciiz "\n"                                                				# Salto de línea
error_msg:     .asciiz "Entrada invalida! Ingrese un numero entre 3 y 5.\n" 			# Mensaje de error

.text
.globl main

main:
    # Pedir la cantidad de valores a comparar
    li $v0, 4                															# Cargar el codigo del syscall para imprimir una cadena (syscall 4) en $v0
    la $a0, prompt_n         															# Cargar la dirección de la cadena prompt_n en $a0
    syscall                  															# Ejecutar el syscall para mostrar el mensaje "Ingrese el numero de valores a comparar (3 a 5):"

    # Leer la cantidad de valores a comparar
    li $v0, 5                															# Cargar el codigo del syscall para leer un numero entero (syscall 5) en $v0
    syscall                                                                             # Ejecutar el syscall para leer la entrada del usuario
    move $t0, $v0                                                                       # Mover el numero ingresado por el usuario a $t0

    # Verificar que el numero este entre 3 y 5
    li $t1, 3                															# Cargar el valor 3 en $t1 (límite inferior)
    li $t2, 5                															# Cargar el valor 5 en $t2 (límite superior)
    blt $t0, $t1, invalid_input  														# Si $t0 es menor que 3, saltar a invalid_input (entrada invalida)
    bgt $t0, $t2, invalid_input  														# Si $t0 es mayor que 5, saltar a invalid_input (entrada invalida)

    # Inicializar el valor mínimo.
    li $t3, 2147483647       															# Cargar el valor mas grande posible (2147483647) en $t3, que representa el valor inicial mínimo.

    # Ciclo para capturar y comparar los numeros ingresados por el usuario.
    li $t5, 1                															# Inicializar $t5 en 1, que actúa como contador para las iteraciones
input_loop_min:
    ble $t5, $t0, continue_input_min  													# Si el contador $t5 es menor o igual a $t0 (cantidad de numeros a ingresar), continuar al siguiente paso
    j display_result_min      															# De lo contrario, saltar a la seccion para mostrar el resultado

continue_input_min:
    # Imprimir el mensaje "Ingrese numero x:"
    li $v0, 4                															# Cargar el codigo del syscall para imprimir una cadena (syscall 4)
    la $a0, prompt_num                                                                  # Cargar la direccion de la cadena prompt_num en $a0
    syscall                                                                             # Ejecutar el syscall para mostrar el mensaje

    # Mostrar el numero de iteracion actual (x: el valor de $t5)
    move $a0, $t5            															# Mover el valor del contador $t5 a $a0 para mostrar el numero actual
    li $v0, 1                															# Cargar el codigo del syscall para imprimir un entero (syscall 1)
    syscall                  															# Ejecutar el syscall para mostrar el numero actual

    # Imprimir el caracter ":".
    li $v0, 4                															# Cargar el codigo del syscall para imprimir una cadena (syscall 4)
    la $a0, colon            															# Cargar la direccion de la cadena colon en $a0
    syscall                  															# Ejecutar el syscall para mostrar ":"

    # Leer el numero ingresado por el usuario.
    li $v0, 5                															# Cargar el codigo del syscall para leer un numero entero (syscall 5)
    syscall                  															# Ejecutar el syscall para leer el numero ingresado
    move $t6, $v0            															# Mover el numero ingresado a $t6

    # Comparar el numero ingresado con el valor mínimo actual.
    blt $t6, $t3, update_min  															# Si el numero ingresado ($t6) es menor que el valor mínimo actual ($t3), actualizar el valor mínimo.
    j next_input_min          															# De lo contrario, saltar al siguiente numero.

update_min:
    move $t3, $t6            															# Actualizar el valor mínimo con el numero ingresado.
    j next_input_min         															# Continuar con la siguiente iteracion.

next_input_min:
    addi $t5, $t5, 1         															# Incrementar el contador $t5 en 1
    j input_loop_min         															# Volver al inicio del ciclo de entrada

invalid_input:
    # Mostrar un mensaje de error para entrada invalida
    li $v0, 4                															# Cargar el codigo del syscall para imprimir una cadena (syscall 4)
    la $a0, error_msg        															# Cargar la direccion de la cadena error_msg en $a0
    syscall                  															# Ejecutar el syscall para mostrar el mensaje de error
    j exit_program           															# Saltar al final del programa

display_result_min:
    # Mostrar el mensaje "El numero menor es:"
    li $v0, 4                															# Cargar el codigo del syscall para imprimir una cadena (syscall 4)
    la $a0, min_result       															# Cargar la direccion de la cadena min_result en $a0
    syscall                  															# Ejecutar el syscall para mostrar el mensaje

    # Mostrar el numero minimo encontrado
    move $a0, $t3            															# Mover el valor mínimo ($t3) a $a0
    li $v0, 1                															# Cargar el codigo del syscall para imprimir un entero (syscall 1)
    syscall                  															# Ejecutar el syscall para mostrar el numero mínimo

    # Imprimir un salto de línea
    li $v0, 4                															# Cargar el codigo del syscall para imprimir una cadena (syscall 4)
    la $a0, newline          															# Cargar la direccion de la cadena newline en $a0
    syscall                  															# Ejecutar el syscall para mostrar el salto de línea

exit_program:
    # Terminar el programa
    li $v0, 10               															# Cargar el codigo del syscall para salir del programa (syscall 10)
    syscall                  															# Ejecutar el syscall para salir
