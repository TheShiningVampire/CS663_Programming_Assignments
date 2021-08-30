%Bilinear Filter:

function new_img = mybilateralfilter(img, sig_s, sig_r)
    [M, N] = size(img);
    W = ceil(3*sig_s); % bin width (3*simgma_s in each direction from the mean).
    [X, Y] = meshgrid(-W:W, -W:W); % Cordinates relative to the pixel of choice.
    G = gaussian(X.^2 + Y.^2, 0, sig_s);
    
    new_img = zeros(M, N);
    for i = 1:M % y coordinate of the pixel
        for j = 1:N % x coordinate of the pixel
            i1 = max(i-W,1); i2 = min(i+W,M); % local bin start and end rows
            j1 = max(j-W,1); j2 = min(j+W,N); % local bin start and end columns
            I = img(i1:i2, j1:j2); % Region of interest.
            I_diff = I - img(i, j);
            
            G_s = G((i1:i2) - (i-W-1), (j1:j2) - (j-W-1));
            G_r = gaussian(I_diff, 0, sig_r);
            W_p = sum(G_s.*G_r, 'all');
            
            new_img(i, j) = round((1/W_p)*sum(G_s.*G_r.*I, 'all'));
        end
    end
end

function y = gaussian(x, mean, std_dev)
    c = (1/(sqrt(2*pi)*std_dev));
    y = c*exp(-(x - mean).^2/(2*(std_dev)^2));
end