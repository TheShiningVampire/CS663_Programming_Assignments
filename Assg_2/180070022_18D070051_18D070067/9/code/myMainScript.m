%% MyMainScript

tic;
%% Your code here
%Local Histogram Equalization of sizes 7 Ã— 7, 31 Ã— 31, 51 Ã— 51, 71 Ã— 71
clc; clear;
close all;
%%
%Read Images

I_1 = im2double(imread('LC1.png'));
I_2 = im2double(imread('LC2.jpg'));

figure(1); 
imagesc(I_1); 
colormap("gray"); title("LC1"); impixelinfo;

figure(2); 
imagesc(I_2); 
colormap("gray"); title("LC2"); impixelinfo; 

%%
%Local Histogram Equalization

sizes = [7, 31, 51, 71];

for i = 1:4
    N = sizes(i);
    
    I_eq_1 = hist_eq(I_1, N);
    I_eq_2 = hist_eq(I_2, N);
    
    figure(2*i+1); 
    imagesc(I_eq_1); 
    colormap("gray"); title(sprintf("LC1 equalized locally with size %d", N)); impixelinfo;
    %imwrite(uint8(I_eq_1), sprintf('LC1_%d.png', N));
    
    figure(2*i+2); 
    imagesc(I_eq_2); 
    colormap("gray"); title(sprintf("LC2 equalized locally with size %d", N)); impixelinfo;
    %imwrite(uint8(I_eq_2), sprintf('LC2_%d.png', N));
end

%%
%Global Histogram Equalization

I_glob_1 = histeq(uint8(255*I_1));
imwrite(uint8(I_glob_1), 'LC1_global.png');

I_glob_2 = histeq(uint8(255*I_2));
imwrite(uint8(I_glob_2), 'LC2_global.png');

%%

toc;
