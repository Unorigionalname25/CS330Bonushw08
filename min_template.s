.data
A: .quad 0 
printString:    .string "%d\n"
printString2: .string "Your sequence is:\n"
invalidPstring: .string "Your input is too low. Only the first two #'s of the sequence was printed\n"

inputString: .string "please input how many numbers of the sequence you want to see: \n"


scanString: .string "%d"

.text
.global main

# Fibonacci function
fibonacci:
    # Input:  %rdi - n (current Fibonacci number to calculate)
    # Output: %rax - Fibonacci(n)

    movq $printString2, %rdi
    xor %rax, %rax
    call printf

    # This block prints the first two outputs of fibb
    movq $printString, %rdi
    movq $0, %rsi
    xor %rax, %rax
    call printf
    movq $printString, %rdi
    movq $1, %rsi
    xor %rax, %rax
    call printf


    # Variables saved under registers with callee saving in mind
    movq $0, %rdi # int x = 0
    movq $1, %rsi # int y = 1
    movq A, %r14 # int n = userinput
    movq $2, %r15 # counter

    cmpq %r14, %r15 #checks to see if the input was invalid
    jg invalid

    cmpq %r14, %r15 #checks to see if the number of printed values matches the requested sequence
    jne L1 #jump to loop

    ret

    invalid: #this function is to handle inputs from 0-1 which would break the code 

    movq $invalidPstring, %rdi
    xor %rax, %rax
    call printf

    ret

    L1:
    movq %rsi, %r12 #relocate y to a callee saved register
    addq %rdi, %rsi # x + y = i

    incq %r15  # Increment the counter

    movq %rsi, %r13 #relocate x+y

    movq $printString, %rdi
    xor %rax, %rax
    call printf

    movq %r12, %rdi
    movq %r13, %rsi

    cmpq %r14, %r15
    jne L1

    ret

main:
    # preamble
    pushq %rbp
    movq %rsp, %rbp

    # === code here ===

    # get user input

    movq $inputString, %rdi
    xor %rax, %rax
    call printf

    movq $scanString, %rdi
    movq $A, %rsi
    xor %rax, %rax
    call scanf

    # run Fibb using user input

    call fibonacci   # Call Fibonacci function

    # postamble
    popq %rbp
    ret
