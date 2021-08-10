clear; clc;

A = rand(10,10); % create a 10 x 10 matrix from a uniform random distribution
B = rand(10,10); % and another;

C1 = A*B; % matrix multiplication (A+B,A-B are similar)
C2 = A.*B; % elementwise mult.
C3 = A./B; % elementwise divide (DIFFERENT from A/B)
C4 = sqrt(A); % elementwise square roots
C5 = sqrtm(A); % DIFFERENT from elementwise square root -> if C5 = A*A, then A = sqrtm(C5);
C6 = 1./A; % a matrix of ones divided ELEMENTWISE by A - different from inverse of A
C7 = A.^2; % elementwise squaring of A - DIFFERENT from A*A
C8 = A'; % transpose of a matrix

%%%%%%%%%%%%%%%%%%%%%%%%%%%%

av = rand(10,1); % column vector of 10 elements with random elements (10 x 1 matrix)
avv = rand(1,10); % row vector of 10 elements with random elements (1 x 10 matrix)
bv = rand(10,1); % another column vector

c1 = av.*bv; % multiplying two vector pointwise to produce another vector
c2 = av + bv; % adding two vectors (you could also deduct one from the other)
c3 = av./bv % divide each element of av by the corresponding element of bv
c4 = 1./av; % this produces a vector containing the reciprocal of every element in av
c5 = av.^2; % produces a vector containing the square of every element in av
c6 = av'; % converts a row vector to a column vector or vice versa (similar to matrix transpose)

c = dot(av,bv); % dot product of two vectors - they must be both row vectors or column vectors!

d = av(1:length(av)); % copy of av
d = av(:);  % same as above
d = av % same as above
d = av(1:2:length(av)); % create a new vector containing every second element of av - length of d is automatically adjusted!
d = av(1:3:length(av)); % same as above - but we took every third element
d = av(length(av):-1:1); % reversal of the vector!

%%%%%%%%%%%%%%%%%%%
% solving a system of linear equations of the form Ax = b, where A is of
% size (say) 10 x 10, x has size 10 x 1, b has size 10 x 1; if A is
% invertible, x = A^(-1)*b;
A = rand(10,10); 
b = rand(10,1);
x = inv(A)*b; % one way of solving
x = A^(-1)*b; % just the same as above

x = A\b; % a better way of solving ('\' is called the mldivide operator)
x = mldivide(A,b); % just the same as above - rarely used

% measuring time
tic;
for i=1:10000, % notice the syntax for the for loop in MATLAB
    x = inv(A)*b; 
end;
toc;

tic;
for i=1:10000, 
    x = A\b; 
end;
toc;

%%%%%%%%%%%%%%%%%%%%%%%
% solving a linear system of equations of the form AX = B, where  has size
% 10 x 10, X has size 10 x 10, B has size 10 x 10 Note this is equivalent
% to solving 10 simultaneous equations of the form Ax1 = b1, Ax2 =
% b2,...,Ax10 = b10 where x1,...,x10 are 10 x 1 vectors and b1,...,b10 are
% 10 x 1 vectors
A = rand(10,10);
B = rand(10,10);
X = A\B;

%%%%%%%%%%%%%%%%%%%%%%%
% solving a system of linear equations of the form xA = b, where x is a
% vector of size 1 x 10, A has size 10 x 10, b is a vector of size 1 x 10
A = rand(10,10);
b = rand(1,10);
x = b*A^(-1); % one way of solving
x = b*inv(A); % another way of solving

%%%%%%%%%%
c = diag(A); % a quick way of getting the diagonal elements of A
C = diag(diag(A)); % extract the diagonal elements of A and create a matrix C which has the same elements as on the diagonal of A, and zeros everywhere else
A = eye(10); % a quick way of creating a 10 x 10 DIAGONAL matrix
A = zeros(10); % creating a 10 x 10 matrix of zeros
A = ones(10); % creating a 10 x 10 matrix of ones
B = A(2:4,3:9); % extracting a submatrix quickly
A(2:4,3:9) = 1; % setting all values in a submatrix to 1

%%%%
% solving a linear system of the form AX = B, where A = 20 x 3, X = 3 x 3
% (UNKNOWN) and B = 20 x 3;
A = randn(20,3);
B = randn(20,3);
X = (B'*A) \ (B'*B);

