.global main

.section .data
prompt: .asciz "Enter a number from 0 to 100.\n"
confirm: .asciz "You entered %d\n"
resulte: .asciz "The even numbers from 1 to %d are:\n"
resulto: .asciz "The odd numbers from 1 to %d are:\n"
sum: .asciz "The sum is: %d"
end: .asciz "Program Terminated."
out: .asciz "%d\n"
fmt: .asciz "%d"
num: .int 0

.section .text

main:
    ldr r0, =prompt
    BL printf

    ldr r0, =fmt
    ldr r1, =num
    BL scanf

    CMP r0, #1
    BEQ even

    ldr r1, =num
    ldr r1, [r1]
    CMP r1, #100
    BLT even

    B end

even:
    MOV r9, #2
    MOV r10, #0

    ldr r8, =num
    ldr r8, [r8]

    ldr r0, =resulte
    MOV r1, r8
    BL printf

even_loop:
    CMP r9, r8
    BGT even_sum

    ldr r0, =out
    MOV r1, r9
    BL printf

    ADD r10, r10, r9
    ADD r9, r9, #2

    B even_loop

even_sum:
    ldr r0, =sum
    MOV r1, r10
    BL printf

    B odd

odd:
    MOV r9, #1
    MOV r10, #0

    ldr r8, =num
    ldr r8, [r8]

    ldr r0, =resulto
    MOV r1, r8
    BL printf

odd_loop:
    CMP r9, r8
    BGT odd_sum

    ldr r0, =out
    MOV r1, r9
    BL printf

    ADD r10, r10, r9
    ADD r9, r9, #2

    B odd_loop

odd_sum:
    ldr r0, =sum
    MOV r1, r10
    BL printf

    B end

end:
    ldr r0, =end
    BL printf

    MOV r7, #1
    MOV r0, #0
    SVC #0