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