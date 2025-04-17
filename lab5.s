.global main

.section .data
name: .asciz "Cut-It-Up Saw\n"
cut: .asciz "Linear length of boards cut so far: %d inches\n"
infot: .asciz "\nBoards cut so far: %d \n"
info: .asciz "Current Board Lengths:\n"
item1: .asciz "One: %d inches\n"
item2: .asciz "two: %d inches\n"
item3: .asciz "Three: %d inches\n"
prompt: .asciz "length (6-144): "
not_enough: .asciz "Not enough wood.\n"
error: .asciz "Please enter a valid input.\n"
term: .asciz "Inventory levels have dropped below minimum levels and will now terminate. Waste is %d inches.\n"
fmt: .asciz "%d"
one: .int 144
two: .int 144
three: .int 144
req: .int 0
length: .int 0
total: .int 0


.section .text

main:
    ldr r0, =name
    BL printf
    B loop

display:
    MOV r11, lr	

    ldr r1, =total
    ldr r1, [r1]
    ldr r0, =infot
    BL printf

    ldr r1, =length
    ldr r1, [r1]
    ldr r0, =cut
    BL printf

    ldr r0, =info
    BL printf

    ldr r1, =one
    ldr r1, [r1]
    ldr r0, =item1
    BL printf

    ldr r1, =two
    ldr r1, [r1]
    ldr r0, =item2
    BL printf

    ldr r1, =three
    ldr r1, [r1]
    ldr r0, =item3
    BL printf

    MOV pc, r11

input:
    MOV r11, lr
retry:
    ldr r0, =prompt
    BL printf

    ldr r0, =fmt
    ldr r1, =req
    BL scanf

    CMP r0, #1
    BNE input_error

    ldr r1, =req
    ldr r1, [r1]

    CMP r1, #6
    BLT input_error

    CMP r1, #144
    BGT input_error

    MOV pc, r11

input_error:
    ldr r0, =error
    BL printf
    B retry

calculate:
    MOV r11, lr

    ldr r8, [r0]

    ldr r9, =req
    ldr r9, [r9]

    MOV r1, #0

    CMP r8, r9
    MOVLT pc, lr

    SUB r8, r8, r9
    STR r8, [r0]

    ldr r10, =total
    ldr r8, [r10]
    ADD r8, r8, #1
    STR r8, [r10]

    ldr r10, =length
    ldr r8, [r10]
    ADD r8, r8, r9
    STR r8, [r10]

    MOV r1, #1

    MOV pc, r11

loop:
    BL display
    BL input

    ldr r0, =one
    BL calculate

    CMP r1, #1
    BEQ loop

    ldr r0, =two
    BL calculate

    CMP r1, #1
    BEQ loop

    ldr r0, =three
    BL calculate

    CMP r1, #1
    BEQ loop

    LDR r0, =not_enough
    BL printf

    ldr r8, =one
    ldr r8, [r8]
    CMP r8, #5
    BGT loop 

    ldr r8, =two
    ldr r8, [r8]
    CMP r8, #5
    BGT loop  

    ldr r8, =three
    ldr r8, [r8]
    CMP r8, #5
    BGT loop  

    B end

end:
    BL display

    MOV r8, #0
    LDR r9, =one
    LDR r9, [r9]
    ADD r8, r8, r9

    LDR r9, =two
    LDR r9, [r9]
    ADD r8, r8, r9

    LDR r9, =three
    LDR r9, [r9]
    ADD r8, r8, r9

    ldr r0, =term
    MOV r1, r8
    BL printf

    MOV r7, #1
    MOV r0, #0
    SVC #0


    
