%% MyMainScript
% The program takes roughly 5 mins for sig_s = 2, sig_r = 2
% The program takes roughly 20 mins for sig_s = 3, sig_r = 15

tic;
%% Your code here

clear; close all;

%% Input images

Ib = im2double(imread('barbara256.png'));
Ik = im2double(imread('kodak24.png'));

figure(1); imagesc(Ib); colormap("gray"); title("Original barbara256");
figure(2); imagesc(Ik); colormap("gray"); title("Original kodak24");

%% noisy images

sig_n = 10; % noise-standard deviation

Ibn = Ib + (sig_n/255)*randn(size(Ib)); % /255 because intensities are double 
Ikn = Ik + (sig_n/255)*randn(size(Ik));

figure(3); imagesc(Ibn); colormap("gray"); title("noisy barbara256 with \sigma_n = " + num2str(sig_n));
figure(4); imagesc(Ikn); colormap("gray"); title("noisy kodak24 with \sigma_n = " + num2str(sig_n));

%% mean shift filtering

sig_s = 2; sig_r = 2;
Ibn_mean_shift = mean_shift_filter(Ibn,sig_s,sig_r/255); % /255 because intensities are double 
Ikn_mean_shift = mean_shift_filter(Ikn,sig_s,sig_r/255);

figure(5); imagesc(Ibn_mean_shift); colormap("gray"); 
title("mean shifted filter on barbara256 with \sigma_n = " + num2str(sig_n) + ", \sigma_s = " + num2str(sig_s) + ", \sigma_r = " + num2str(sig_r));
figure(6); imagesc(Ikn_mean_shift); colormap("gray"); 
title("mean shifted filter on kodak24 with \sigma_n = " + num2str(sig_n) + ", \sigma_s = " + num2str(sig_s) + ", \sigma_r = " + num2str(sig_r));

toc;
