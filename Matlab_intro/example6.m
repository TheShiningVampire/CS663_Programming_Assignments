% mean, median, and standard deviation
clear;
clc;

a = rand(10000,1);
fprintf ('\nStandard deviation of a is %f, variance is %f, mean is %f',std(a),var(a),mean(a));

% computing the mean yourself
mean_a = sum(a)/length(a); % sum(a) adds up all the values of a, length(a) tells you the number of elements in a
% let's say you wanted to compute the mean of only some elements of the
% array
mean_a_partial = mean(a(1:10:end));


% computing the standard deviation yourself
std_a = sum((a-mean(a)).^2)/(length(a)-1);
var_a = std_a^2;

% correlation coefficient
x = rand(1,1000);
y = 3*x-10;
cc = dot(x-mean(x),y-mean(y))/(norm(x-mean(x))*norm(y-mean(y))); 
fprintf ('\ncc = %f',cc);

y = rand(1,1000);
cc = dot(x-mean(x),y-mean(y))/(norm(x-mean(x))*norm(y-mean(y))); 
fprintf ('\ncc = %f',cc);

x = rand(1,1000);
y = x.^2;
cc = dot(x-mean(x),y-mean(y))/(norm(x-mean(x))*norm(y-mean(y))); 
fprintf ('\ncc = %f',cc);
