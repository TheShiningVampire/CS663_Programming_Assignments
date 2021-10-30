function denoised_image = myPCADenoising1(im1, sigma)
    % Divide the noisy image into overlapping patches of size 7x7 and create a matrix P
    patch_size = 7;
    P = im2col(im1, [patch_size, patch_size], 'sliding');
    N = size(P, 2);

    % Compute eigen vector matrix of the PP' matrix
    [V, D] = eig(P * P');

    % Eigen coefficients for each of the patches
    alphas = V' * P;

    % Now, we want to manipulate the eigen coefficients of the patches to get the denoised images
    % For that we first find alpha_h = max(0 , 1/N * (sum (alpha_i ^2) - sigma^2))
    alpha_i = max(0, (1 / N) * (sum(alphas.^2, 2) - sigma^2));

    % Wiener Filter Update
    alphas_updated = zeros(size(alphas));

    for i = 1:patch_size^2
        alphas_updated(i, :) = alphas(i, :) / (1 + sigma^2 / alpha_i(i));
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

    % Scale the denoised image to the range of the original image
    denoised_image = (denoised_image - min(denoised_image(:))) / (max(denoised_image(:)) - min(denoised_image(:))) * 255;
end
