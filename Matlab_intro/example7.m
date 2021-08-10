clear;
clc;

X = randn(1000,25);
boxplot(X);

% Maximum whisker length w. 
% The default is a w of 1.5. Points are drawn as outliers if they are larger than q3 + w(q3 – q1) or smaller than q1 – w(q3 – q1), 
% where q1 and q3 are the 25th and 75th percentiles, respectively. The default of 1.5 corresponds to approximately +/–2.7? and 99.3 
% coverage if the data are normally distributed. The plotted whisker extends to the adjacent value, which is the most extreme data value that is not an outlier. 
% Set whisker to 0 to give no whiskers and to make every point outside of q1 and q3 an outlier.