%% MyMainScript

tic;
%% Your code here
clear; close all;

Ib = imread('barbara256.png');
Ik = imread('kodak24.png');

figure(1); imagesc(Ib); colormap("gray"); title("Original barbara256");
figure(2); imagesc(Ik); colormap("gray"); title("Original kodak24");

sign = 5;  % noise sd  

Ib = im2double(Ib);
Ibn = Ib + sign/255*randn(size(Ib));

Ik = im2double(Ik);
Ikn = Ik + sign/255*randn(size(Ik));

figure(3); imagesc(Ibn); colormap("gray"); title("noisy barbara256 with \sigma_n = " + num2str(sign));
figure(4); imagesc(Ikn); colormap("gray"); title("noisy kodak24 with \sigma_n = " + num2str(sign));

sigs = 3; % filter spatial sd
sigr = 15; % filter range sd

sigr = sigr/255; % Scaled down to account for the scaling due to im2double

BFb = mybilateralfilter(Ibn,sigs,sigr);
BFk = mybilateralfilter(Ikn,sigs,sigr);

figure(5); imagesc(BFb); colormap("gray"); 
title("filtered barbara256 with \sigma_n = " + num2str(sign) + ", \sigma_s = " + num2str(sigs) + ", \sigma_r = " + num2str(sigr*255));
figure(6); imagesc(BFk); colormap("gray");
title("filtered kodak24 with \sigma_n = " + num2str(sign) + ", \sigma_s = " + num2str(sigs) + ", \sigma_r = " + num2str(sigr*255));

toc;
