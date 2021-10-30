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
im = image1;                % To select image 1
% im = image2_block;        % To select image 2

% Adding zero mean Gaussian noise of sigma 20 to the image
im1 = im + randn(size(im)) * sigma;

denoised_image = PCA_denoising(im1, sigma);

% Display the result
figure; imagesc(im1); colormap('gray'); title('Original Noisy Image');
figure; imagesc(denoised_image); colormap('gray'); title('Denoised Image');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%   FUNCTIONS   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function denoised_image = PCA_denoising(im1, sigma)
    % Divide the noisy image into overlapping patches of size 7x7 and create a matrix P
    P = im2col(im1, [7 7], 'sliding');
    N = size(P, 2);

    % % Reconstruct the image from the patches
    % im_reconstructed = col2im(P, [7 7], [], 'sliding');

    % Compute eigen vector matrix of the PP' matrix
    [V, D] = eig(P * P');

    % Eigen coefficients for each of the patches
    alphas = V' * P;

    % Now, we want to manipulate the eigen coefficients of the patches to get the denoised images
    % For that we first find alpha_h = max(0 , 1/N * (sum (alpha_i ^2) - sigma^2))

    alpha_i = max(0, (1 / N) * (sum(alphas.^2, 1) - sigma^2));

    % Wiener Filter Update

    alphas_updated = zeros(size(alphas));

    for i = 1:N
        alphas_updated(:, i) = alphas(:, i) / (1 + sigma^2 / alpha_i(i));
    end

    % Reconstruct the reference patches
    P_denoised = V * alphas_updated;

    % Reconstruct the image from the denoised patches
    % Reference code used from https://in.mathworks.com/matlabcentral/answers/157285-averaging-overlapping-pixels-in-sliding-window-operation

    [m, n] = size(im1);

    indices = reshape(1:m * n, [m, n]);
    subs = im2col(indices, [7, 7], 'sliding');

    denoised_image = accumarray(subs(:), P_denoised(:)) ./ accumarray(subs(:), 1);
    denoised_image = reshape(denoised_image, m, n);

end
