.set    GPBASE,   0x20200000
.set    GPFSEL0,  0x00
.set    GPSET0,   0x1c
.set    GPCLR0,   0x28
.text
        ldr     r0, =GPBASE               @ Dirección base GPIO
        mov     r1, #0x20000000           @ Configura GPIO 9 como salida
        str     r1, [r0, #GPFSEL0]        @ Establece GPIO 9

bucle:  mov     r2, #7000000              @ Retardo encendido
ret1:   subs    r2, #1                    
        bne     ret1
        str     r1, [r0, #GPSET0]         @ LED encendido

        mov     r2, #7000000              @ Retardo apagado
ret2:   subs    r2, #1
        bne     ret2
        str     r1, [r0, #GPCLR0]         @ LED apagado

        b       bucle                     @ Repite indefinidamente
