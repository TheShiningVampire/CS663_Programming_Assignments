clear; close all; clc;

%%
%Main Program 

I_barb = im2double(imread("barbara256.png"))*255;
I_kod = im2double(imread("kodak24.png"))*255;

%Figures
figure; 
imagesc(I_barb); colormap("gray");
impixelinfo; 

figure; 
imagesc(I_kod); colormap("gray");
impixelinfo; 

%%
%Noisy images, sigma = 5
I_barb_noisy = round(I_barb + 5*randn(size(I_barb)));
I_kod_noisy = round(I_kod + 5*randn(size(I_kod)));

%Figures
figure; 
imagesc(I_barb_noisy); colormap("gray");
impixelinfo;
%imwrite(uint8(I_barb_noisy), 'barb_5.png');

figure; 
imagesc(I_kod_noisy); colormap("gray");
impixelinfo;
%imwrite(uint8(I_kod_noisy), 'kod_5.png');

%%
%1) sigma = 5, sigma_s = 2, sigma_r = 2

%Barbara after BLfiltering
I_barb_BLfilter = mybilateralfilter(I_barb_noisy, 2, 2);

figure; 
imagesc(I_barb_BLfilter); colormap("gray");
impixelinfo;
%imwrite(uint8(I_barb_BLfilter), 'barb_5_2_2.png');

%Kodak after BLfiltering
I_kod_BLfilter = mybilateralfilter(I_kod_noisy, 2, 2);

figure; 
imagesc(I_kod_BLfilter); colormap("gray");
impixelinfo;
%imwrite(uint8(I_kod_BLfilter), 'kod_5_2_2.png');

%%
%2) sigma = 5, sigma_s = 0.1, sigma_r = 0.1

%Barbara after BLfiltering
I_barb_BLfilter = mybilateralfilter(I_barb_noisy, 0.1, 0.1);

figure; 
imagesc(I_barb_BLfilter); colormap("gray");
impixelinfo;
%imwrite(uint8(I_barb_BLfilter), 'barb_5_1_1.png');

%Kodak after BLfiltering
I_kod_BLfilter = mybilateralfilter(I_kod_noisy, 2, 2);

figure; 
imagesc(I_kod_BLfilter); colormap("gray");
impixelinfo;
%imwrite(uint8(I_kod_BLfilter), 'kod_5_1_1.png');

%%
%3) sigma = 5, sigma_s = 3, sigma_r = 15

%Barbara after BLfiltering
I_barb_BLfilter = mybilateralfilter(I_barb_noisy, 3, 15);

figure; 
imagesc(I_barb_BLfilter); colormap("gray");
impixelinfo;
%imwrite(uint8(I_barb_BLfilter), 'barb_5_3_15.png');

%Kodak after BLfiltering
I_kod_BLfilter = mybilateralfilter(I_kod_noisy, 2, 2);

figure; 
imagesc(I_kod_BLfilter); colormap("gray");
impixelinfo; 
%imwrite(uint8(I_kod_BLfilter), 'kod_5_3_15.png');

%%
%Noisy images, sigma = 10
I_barb_noisy_2 = round(I_barb + 10*randn(size(I_barb)));
I_kod_noisy_2 = round(I_kod + 10*randn(size(I_kod)));

%Figures
figure; 
imagesc(I_barb_noisy_2); colormap("gray");
impixelinfo;
%imwrite(uint8(I_barb_noisy_2), 'barb_10.png');

figure; 
imagesc(I_kod_noisy_2); colormap("gray");
impixelinfo; 
%imwrite(uint8(I_kod_noisy_2), 'kod_10.png');

%%
%4) sigma = 10, sigma_s = 2, sigma_r = 2

%Barbara after BLfiltering
I_barb_BLfilter = mybilateralfilter(I_barb_noisy, 2, 2);

figure; 
imagesc(I_barb_BLfilter); colormap("gray");
impixelinfo;
%imwrite(uint8(I_barb_BLfilter), 'barb_10_2_2.png');

%Kodak after BLfiltering
I_kod_BLfilter = mybilateralfilter(I_kod_noisy, 2, 2);

figure; 
imagesc(I_kod_BLfilter); colormap("gray");
impixelinfo; 
%imwrite(uint8(I_kod_BLfilter), 'kod_10_2_2.png');

%%
%5) sigma = 10, sigma_s = 0.1, sigma_r = 0.1

%Barbara after BLfiltering
I_barb_BLfilter = mybilateralfilter(I_barb_noisy_2, 2, 2);

figure; 
imagesc(I_barb_BLfilter); colormap("gray");
impixelinfo;
%imwrite(uint8(I_barb_BLfilter), 'barb_10_1_1.png');

%Kodak after BLfiltering
I_kod_BLfilter = mybilateralfilter(I_kod_noisy_2, 2, 2);

figure; 
imagesc(I_kod_BLfilter); colormap("gray");
impixelinfo;
%imwrite(uint8(I_kod_BLfilter), 'kod_10_1_1.png');

%%
%6) sigma = 10, sigma_s = 3, sigma_r = 15

%Barbara after BLfiltering
I_barb_BLfilter = mybilateralfilter(I_barb_noisy_2, 2, 2);

figure; 
imagesc(I_barb_BLfilter); colormap("gray");
impixelinfo;
%imwrite(uint8(I_barb_BLfilter), 'barb_10_3_15.png');

%Kodak after BLfiltering
I_kod_BLfilter = mybilateralfilter(I_kod_noisy_2, 2, 2);

figure; 
imagesc(I_kod_BLfilter); colormap("gray");
impixelinfo; 
%imwrite(uint8(I_kod_BLfilter), 'kod_10_3_15.png');

%%