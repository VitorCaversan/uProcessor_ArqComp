# uProcessor_ArqComp

Making a micro processor from scrach using vhdl language

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

For the output, four operations were made. The selector chooses wich operation is to be done:
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
    - __data_in__: 16-bit size;
    - write_en to enable a reg. to be written;
    - clk that recieves the clock pulses;
    - reset: a asynchronous reset input.

 - Outputs:
    - A 16-bit sized output for each value of the selected register.

Their relation is self explanatory. Each selector selects registers for a certain task. __data_in__ recieves the value to be written in some register, and it only happens when __write_en__ is enabled.

For the outputs we have the desired register values.

### The beginnings of the microProcessor

It was nedded to unite the ALU with the register bank, and so the micrProcessor was born.

The outputs of the register bank were connected to the inputs of the ALU, and the ALU's output was connected to the register bank __data_in__ input. The only addition in the hole system was a multiplexor put between the __b__ register output and the ULA's __b__ input. It is responsible to choose among 4 different options for the ULA's __b__ input, that will later be used. 