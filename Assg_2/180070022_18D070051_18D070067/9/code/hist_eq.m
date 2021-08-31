% Local Histogram Equalization
%     1) N*N region around (x, y).
%     2) Assuming bin size = 1. 
%     3) Finding the histogram.
%     4) I(x, y) = r_k => I_eq(X, Y) = s_k = (L-1)sum(P(r)), where (r =
%     0:r_k).
%%
%Local histogram equalization
function I_eq = hist_eq(I, N) 
%I is the Requiered image (double), N is the neighbourhood size.
    m = size(I, 1);
    n = size(I, 2);
    ps = floor(N/2); %Pad size.
    I_pad = padarray(I, [ps, ps]);
    I_eq = zeros(m, n);
    for i = 1:m %Row index.
        %fprintf('Processing row #%d\n', i);
        for j = 1:n %Column index.
            LH = local_hist(I_pad(i:i+N-1, j:j+N-1), N);
            r = floor(I(i, j)*255)+1; %I is a from im2double => multiply by 255.
            I_eq(i, j) = round(255*sum(LH(1:r))); %sum need not be an integer.
        end
    end
end

%Local histogram
function p_r = local_hist(I, N)
%I is a double (N*N), N is the neighbourhood size.
    bin_ind = floor(I*255) + 1;
    p_r = accumarray(bin_ind(:), ones(1, N*N)); %row vector of prob values.
    p_r = p_r./(N*N);
end
%%