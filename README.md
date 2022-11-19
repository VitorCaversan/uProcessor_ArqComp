# uProcessor_ArqComp

Making a micro processor from scratch using vhdl language.
Authors: João Vitor Caversan dos Passos and Leonardo Bueno Fischer.
Contact: joaopassos@alunos.utfpr.edu.br

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

The outputs of the register bank were connected to the inputs of the ALU, and the ALU's output was connected to the register bank *data_in* input. The only addition in the hole system was a multiplexor put between the __b__ register output and the ALU's __b__ input. It is responsible to choose among 4 different options for the ALU's __b__ input, that will later be used.


## Making a simple uProcessor

This microprocessor has the following components:

 - Program counter (PC);
 - Read only memory (ROM);
 - An instruction register;
 - Register bank;
 - Arithmetic Logic Unit (ALU);
 - Control Unit (CU);
 - Flags to signalize conditions.

At this point, **the hole project has been changed**, all of those components were created beforehand but there was no time to register what was done, so you'll have to trust the creators that it simply works.

**Word Width specifications:**
 - Instructions, register bank and ula: 15 bits width;
 - PC: 7 bits width (there are only 128 memory slots in the ROM at this time).

### Instructions coded:

Some meanings:

 - rs : source register;
 - rd : destination register;
 - sm : shift amount, not used in this project;
 - rcc: register for comparison;
 - d  : offset;

**Type R instructions:**

| Instruction | Opcode |   rd   |   rs   |   sm   | Function |     Description     |    Syntax    |
|-------------|--------|--------|--------|--------|----------|---------------------|--------------|
| add         | 000    | 3 bits | 3 bits | 3 bits | 001      | rd <= rd + rs       | add $rd,$rs  |
| sub         | 000    | 3 bits | 3 bits | 3 bits | 010      | rd <= rd - rs       | sub $rd,$rs  |
| move        | 000    | 3 bits | 3 bits | 3 bits | 100      | rd <= rs            | move $rd,$rs |
|             |  ''    |   ''   |   ''   |   ''   | 110      | rd <= M[rs]         | move $rd,#$rs|
|             |  ''    |   ''   |   ''   |   ''   | 111      | M[rd] <= rs         | move #$rd,$rs|
| cmp         | 000    | 3 bits | 3 bits | 3 bits | 101      | rd - rs             | cmp $rd,$rs  |

**Type I instructions:**

| Instruction | Opcode |   rd   |  Immediate |         Description                     |        Syntax       |
|-------------|--------|--------|------------|-----------------------------------------|---------------------|
| addi        | 001    | 3 bits |  9 bits    | rd <= rd + Immediate                    | addi $rd,immediate  |
| moveq       | 010    | 3 bits |  9 bits    | rd <= Immediate                         | moveq $rd,immediate |

Branch Instructions

| Instruction | Opcode | Unused bits |     d     |                       Description                          | Syntax |
|-------------|--------|-------------|-----------|------------------------------------------------------------|--------|
| beq         | 100    |    5 bits   |  7 bits   | if (equalFlag = 1) then [PC] = [PC] + d                    |  beq d |
| blt         | 101    |    5 bits   |  7 bits   | if (equalFlag = 0 and greaterFlag = 0) then [PC] = [PC] + d|  blt d |
| bra         | 110    |    5 bits   |  7 bits   | [PC] = [PC] + d                                            |  bra d |

**Type J instructions:**

| Instruction | Opcode | Unused bits |   Immediate   |    Description   |    Syntax      |
|-------------|--------|-------------|---------------|------------------|----------------|
| jump        | 111    |    5 bits   |    7 bits     | [PC] = Immediate | jump immediate |

### How branching works

It works by using a relative jump when a condition is met. This condition is based on a comparison done beforehand when using the cmp instruction.

The cmp instruction simply subtracts a register value from another, only to signalize (using some alu's outputs and putting those in flags) rather a value is greater or equal to the other. With both this flags, all comparisons can be done, so that branching can happen.