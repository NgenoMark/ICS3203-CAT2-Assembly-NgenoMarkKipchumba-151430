# ICS3203-CAT2-Assembly-NgenoMarkKipchumba-151430

## Overview
This repository contains assembly programs for four practical tasks as part of CAT 2. Each task demonstrates core assembly language concepts such as control flow, looping, subroutines, and memory manipulation.

---

## Task Descriptions

### Task 1: Control Flow and Conditional Logic
- **File:** `task1_control_flow.asm`
- **Purpose:** Classifies a number as POSITIVE, NEGATIVE, or ZERO using conditional and unconditional jumps.
- **Instructions:**
  1. Compile using: `nasm -f elf32 control_flow.asm -o control_flow.o`
  2. Link using: `ld -m elf_i386 control_flow.o -o control_flow`
  3. Run using: `./control_flow`

### Task 2: Array Manipulation with Looping and Reversal
- **File:** `array_manipulation.asm`
- **Purpose:** Accepts an array of integers, reverses it in place, and outputs the result.
- **Instructions:**
  1. Compile using: `nasm -f elf32 array_manipulation.asm -o array_manipulation.o`
  2. Link using: `ld -m elf_i386 array_manipulation.o -o array_manipulation`
  3. Run using: `./array_manipulation`

### Task 3: Modular Program with Subroutine
- **File:** `factorial_program.asm`
- **Purpose:** Computes the factorial of a number using a subroutine and stack for register preservation.
- **Instructions:**
  1. Compile using: `nasm -f elf32 factorial_program.asm -o factorial_program.o`
  2. Link using: `ld -m elf_i386 factorial_program.o -o factorial_program`
  3. Run using: `./factorial_program`
- **Challenges and Insights**
  The program failed to genearte the factorials of the number giving nothing or giving a " Floating point exception " error to mean that the number was being divided by 0

### Task 4: Data Monitoring and Control
- **File:** `data_monitoring.asm`
- **Purpose:** Simulates a water level control program with actions based on sensor input.
- **Instructions:**
  1. Compile using: `nasm -f elf32 data_monitoring.asm -o data_monitoring.o`
  2. Link using: `ld -m elf_i386 data_monitoring.o -o data_monitoring`
  3. Run using: `./data_monitoring`

---

## Challenges and Insights 
### Challenge Report:

#### Task 1: Understanding the Difference Between Conditional and Unconditional Jumps
This task was straightforward and no significant challenges were encountered.

#### Task 2: Reversing an Array in Place Without Additional Memory
- **Challenge Encountered**: 
  When testing the array manipulation program, it successfully handled a fixed set of five integers, such as `2 5 9 4 6`. However, when provided with other input formats (e.g., less than or more than five integers or invalid characters), the program failed to handle these cases gracefully.
  - **Error**: No explicit error handling was implemented for these edge cases, leading to potential crashes or unexpected behavior. The input format wasn't strictly validated.

#### Task 3: Managing the Stack for Modular Programming (Factorial Calculation)
- **Challenge Encountered**: 
  When running the factorial program with input like `3`, I encountered a "Floating point exception (core dumped)" error.
  - **Cause of Error**: The error likely occurred due to the improper handling of edge cases, such as negative inputs, or the program attempting an invalid operation (like division by zero or incorrect recursion base case). The program may also fail to handle non-integer inputs properly.
  - **Fix Required**: Proper input validation is necessary to check for non-integer values or negative numbers before the factorial computation proceeds. Additionally, reviewing how the stack is used in the factorial subroutine might be required to avoid stack-related issues or infinite recursion.

#### Task 4: Simulating Hardware Control in Assembly
There was no error encountered in this task .

---

**General Observations**:
- Both the array manipulation and factorial programs would benefit from improved input validation.
- The factorial program's error suggests that there may be issues in how the stack is managed, possibly due to improper restoration of registers or incorrect handling of recursive calls.


---

## Notes
- Ensure you have NASM installed: `sudo apt install nasm`
- The programs are tested on Linux systems with ELF32 format.
