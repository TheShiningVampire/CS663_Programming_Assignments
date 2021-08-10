clear; clc;

v = rand(20,1);
% let's say you want to add to add to element v(i) in vector v, the value
% of v(i+1) and repeat this for every i from 1 to 19

% a bad way - C styled MATLAB code :-)
for i=1:19,
    v(i) = v(i)+v(i+1);
end;

% better way - MATLAB styled MATLAB code :-) - faster execution, more
% compact code!
v(1:19) = v(1:19) + v(2:20);

%%%%%%%%%%%%%%%%%

% a bad way - C styled MATLAB code :-)
for i=1:2:19,
    v(i) = v(i)+v(i+1);
end;

% better way - MATLAB styled MATLAB code :-) - faster execution, more
% compact code!
v(1:2:19) = v(1:2:19) + v(2:2:20);


% adding two large vectors
a = rand(1,100000);
b = rand(1,100000);

c = a+b; % the fast and compact MATLAB way!

for i=1:100000 % the non-compact and slow 'C' way!
    c(i) = a(i) + b(i);    
end
    

tic;
for t=1:5000
 c = a+b;    
end
toc;

tic;
la = length(a);
for t=1:5000
for i=1:la% the non-compact and slow 'C' way!
    c(i) = a(i) + b(i);    
end
end
toc;
a = 11;