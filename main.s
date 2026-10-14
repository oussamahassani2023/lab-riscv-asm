# Lab 1, variant 10: find the row with the maximum sum of elements (N = 6, M = 6)
# Function ABI: a0 = array address, a1 = rows (N), a2 = cols (M)
#               returns a0 = row index, a1 = max sum

.data
matrix:
    .word  1,  2,  3,  4,  5,  6
    .word -5,  8, -2,  7,  0,  3
    .word 10, -4,  6,  9, -1,  2
    .word  9,  9,  8,  7, 10, 12
    .word -9, -8, -7, -6, -5, -4
    .word 12,  3, -6,  5,  8, 11
msg_row: .asciiz "Row with max sum: "
msg_sum: .asciiz "\nMax sum: "

.text
.globl main

main:
    la   a0, matrix          # arg 0: array address
    li   a1, 6               # arg 1: N (rows)
    li   a2, 6               # arg 2: M (columns)
    jal  ra, find_max_row    # a0 = index, a1 = sum

    mv   s0, a0              # keep results across ecalls
    mv   s1, a1

    li   a0, 4               # print_string
    la   a1, msg_row
    ecall
    li   a0, 1               # print_int (row index)
    mv   a1, s0
    ecall

    li   a0, 4
    la   a1, msg_sum
    ecall
    li   a0, 1
    mv   a1, s1
    ecall

    li   a0, 10              # exit
    ecall

# (int index, int sum) find_max_row(const int *arr, int rows, int cols)
# Leaf function: uses only caller-saved registers (t0-t5), so no stack frame.
find_max_row:
    li   t0, 0               # t0 = i (current row)
    li   t1, 0               # t1 = best row index
    lui  t2, 0x80000         # t2 = best sum = INT_MIN
row_loop:
    bge  t0, a1, done        # i >= rows -> finish
    li   t3, 0               # t3 = sum of current row
    li   t4, 0               # t4 = j
col_loop:
    bge  t4, a2, row_end     # j >= cols -> row finished
    lw   t5, 0(a0)           # t5 = arr element
    add  t3, t3, t5
    addi a0, a0, 4           # next element (row-major order)
    addi t4, t4, 1
    j    col_loop
row_end:
    bge  t2, t3, next_row    # if best >= sum: keep (first row wins ties)
    mv   t2, t3
    mv   t1, t0
next_row:
    addi t0, t0, 1
    j    row_loop
done:
    mv   a0, t1              # return index in a0
    mv   a1, t2              # return sum in a1
    ret
