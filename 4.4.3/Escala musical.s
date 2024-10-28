.set    GPBASE,   0x20200000
.set    GPFSEL0,  0x00
.set    GPSET0,   0x1c
.set    GPCLR0,   0x28
.set    STBASE,   0x20003000
.set    STCLO,    0x04
.text
        ldr     r0, =GPBASE                 @ Dirección base GPIO
        mov     r1, #0x1000                 @ Configura GPIO 4 como salida
        str     r1, [r0, #GPFSEL0]          @ Establece GPIO 4 como salida
        mov     r1, #0x10                   @ Valor para encender/apagar GPIO 4
        ldr     r2, =STBASE                 @ Dirección del contador

bucle:  bl      espera                      @ Llama a la espera
        str     r1, [r0, #GPSET0]           @ Enciende el LED
        bl      espera                      @ Llama a la espera
        str     r1, [r0, #GPCLR0]           @ Apaga el LED
        b       bucle                       @ Repite indefinidamente

/* Rutina de espera (1136 microsegundos) */
espera: ldr     r3, [r2, #STCLO]            @ Lee contador
        add     r4, r3, #1136               @ Ajusta el tiempo de espera
ret1:   ldr     r3, [r2, #STCLO]
        cmp     r3, r4                      @ Espera hasta alcanzar el valor r4
        bne     ret1                        @ Si no, sigue esperando
        bx      lr                          @ Regresa al bucle
