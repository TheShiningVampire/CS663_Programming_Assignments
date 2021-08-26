clear; close all; clc;

% Read the images
img1 = imread('kodak24.png');
img2 = imread('barbara256.png');

% Display the images 
figure; imagesc(img1); colormap gray; title('Original Kodak24');
figure; imagesc(img2); colormap gray; title('Original Barbara');

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
figure; imagesc(img1); colormap gray; title('Noisy Kodak24');
figure; imagesc(img2); colormap gray; title('Noisy Barbara');

% Filter with sigma_s = sigma_r = 2
sigma_s  = 2;
sigma_r  = 2;

filtered_image1 = mybilateralfilter(img1,sigma_s,sigma_r);
figure, imagesc(filtered_image1); colormap gray; title('Filtered Kodak24 with \sigma_s = 2 and \sigma_r=2');

filtered_image2 = mybilateralfilter(img2,sigma_s,sigma_r);
figure, imagesc(filtered_image2); colormap gray; title('Filtered Barbara with \sigma_s = 2 and \sigma_r=2');

% Filter with sigma_s = sigma_r = 0.1
sigma_s  = 0.1;
sigma_r  = 0.1;

filtered_image1 = mybilateralfilter(img1,sigma_s,sigma_r);
figure, imagesc(filtered_image1); colormap gray; title('Filtered Kodak24 with \sigma_s = 0.1 and \sigma_r=0.1');

filtered_image2 = mybilateralfilter(img2,sigma_s,sigma_r);
figure, imagesc(filtered_image2); colormap gray; title('Filtered Barbara with \sigma_s = 0.1 and \sigma_r=0.1');

% Filter with sigma_s =3 and sigma_r = 15
sigma_s  = 3;
sigma_r  = 15;

filtered_image1 = mybilateralfilter(img1,sigma_s,sigma_r);
figure, imagesc(filtered_image1); colormap gray; title('Filtered Kodak24 with \sigma_s = 3 and \sigma_r=15');

filtered_image2 = mybilateralfilter(img2,sigma_s,sigma_r);
figure, imagesc(filtered_image2); colormap gray; title('Filtered Barbara with \sigma_s = 3 and \sigma_r=15');


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
            x_min = max(1, i - ceil(filter_size));
            x_max = min(rows, i + ceil(filter_size));
            y_min = max(1, j - ceil(filter_size));
            y_max = min(columns, j + ceil(filter_size));

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


