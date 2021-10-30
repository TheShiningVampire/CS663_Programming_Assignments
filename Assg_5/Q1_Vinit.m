tic;
clear;
close all;
clc;

% Read the two images
image1 = double(imread('barbara256.png'));
image2 = double(imread('stream.png'));

% Given parameters
sigma = 20;

% Extract the top left 256x256 block of im2
image2_block = image2(1:256, 1:256);

% Display the images
% figure; imagesc(image1); colormap('gray'); title('Original Image 1');
% figure; imagesc(image2_block); colormap('gray'); title('Original Image 2');

% Consider one of the images
im = image1; % To select image 1
% im = image2_block; % To select image 2

% Adding zero mean Gaussian noise of sigma 20 to the image
im1 = im + randn(size(im)) * sigma;

% Scale the image to [0,255]
im1 = (im1 - min(im1(:))) / (max(im1(:)) - min(im1(:))) * 255;

% denoised_image = myPCADenoising1(im1, sigma); % Denoised image using global PCA
denoised_image = myPCADenoising2(im1, sigma); % Denoised image using spatially varying PCA

% Display the result
figure; imagesc(im1); colormap('gray'); title('Original Noisy Image');
figure; imagesc(denoised_image); colormap('gray'); title('Denoised Image');

% Display the RMSE
fprintf('The RMSE is %f\n', sqrt(sum((im1(:) - denoised_image(:)).^2) / sum(im1(:).^2)));

toc;
