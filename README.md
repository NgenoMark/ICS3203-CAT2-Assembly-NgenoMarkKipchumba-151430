# ICS3203-CAT2-Assembly-NgenoMarkKipchumba-151430

## Overview
This repository contains assembly programs for four practical tasks as part of CAT 2. Each task demonstrates core assembly language concepts such as control flow, looping, subroutines, and memory manipulation.

---

## Task Descriptions

### Task 1: Control Flow and Conditional Logic
- **File:** `task1_control_flow.asm`
- **Purpose:** Classifies a number as POSITIVE, NEGATIVE, or ZERO using conditional and unconditional jumps.
- **Instructions:**
  1. Compile using: `nasm -f elf32 task1_control_flow.asm -o task1_control_flow.o`
  2. Link using: `ld -m elf_i386 task1_control_flow.o -o task1_control_flow`
  3. Run using: `./task1_control_flow`

### Task 2: Array Manipulation with Looping and Reversal
- **File:** `task2_array_reversal.asm`
- **Purpose:** Accepts an array of integers, reverses it in place, and outputs the result.
- **Instructions:**
  1. Compile using: `nasm -f elf32 task2_array_reversal.asm -o task2_array_reversal.o`
  2. Link using: `ld -m elf_i386 task2_array_reversal.o -o task2_array_reversal`
  3. Run using: `./task2_array_reversal`

### Task 3: Modular Program with Subroutine
- **File:** `task3_factorial_subroutine.asm`
- **Purpose:** Computes the factorial of a number using a subroutine and stack for register preservation.
- **Instructions:**
  1. Compile using: `nasm -f elf32 task3_factorial_subroutine.asm -o task3_factorial_subroutine.o`
  2. Link using: `ld -m elf_i386 task3_factorial_subroutine.o -o task3_factorial_subroutine`
  3. Run using: `./task3_factorial_subroutine`

### Task 4: Data Monitoring and Control
- **File:** `task4_data_monitoring.asm`
- **Purpose:** Simulates a water level control program with actions based on sensor input.
- **Instructions:**
  1. Compile using: `nasm -f elf32 task4_data_monitoring.asm -o task4_data_monitoring.o`
  2. Link using: `ld -m elf_i386 task4_data_monitoring.o -o task4_data_monitoring`
  3. Run using: `./task4_data_monitoring`

---

## Challenges and Insights
- Task 1: Understanding the difference between conditional and unconditional jumps.
- Task 2: Reversing an array in place without additional memory.
- Task 3: Managing the stack for modular programming.
- Task 4: Simulating hardware control in assembly.

---

## Notes
- Ensure you have NASM installed: `sudo apt install nasm`
- The programs are tested on Linux systems with ELF32 format.
