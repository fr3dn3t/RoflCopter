

    /*
     *  MatrixMath.h Library for Matrix Math
     *
     *  Created by Charlie Matlack on 12/18/10.
     *  Modified from code by RobH45345 on Arduino Forums, algorithm from
     *  NUMERICAL RECIPES: The Art of Scientific Computing.
     */
     
    #ifndef MatrixMath_h
    #define MatrixMath_h
     
    #if defined(ARDUINO) && ARDUINO >= 100
    #include "Arduino.h"
    #else
    #include "WProgram.h"
    #endif
     
    class MatrixMath
    {
    public:
        //MatrixMath();
        void Print(float* A, int m, int n, String label);
        void Copy(float* A, int n, int m, float* B);
        void Multiply(float* A, float* B, int m, int p, int n, float* C);
        void Add(float* A, float* B, int m, int n, float* C);
        void Subtract(float* A, float* B, int m, int n, float* C);
        void Transpose(float* A, int m, int n, float* C);
        void Scale(float* A, int m, int n, float k);
        int Invert(float* A, int n);
    };
     
    extern MatrixMath Matrix;
    #endif

[Get Code]

MatrixMath.cpp

    /*
     *  MatrixMath.cpp Library for Matrix Math
     *
     *  Created by Charlie Matlack on 12/18/10.
     *  Modified from code by RobH45345 on Arduino Forums, algorithm from
     *  NUMERICAL RECIPES: The Art of Scientific Computing.
     */
     
    #include "MatrixMath.h"
     
    #define NR_END 1
     
    MatrixMath Matrix;          // Pre-instantiate
     
    // Matrix Printing Routine
    // Uses tabs to separate numbers under assumption printed float width won't cause problems
    void MatrixMath::Print(float* A, int m, int n, String label){
        // A = input matrix (m x n)
        int i,j;
        Serial.println();
        Serial.println(label);
        for (i=0; i<m; i++){
            for (j=0;j<n;j++){
                Serial.print(A[n*i+j]);
                Serial.print("\t");
            }
            Serial.println();
        }
    }
     
    void MatrixMath::Copy(float* A, int n, int m, float* B)
    {
        int i, j, k;
        for (i=0;i<m;i++)
            for(j=0;j<n;j++)
            {
                B[n*i+j] = A[n*i+j];
            }
    }
     
    //Matrix Multiplication Routine
    // C = A*B
    void MatrixMath::Multiply(float* A, float* B, int m, int p, int n, float* C)
    {
        // A = input matrix (m x p)
        // B = input matrix (p x n)
        // m = number of rows in A
        // p = number of columns in A = number of rows in B
        // n = number of columns in B
        // C = output matrix = A*B (m x n)
        int i, j, k;
        for (i=0;i<m;i++)
            for(j=0;j<n;j++)
            {
                C[n*i+j]=0;
                for (k=0;k<p;k++)
                    C[n*i+j]= C[n*i+j]+A[p*i+k]*B[n*k+j];
            }
    }
     
     
    //Matrix Addition Routine
    void MatrixMath::Add(float* A, float* B, int m, int n, float* C)
    {
        // A = input matrix (m x n)
        // B = input matrix (m x n)
        // m = number of rows in A = number of rows in B
        // n = number of columns in A = number of columns in B
        // C = output matrix = A+B (m x n)
        int i, j;
        for (i=0;i<m;i++)
            for(j=0;j<n;j++)
                C[n*i+j]=A[n*i+j]+B[n*i+j];
    }
     
     
    //Matrix Subtraction Routine
    void MatrixMath::Subtract(float* A, float* B, int m, int n, float* C)
    {
        // A = input matrix (m x n)
        // B = input matrix (m x n)
        // m = number of rows in A = number of rows in B
        // n = number of columns in A = number of columns in B
        // C = output matrix = A-B (m x n)
        int i, j;
        for (i=0;i<m;i++)
            for(j=0;j<n;j++)
                C[n*i+j]=A[n*i+j]-B[n*i+j];
    }
     
     
    //Matrix Transpose Routine
    void MatrixMath::Transpose(float* A, int m, int n, float* C)
    {
        // A = input matrix (m x n)
        // m = number of rows in A
        // n = number of columns in A
        // C = output matrix = the transpose of A (n x m)
        int i, j;
        for (i=0;i<m;i++)
            for(j=0;j<n;j++)
                C[m*j+i]=A[n*i+j];
    }
     
    void MatrixMath::Scale(float* A, int m, int n, float k)
    {
        for (int i=0; i<m; i++)
            for (int j=0; j<n; j++)
                A[n*i+j] = A[n*i+j]*k;
    }
     
     
    //Matrix Inversion Routine
    // * This function inverts a matrix based on the Gauss Jordan method.
    // * Specifically, it uses partial pivoting to improve numeric stability.
    // * The algorithm is drawn from those presented in
    //   NUMERICAL RECIPES: The Art of Scientific Computing.
    // * The function returns 1 on success, 0 on failure.
    // * NOTE: The argument is ALSO the result matrix, meaning the input matrix is REPLACED
    int MatrixMath::Invert(float* A, int n)
    {
        // A = input matrix AND result matrix
        // n = number of rows = number of columns in A (n x n)
        int pivrow;     // keeps track of current pivot row
        int k,i,j;      // k: overall index along diagonal; i: row index; j: col index
        int pivrows[n]; // keeps track of rows swaps to undo at end
        float tmp;      // used for finding max value and making column swaps
     
        for (k = 0; k < n; k++)
        {
            // find pivot row, the row with biggest entry in current column
            tmp = 0;
            for (i = k; i < n; i++)
            {
                if (abs(A[i*n+k]) >= tmp)   // 'Avoid using other functions inside abs()?'
                {
                    tmp = abs(A[i*n+k]);
                    pivrow = i;
                }
            }
     
            // check for singular matrix
            if (A[pivrow*n+k] == 0.0f)
            {
                Serial.println("Inversion failed due to singular matrix");
                return 0;
            }
     
            // Execute pivot (row swap) if needed
            if (pivrow != k)
            {
                // swap row k with pivrow
                for (j = 0; j < n; j++)
                {
                    tmp = A[k*n+j];
                    A[k*n+j] = A[pivrow*n+j];
                    A[pivrow*n+j] = tmp;
                }
            }
            pivrows[k] = pivrow;    // record row swap (even if no swap happened)
     
            tmp = 1.0f/A[k*n+k];    // invert pivot element
            A[k*n+k] = 1.0f;        // This element of input matrix becomes result matrix
     
            // Perform row reduction (divide every element by pivot)
            for (j = 0; j < n; j++)
            {
                A[k*n+j] = A[k*n+j]*tmp;
            }
     
            // Now eliminate all other entries in this column
            for (i = 0; i < n; i++)
            {
                if (i != k)
                {
                    tmp = A[i*n+k];
                    A[i*n+k] = 0.0f;  // The other place where in matrix becomes result mat
                    for (j = 0; j < n; j++)
                    {
                        A[i*n+j] = A[i*n+j] - A[k*n+j]*tmp;
                    }
                }
            }
        }
     
        // Done, now need to undo pivot row swaps by doing column swaps in reverse order
        for (k = n-1; k >= 0; k--)
        {
            if (pivrows[k] != k)
            {
                for (i = 0; i < n; i++)
                {
                    tmp = A[i*n+k];
                    A[i*n+k] = A[i*n+pivrows[k]];
                    A[i*n+pivrows[k]] = tmp;
                }
            }
        }
        return 1;
    }
     

