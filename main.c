#include <stdio.h>

#define N 6
#define M 6

/* Returns the index of the row with the maximum sum of elements.
 * The sum itself is written to *max_sum. On a tie, the first row wins. */
int find_max_row(const int *arr, int rows, int cols, int *max_sum)
{
    int best_idx = 0;
    int best_sum = -2147483647 - 1; /* INT_MIN */

    for (int i = 0; i < rows; i++) {
        int sum = 0;
        for (int j = 0; j < cols; j++)
            sum += arr[i * cols + j];
        if (sum > best_sum) {
            best_sum = sum;
            best_idx = i;
        }
    }
    *max_sum = best_sum;
    return best_idx;
}

int main(void)
{
    int matrix[N][M] = {
        {  1,  2,  3,  4,  5,  6 },
        { -5,  8, -2,  7,  0,  3 },
        { 10, -4,  6,  9, -1,  2 },
        {  9,  9,  8,  7, 10, 12 },
        { -9, -8, -7, -6, -5, -4 },
        { 12,  3, -6,  5,  8, 11 },
    };
    int sum;
    int row = find_max_row(&matrix[0][0], N, M, &sum);

    printf("Row with max sum: %d\nMax sum: %d\n", row, sum);
    return row;
}
