%Bilinear Filter:

function new_img = mybilateralfilter(img, sig_s, sig_r)
    [M, N] = size(img);
    x = (1:N);
    y = (1:M);
    [X_coor, Y_coor] = meshgrid(x, y);
    
    inter_img = zeros(M, N);
    for i = 1:M
        for j = 1:N
            X_ij = j*ones(size(img));
            Y_ij = i*ones(size(img));
            n = norm(X_coor, Y_coor, X_ij, Y_ij);
            
            I_ij = img(i, j);
            I_diff = img - I_ij*ones(size(img));
            
            G_s = gaussian(n, 0, sig_s);
            G_r = gaussian(I_diff, 0, sig_r);
            W_p = sum(G_s.*G_r, 'all');
            
            inter_img(i, j) = round((1/W_p)*sum(G_s.*G_r.*img, 'all'));
        end
    end
    new_img = inter_img;
end

% function I_diff = mybilateralfilter(img) 
%     V_img = img(:);
%     
%     [I_X, I_Y] = meshgrid(V_img', V_img);
%     I_diff = I_X - I_Y;
%     
%     x = (1:size(img, 2));
%     y = (1:size(img, 1));
%     [X_coor_iter, Y_coor_inter] = meshgrid(x, y);
%     X_coor = X_coor_inter(:); Y_coor = Y_coor_inter(:);
%     [X_p, X_q] = meshgrid(X_coor);
%     X_diff = X_p - X_q;
%     [Y_p, Y_q] = meshgrid(Y_coor);
%     Y_diff = Y_p - Y_q;
%     norm = sqrt((X_diff).^2 + (Y_diff).^2);
%     
%     G_s = gaussian(norm, 0, sig_s);
%     G_r = gaussian(I_diff, 0, sig_r);
%     W_p = sum(G_s.*G_r, 2);
%     
%     new_V_img = (G_s.*G_r)*V_img;
%     inter_img = zeros(size(img));
%     for m = 1:length(V_img)
%         i = m - floor(m/size(img, 1))*size(img, 1);
%         j = floor(m/size(img, 1)) + 1;
%         inter_img(i, j) = (1/W_p(m))*(new_V_img(m));
%     end
%     new_img = inter_img;
% end

function n = norm(X1, Y1, X2, Y2)
    n = sqrt((X1 - X2).^2 + (Y1 - Y2).^2);
end

function y = gaussian(x, mean, std_dev)
    c = (1/(sqrt(2*pi)*std_dev));
    y = c*exp(-(x - mean).^2/(2*(std_dev)^2));
end