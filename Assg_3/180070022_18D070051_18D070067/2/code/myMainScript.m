%% MyMainScript

tic;
%% Your code here
clear; close all; clc;

%% Read the barbara256.png image as double

img = im2double(imread('barbara256.png'));

%% Display the original image
figure; imshow(img); colormap("gray"); %title('Original Image');

% Pad the image to make the dimensions twice as large
img_padded = padarray(img, [size(img, 1) / 2, size(img, 2) / 2]);

% figure; imshow(img_padded); colormap("gray"); title('Padded Image');

% Ideal Low pass filtered image
img_filtered_ideal = IdealLowPass(img_padded, 40);

% Extract the central part of the image
img_filtered_ideal = img_filtered_ideal(size(img, 1) / 2 + 1:size(img, 1) / 2 + size(img, 1), size(img, 2) / 2 + 1:size(img, 2) / 2 + size(img, 2));

% Display filtered image when using an ideal Low Pass Filter
figure; imshow(img_filtered_ideal); colormap("gray"); %title('Ideal Low Pass Filter');

% Gaussian Low Pass filtered image
img_filtered_gaussian = GaussianLowPass(img_padded, 40);

% Extract the central part of the image
img_filtered_gaussian = img_filtered_gaussian(size(img, 1) / 2 + 1:size(img, 1) / 2 + size(img, 1), size(img, 2) / 2 + 1:size(img, 2) / 2 + size(img, 2));

% Display filtered image when using a Gaussian Low Pass Filter
figure; imshow(img_filtered_gaussian); colormap("gray"); %title('Gaussian Low Pass Filter');

toc;

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%                             FUNCTIONS                       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function img_filtered = IdealLowPass(img, cutoff_freq)
    %% Compute the Fourier transform of the image along with shift
    F = fftshift(fft2(img));
    log_F = log(abs(F) + 1); % log(0) is undefined, so add 1

    %% Display the magnitude of the Fourier transform of the image
    figure; imshow(log_F, [min(log_F(:)) max(log_F(:))]); colormap("jet"); colorbar; title('Fourier Transform of the Image');

    % Apply the low pass filter of cutoff frequency 50
    Filter = zeros(size(F));
    [x, y] = meshgrid(-size(Filter, 1) / 2:size(Filter, 1) / 2 - 1, -size(Filter, 2) / 2:size(Filter, 2) / 2 - 1);
    valid_indices = (x.^2 + y.^2) <= cutoff_freq^2;
    Filter(valid_indices) = 1;

    % Display the filter
    figure; imshow(log(1 + Filter), [min(log(1 + Filter(:))) max(log(1 + Filter(:)))]); colormap("jet"); colorbar; title('Ideal Low Pass Filter');

    % Filtering the image
    F_filtered = F .* Filter;

    %% Display the magnitude of the Fourier transform of the filtered image
    log_F_filtered = log(abs(F_filtered) + 1);
    figure; imshow(log_F_filtered, [min(log_F_filtered(:)) max(log_F_filtered(:))]); colormap("jet"); colorbar; title('Fourier Transform of the Filtered Image');

    img_filtered = ifft2(ifftshift(F_filtered));
end

function img_filtered = GaussianLowPass(img, sigma)
    %% Compute the Fourier transform of the image along with shift
    F = fftshift(fft2(img));
    log_F = log(abs(F) + 1); % log(0) is undefined, so add 1

    % %% Display the magnitude of the Fourier transform of the image
    % figure; imshow(log_F, [min(log_F(:)) max(log_F(:))]); colormap("jet"); colorbar; title('Fourier Transform of the Image');

    % Apply the low pass filter of cutoff frequency 50
    Filter = zeros(size(F));
    [x, y] = meshgrid(-size(Filter, 1) / 2:size(Filter, 1) / 2 - 1, -size(Filter, 2) / 2:size(Filter, 2) / 2 - 1);
    Filter = exp(-((x.^2 + y.^2) / (2 * sigma^2)));

    % Display the filter
    figure; imshow(log(1 + Filter), [min(log(1 + Filter(:))) max(log(1 + Filter(:)))]); colormap("jet"); colorbar; title('Gaussian Low Pass Filter');

    % filtering
    F_filtered = F .* Filter;

    %% Display the magnitude of the Fourier transform of the filtered image
    log_F_filtered = log(abs(F_filtered) + 1);
    figure; imshow(log_F_filtered, [min(log_F_filtered(:)) max(log_F_filtered(:))]); colormap("jet"); colorbar; title('Fourier Transform of the Filtered Image');

    img_filtered = ifft2(ifftshift(F_filtered));
end
