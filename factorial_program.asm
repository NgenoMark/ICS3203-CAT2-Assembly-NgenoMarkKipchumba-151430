section .data
    prompt_input db "Enter a non-negative integer: ", 0
    result_msg db "Factorial: ", 0
    error_msg db "Invalid input! Please enter a valid non-negative integer.", 0
    input_too_large_msg db "Input too large. Enter a number less than or equal to 12.", 0
    newline db 0xA, 0


section .bss
    user_input resb 10         ; Reserve space for user input (10 bytes to handle larger numbers)
    factorial_result resd 1    ; Reserve space for factorial result

section .text
    global _start

_start:
    ; Print input prompt
    mov eax, 4               ; syscall: write
    mov ebx, 1               ; file descriptor: stdout
    mov ecx, prompt_input    ; pointer to message
    mov edx, 30              ; message length
    int 0x80

    ; Read user input
    mov eax, 3               ; syscall: read
    mov ebx, 0               ; file descriptor: stdin
    mov ecx, user_input      ; buffer to store input
    mov edx, 10              ; buffer length (max 10 characters for input)
    int 0x80

    ; Convert input to integer (check for valid numeric input)
    mov esi, user_input      ; pointer to input buffer
    xor eax, eax             ; clear eax (for storing result)
    xor ecx, ecx             ; clear ecx (for digit)
parse_input:
    movzx ecx, byte [esi]    ; load byte (character)
    cmp ecx, 0xA             ; check for newline character (Enter key)
    je validate_input
    cmp ecx, '0'
    jl invalid_input         ; if less than '0', invalid character
    cmp ecx, '9'
    jg invalid_input         ; if greater than '9', invalid character
    sub ecx, '0'             ; convert ASCII to integer
    imul eax, eax, 10        ; shift left by 10 (decimal place)
    add eax, ecx             ; add digit to result
    inc esi                  ; move to next character
    jmp parse_input

validate_input:
    ; Validate input (non-negative check)
    cmp eax, 0
    jl exit_program          ; if negative, exit program

    ; Check if input is too large (factorial of numbers greater than 12 is too large)
    cmp eax, 12
    jg input_too_large       ; exit if input is greater than 12

    ; Store input number for factorial calculation
    push eax                 ; push input onto stack
    call factorial           ; call the factorial subroutine
    add esp, 4               ; clean up the stack

    ; Store the result in memory
    mov [factorial_result], eax

    ; Print result message
    mov eax, 4               ; syscall: write
    mov ebx, 1               ; file descriptor: stdout
    mov ecx, result_msg      ; pointer to message
    mov edx, 10              ; message length
    int 0x80

    ; Print factorial result (convert to string)
    mov eax, [factorial_result] ; load the result in eax
    call print_integer       ; print the integer

    ; Exit program
    jmp exit_program

invalid_input:
    ; Print error message for invalid input
    mov eax, 4               ; syscall: write
    mov ebx, 1               ; file descriptor: stdout
    mov ecx, error_msg       ; pointer to error message
    mov edx, 44              ; message length
    int 0x80
    jmp exit_program

input_too_large:
    ; Print message for input too large
    mov eax, 4               ; syscall: write
    mov ebx, 1               ; file descriptor: stdout
    mov ecx, input_too_large_msg   ; pointer to error message
    mov edx, 47              ; message length
    int 0x80
    jmp exit_program


exit_program:
    mov eax, 1               ; syscall: exit
    xor ebx, ebx             ; return code 0
    int 0x80

; Subroutine: Factorial Calculation
factorial:
    ; Get the input number (argument)
    push ebp                 ; Save base pointer
    mov ebp, esp             ; Set base pointer to current stack
    mov eax, [ebp + 8]       ; Get input number (argument)

    cmp eax, 1               ; Base case: if n <= 1, return 1
    jle factorial_base_case  ; Jump to base case if n <= 1

    ; Recursive case: n * factorial(n-1)
    push eax                 ; Save current n on stack
    dec eax                  ; Decrement n by 1
    push eax                 ; Push (n-1) as argument for the next factorial call
    call factorial           ; Recursive call
    add esp, 4               ; Clean up the stack after return

    pop ebx                  ; Restore original n from the stack
    imul eax, ebx            ; Multiply n * factorial(n-1)
    jmp factorial_end        ; Jump to end of the function

factorial_base_case:
    mov eax, 1               ; Return 1 for n <= 1

factorial_end:
    mov esp, ebp             ; Restore stack pointer
    pop ebp                  ; Restore base pointer
    ret                      ; Return to caller


; Subroutine: Print Integer as String
print_integer:
    ; Convert integer in EAX to ASCII and print it
    ; We use a simple loop to extract digits and print them
    push eax                 ; save eax
    mov ecx, 10              ; divisor for mod 10 (get digits)
    xor ebx, ebx             ; clear ebx (for remainder)
    mov edx, 0               ; clear edx (quotient)
    print_digits:
        div ecx              ; divide eax by 10
        add dl, '0'          ; convert remainder to ASCII
        push dx              ; push digit onto stack
        test eax, eax        ; check if quotient is zero
        jnz print_digits     ; if not, continue dividing

    ; Print digits in reverse order (from stack)
    print_loop:
        pop dx
        mov eax, 4           ; syscall: write
        mov ebx, 1           ; file descriptor: stdout
        mov ecx, esp         ; pointer to digit
        mov edx, 1           ; length of one byte
        int 0x80
        loop print_loop      ; repeat for all digits

    pop eax                  ; restore eax
    ret
