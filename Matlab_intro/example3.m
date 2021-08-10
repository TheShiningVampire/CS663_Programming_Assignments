clear; 
clc;

x = [-10:0.1:10]; % array of values from -10 to 10 in steps of 0.1
y = sin(x);
plot(x,y); % plot y versus x - adjacent points are connected by line segments!
xlabel ('x');
ylabel('y');
title ('sin(x) versus x');

z = cos(x);
hold on;
plot(x,z,'color','red');

%%%
% plots of the form Z = f(X,Y), say Z(x,y) = x*x + y*y whereas x and y lie
% in the range -10:0.1:10

% bad way: C-styled MATLAB code :-)
xindex = 1;
for x = -10:0.1:10
    yindex = 1;
    for y=-10:0.1:10
        z(yindex,xindex) = x*x+y*y;
        yindex = yindex+1;
    end
    xindex = 1;
end

% better way
[X,Y] = meshgrid(-10:0.1:10,-10:0.1:10);
Z = X.^2 + Y.^2;
figure(2);surf(X,Y,Z); shading('interp');
figure(3); surfc(X,Y,Z); shading('interp');
figure(4); imagesc(Z);
figure(5); imagesc(Z); colormap(gray);

%%%%%%
%scatterplots
x = [-10:0.1:10];
y = cos(x) + randn(1,length(x))*0.25; % added noise to cos(x) - noise samples from a Gaussian distribution
figure(6); scatter(x,y);