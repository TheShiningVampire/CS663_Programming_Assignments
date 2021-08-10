clear;
clc;

x = rand(1000,1);
y = rand(1000,1);

scatter(x,y); % scatter plot of x versus y
% this by default uses blue bubbles

% you can create another one with say red '+' markers
scatter(x,y,'r+'); % note this overwrites the earlier figure!

% what if you wanted to have two figures?
scatter(x,y);
figure; % this creates a new figure
scatter(x,y,'r+');

% let's say you had two datasets and you wanted to place both the scatter
% plots on the same figure. what do you do?
x1 = rand(1000,1);
y1 = rand(1000,1);
x2 = 5+rand(1000,1);
y2 = 5+rand(1000,1);
scatter(x1,y1);
hold on; % this ensure that the next figure is overlaid on the current one!
scatter(x2,y2,'r+');
