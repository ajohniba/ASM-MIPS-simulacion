
# ASM-MIPS-simulacion

Este repositorio contiene tres programas escritos en lenguaje ensamblador MIPS que realizan las siguientes tareas:
1. Encontrar el número mayor entre dos números.
2. Encontrar el número menor entre dos números.
3. Generar la serie de Fibonacci y calcular la suma de los términos.

## Contenido del Repositorio

- `mayor.asm`: Programa que determina el número mayor entre dos números ingresados por el usuario.
- `menor.asm`: Programa que determina el número menor entre dos números ingresados por el usuario.
- `fibonacci.asm`: Programa que genera la serie de Fibonacci hasta un número especificado por el usuario y calcula la suma de los términos.

## Requisitos Previos

Para ejecutar estos programas, necesitarás un simulador de MIPS, como [MARS](http://courses.missouristate.edu/KenVollmar/mars/) 

## Ejecución de los Programas

1. **Clonar el repositorio:**
   ```bash
   git clone https://github.com/tu-usuario/ASM-MIPS-simulacion.git
   cd ASM-MIPS-simulacion
   ```

2. **Abrir los archivos en el simulador MIPS:**
   - Abre el archivo `mayor.asm` en MARS o SPIM.
   - Ensambla y ejecuta el programa.
   - Ingresa los números cuando se te solicite y observa el resultado en la consola.

   Repite el proceso para los archivos `menor.asm` y `fibonacci.asm`.

3. **Entrada de datos:**
   - Para los programas `mayor.asm` y `menor.asm`, ingresa dos números enteros cuando se te solicite.
   - Para el programa `fibonacci.asm`, ingresa el número de términos de la serie de Fibonacci que deseas generar.

## Funcionamiento de los Programas

### `mayor.asm`
Este programa solicita al usuario que ingrese dos números enteros. Después de comparar ambos números, imprime el número mayor en la consola.

### `menor.asm`
Este programa solicita al usuario que ingrese dos números enteros. Después de comparar ambos números, imprime el número menor en la consola.

### `fibonacci.asm`
Este programa genera la serie de Fibonacci hasta el número de términos especificado por el usuario. También calcula la suma de todos los términos generados y la imprime en la consola.

**Ejemplo de ejecución:**
```
Ingrese el numero de Fibonacci a generar : 5
Fibonacci serie         : 0, 1, 1, 2, 3, 5
Suma de Fibonacci serie : 12
```

## Notas Adicionales

- **Validación de Entrada:** El programa `fibonacci.asm` incluye una validación para asegurar que el usuario ingrese un número mayor a 0.
- **Limitaciones:** Los programas `mayor.asm` y `menor.asm` están diseñados para comparar solo dos números. Se pueden extender fácilmente para manejar más entradas.
  
## Contribuciones

Si deseas mejorar estos programas o añadir nuevas funcionalidades, siéntete libre de hacer un fork del repositorio y enviar un pull request. Toda contribución es bienvenida.

## Licencia

Este proyecto está bajo la Licencia MIT. Puedes ver más detalles en el archivo `LICENSE` incluido en el repositorio.

## Contacto

Para cualquier pregunta o comentario, no dudes en contactar al autor a través de [tu-email@example.com](mailto:tu-email@example.com).
