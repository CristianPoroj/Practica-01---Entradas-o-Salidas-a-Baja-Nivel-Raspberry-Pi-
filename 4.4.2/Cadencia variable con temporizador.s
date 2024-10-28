.set    GPBASE,   0x20200000
.set    GPFSEL0,  0x00
.set    GPSET0,   0x1c
.set    GPCLR0,   0x28
.set    STBASE,   0x20003000
.set    STCLO,    0x04
.text
        ldr     r0, =GPBASE                 @ Dirección GPIO
        mov     r1, #0x20000000             @ Configura GPIO 9 como salida
        str     r1, [r0, #GPFSEL0]          @ Establece GPIO 9
        ldr     r1, =0x200                  @ Valor para encender/apagar GPIO 9
        ldr     r2, =STBASE                 @ Dirección del contador

bucle:  bl      espera                      @ Llama a la espera
        str     r1, [r0, #GPSET0]           @ LED encendido
        bl      espera                      @ Llama a la espera
        str     r1, [r0, #GPCLR0]           @ LED apagado
        b       bucle                       @ Repite indefinidamente

/* Rutina de espera de medio segundo */
espera: ldr     r3, [r2, #STCLO]            @ Lee contador
        add     r4, r3, #500000             @ Añade 500,000 (medio segundo)
ret1:   ldr     r3, [r2, #STCLO]
        cmp     r3, r4                      @ Compara hasta alcanzar r4
        bne     ret1                        @ Si no, sigue esperando
        bx      lr                          @ Retorna al bucle
