clear; close all; clc;

% Read the images
img1 = imread('kodak24.png');
img2 = imread('barbara256.png');

% Display the images 
figure; imagesc(img1); colormap gray; title('Original Image 1');
figure; imagesc(img2); colormap gray; title('Original Image 2');

% Add Gaussian noise to the images 
mean_n = 0; 
sigma_n = 5; % Given in the problem statement to add Noise with mean 0 and variance sigma_n^2
noise = randn(size(img1));
noise = sigma_n * noise + mean_n;

img1 = double(img1) + noise;

noise = randn(size(img2));
noise = sigma_n*noise + mean_n;

img2 = double(img2) + noise;

% Display the noisy images
figure; imagesc(img1); colormap gray; title('Noisy Image 1');
figure; imagesc(img2); colormap gray; title('Noisy Image 2');

% Filtered image 1
filtered_image1 = mybilateralfilter(img1,2,2);
figure, imagesc(filtered_image1); colormap gray; title('Filtered Image 1');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Functions %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function filtered_image = mybilateralfilter(I, sigma_r, sigma_s)
    % Function to perform the bilateral filter on the given image
    % Input:
    % I: Input image
    % sigma_r: Range sigma
    % sigma_s: Spatial sigma

    % Output:
    % filtered_image: Filtered image

    % Initialize the output image
    filtered_image = zeros(size(I));   
    [rows, columns] = size(I);
    % Perform the filtering operation
    for i = 1:rows
        for j = 1:columns
            % Get the pixel value in the range
            range_pixel = I(i,j);
            filter_size = (3*sigma_r); % This is half the size of the filter that will be used
            
            % Get the pixel co-ordinates of the local patch 
            x_min = max(1, i - filter_size);
            x_max = min(rows, i + filter_size);
            y_min = max(1, j - filter_size);
            y_max = min(columns, j + filter_size);

            % Get the local patch
            patch = I(x_min:x_max, y_min:y_max);

            % Meshgrid of the local patch
            [X,Y] = meshgrid(y_min:y_max, x_min:x_max);

            % Filter the local patch
            G_s = 1/sqrt(2*pi*sigma_s^2) *exp(-((X-j).^2 + (Y-i).^2))/(2*sigma_s^2);
            G_r = 1/sqrt(2*pi*sigma_r^2) *exp(-(patch - I(i,j)).^2)/(2*sigma_r^2);
            
            W = sum(G_s .* G_r,'all'); % Normalisaing factor

            filtered_image(i,j) = sum(G_s.*G_r.*patch , 'all')/W;
        end
    end
end