[Get Code]

Example code demonstrating usage:

     
    #include <MatrixMath.h>
     
     
    #define N  (2)
     
    float A[N][N];
    float B[N][N];
    float C[N][N];
    float v[N];      // This is a row vector
    float w[N];
     
    float max = 10;  // maximum random matrix entry range
     
    void setup() {
        Serial.begin(9600);
     
            // Initialize matrices
            for (int i = 0; i < N; i++)
            {
              v[i] = i+1;                    // vector of sequential numbers
              for (int j = 0; j < N; j++)
              {
                A[i][j] = random(max) - max/2.0f;  // A is random
                if (i == j)
                {
                  B[i][j] = 1.0f;                  // B is identity
                } else
                {
                  B[i][j] = 0.0f;
                }
              }
            }
     
    }
     
    void loop(){
     
      Matrix.Multiply((float*)A,(float*)B,N,N,N,(float*)C);
     
            Serial.println("\nAfter multiplying C = A*B:");
        Matrix.Print((float*)A,N,N,"A");
     
        Matrix.Print((float*)B,N,N,"B");
        Matrix.Print((float*)C,N,N,"C");
            Matrix.Print((float*)v,N,1,"v");
     
            Matrix.Add((float*) B, (float*) C, N, N, (float*) C);
            Serial.println("\nC = B+C (addition in-place)");
            Matrix.Print((float*)C,N,N,"C");
            Matrix.Print((float*)B,N,N,"B");
     
            Matrix.Copy((float*)A,N,N,(float*)B);
            Serial.println("\nCopied A to B:");
        Matrix.Print((float*)B,N,N,"B");
     
            Matrix.Invert((float*)A,N);
            Serial.println("\nInverted A:");
        Matrix.Print((float*)A,N,N,"A");
     
            Matrix.Multiply((float*)A,(float*)B,N,N,N,(float*)C);
            Serial.println("\nC = A*B");
        Matrix.Print((float*)C,N,N,"C");
     
            // Because the library uses pointers and DIY indexing,
            // a 1D vector can be smoothly handled as either a row or col vector
            // depending on the dimensions we specify when calling a function
            Matrix.Multiply((float*)C,(float*)v,N,N,1,(float*)w);
            Serial.println("\n C*v = w:");
            Matrix.Print((float*)v,N,1,"v");
            Matrix.Print((float*)w,N,1,"w");
     
    while(1);
    }

