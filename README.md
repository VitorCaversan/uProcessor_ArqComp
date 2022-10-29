# uProcessor_ArqComp

Making a micro processor from scratch using vhdl language

## Making the first ALU - Arithmetic Logic Unit

Our first ALU was made with the following settings:
 - Inputs:
    - Two numbers: 16-bit size;
    - A selector: 2-bit size.
 - Outputs:
    - One main output for the arithmetic results with the two input numbers;
    - a flag to show a=b;
    - a flag to show a>b;
    - a flag to show a<0;
    - a flag to show b<0;

For the output, four operations were made. The selector chooses which operation is to be done:
 - "00" = Sum: output <= a+b;
 - "01" = Subtraction: output <= a-b;
 - "10" = Concatenation of a's MSB with b's LSB;
 - "11" = Concatenation of b's MSB with a's LSB.


## Making a register bank and merging it with the ALU

First it was necessary to make a register itself. Each one was capable to be written, be read and to be reseted.

Then, the register bank was made with the following settings:
 - Inputs:
    - A selector for each register to be read: 3-bit size;
    - A selector for the register to be written: 3-bit size;
    - *data_in*: 16-bit size;
    - write_en to enable a reg. to be written;
    - clk that receives the clock pulses;
    - reset: a asynchronous reset input.

 - Outputs:
    - A 16-bit sized output for each value of the selected register.

Their relation is self explanatory. Each selector selects registers for a certain task. *data_in* receives the value to be written in some register, and it only happens when *write_en* is enabled.

For the outputs we have the desired register values.

### The beginnings of the microProcessor

It was needed to unite the ALU with the register bank, and so the microProcessor was born.

The outputs of the register bank were connected to the inputs of the ALU, and the ALU's output was connected to the register bank *data_in* input. The only addition in the hole system was a multiplexor put between the __b__ register output and the ULA's __b__ input. It is responsible to choose among 4 different options for the ULA's __b__ input, that will later be used.


## Making a simple uProcessor

This microprocessor has the following components:

 - Program counter (PC);
 - Read only memory (ROM);
 - An instruction register;
 - Register bank;
 - Arithmetic Logic Unit (ALU);
 - Control Unit (CU).

At this point, **the hole project has been changed**, all of those components were created beforehand but there was no time to register
what was done, so you'll have to trust the creators that it simply works.

**Word Width specifications:**
 - Instructions, register bank and ula: 15 bits width;
 - PC: 7 bits width (there are only 128 memory slots in the ROM at this time).

### Instructions coded:
**Type R instructions:**

| Instruction | Opcode |   rs   |   rt   |   rd   | Function |     Description     |
|-------------|--------|--------|--------|--------|----------|---------------------|
| add         | 000    | 3 bits | 3 bits | 3 bits | 001      | rd <= rs + rt       |
| sub         | 000    | 3 bits | 3 bits | 3 bits | 010      | rd <= rs - rt       |
| conc        | 000    | 3 bits | 3 bits | 3 bits | 011      | rd <= rsMSB & rtLSB |

**Type I instructions:**

| Instruction | Opcode |   rs   |   rt   | Immediate |     Description     |
|-------------|--------|--------|--------|-----------|---------------------|
| addi        | 001    | 3 bits | 3 bits | 6 bits    | rs <= rt + Immediate|

**Type J instructions:**

| Instruction | Opcode |   Immediate   |             Description             |
|-------------|--------|---------------|-------------------------------------|
| jump        | 111    | 9 bits        | Jumps to the Immediate mem position |
