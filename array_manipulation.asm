section .data
    prompt_input db "Enter 5 integers (space-separated): ", 0
    prompt_output db "Reversed Array: ", 0
    newline db 0xA, 0       ; Newline character
    error_msg db "Error: Invalid input.", 0xA, 0

section .bss
    array resd 5            ; Reserve space for 5 integers
    input_buffer resb 64    ; Input buffer for 64 characters

section .text
    global _start

_start:
    ; Print input prompt
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt_input
    mov edx, 34
    int 0x80

    ; Read input
    mov eax, 3
    mov ebx, 0
    mov ecx, input_buffer
    mov edx, 64
    int 0x80

    ; Parse input
    mov esi, input_buffer   ; Start of input buffer
    mov edi, array          ; Start of array
    xor ecx, ecx            ; Clear index counter

parse_input:
    lodsb                   ; Load next character
    cmp al, 0xA             ; Check for newline (end of input)
    je validate_array       ; Jump to validation if done
    cmp al, ' '             ; Check for space
    je next_number          ; If space, start next number

    ; Convert character to integer
    sub al, '0'             ; ASCII to integer
    jl error                ; Invalid character (non-digit)
    cmp al, 9
    jg error                ; Invalid character (non-digit)

    imul ecx, ecx, 10       ; Multiply current number by 10
    add ecx, eax            ; Add digit to number
    jmp parse_input

next_number:
    mov [edi], ecx          ; Store number in array
    add edi, 4              ; Move to next array element
    xor ecx, ecx            ; Reset number accumulator
    jmp parse_input

validate_array:
    mov eax, edi
    sub eax, array          ; Calculate total numbers parsed
    cmp eax, 20             ; 5 integers = 5 * 4 bytes
    jne error               ; If not, error

    ; Reverse array
    mov esi, array
    lea edi, [array + 16]
    mov ecx, 2              ; Half the number of elements (5/2)

reverse_loop:
    mov eax, [esi]
    mov ebx, [edi]
    mov [esi], ebx
    mov [edi], eax
    add esi, 4
    sub edi, 4
    loop reverse_loop

    ; Print output
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt_output
    mov edx, 15
    int 0x80

    ; Print reversed array
    mov esi, array
    mov ecx, 5

print_loop:
    mov eax, [esi]
    call print_integer
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80
    add esi, 4
    loop print_loop

    ; Exit program
    mov eax, 1
    xor ebx, ebx
    int 0x80

error:
    mov eax, 4
    mov ebx, 1
    mov ecx, error_msg
    mov edx, 22
    int 0x80
    jmp exit

print_integer:
    push eax
    xor ecx, ecx
    mov ebx, 10

.convert:
    xor edx, edx
    div ebx
    add dl, '0'
    push dx
    inc ecx
    test eax, eax
    jnz .convert

.print_digits:
    pop eax
    mov [esp-1], al
    mov eax, 4
    mov ebx, 1
    lea ecx, [esp-1]
    mov edx, 1
    int 0x80
    loop .print_digits

    add esp, ecx
    ret
