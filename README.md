# ARMv7.RegisterContentsDecimal
ARMv7 assembly that outputs the contents of a register in decimal 
# Language information 
This program has been written in ARMv7 assembly language as on the Raspberry Pi. These can be purchased online for around £10-30. The starter set can be purchased for approximately £50.
# How to run
## Method 1 
1. Download or clone this GitHub repository 
2. (If downloaded) Extract the zip archive
3. Compile the .s file
```
as –o model.o model.s
```
4. Link the .o file(s)
- For a single .o file
```
ld –o model model.o
```
- For multiple files
```
ld –o model model.o myotherfile.o
```
5. Run the program 
```
./model
```
6. Display Register 0
```
echo $?
```
## Method 2
1. Download or clone this GitHub repository 
2. (If downloaded) Extract the zip archive
3. Run the program 
```
./model
```
4. Display Register 0
```
echo $?
```
# Debug the program 
1. Compile the .s file 
```
as –g –o model.o model.s
```
2. Link the .o files (as above) 
```
ld –o model model.o
```
3. Debug the program with 
```
gdb model
```
## Noteworthy commands
- List the next 10 lines: l
- Set breakpoint: b [line number]
- Run the program: r
- Continue to the next breakpoint: c
- Output register values: i r
- Run next line only: s
- Help: h
- Quit: q
