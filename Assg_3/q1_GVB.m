clear; close all;

Ib = im2double(imread('barbara256.png'));
Ik = im2double(imread('kodak24.png'));

figure(1); imagesc(Ib); colormap("gray"); title("Original barbara256");
figure(2); imagesc(Ik); colormap("gray"); title("Original kodak24");

sig_n = 5; % noise-standard deviation

Ibn = Ib + (sig_n/255)*randn(size(Ib));
Ikn = Ik + (sig_n/255)*randn(size(Ik));

figure(3); imagesc(Ibn); colormap("gray"); title("noisy barbara256 with \sigma_n = " + num2str(sig_n));
figure(4); imagesc(Ikn); colormap("gray"); title("noisy kodak24 with \sigma_n = " + num2str(sig_n));

tic;
sig_s = 2; sig_r = 2;
Ibn_MS = mean_shift_filter(Ibn,sig_s,sig_r/255);
Ikn_MS = mean_shift_filter(Ikn,sig_s,sig_r/255);
toc;

figure(5); imagesc(Ibn_MS); colormap("gray"); 
title("mean shifted filter on barbara256 with \sigma_n = " + num2str(sig_n) + ", \sigma_s = " + num2str(sig_s) + ", \sigma_r = " + num2str(sig_r));
figure(6); imagesc(Ikn_MS); colormap("gray"); 
title("mean shifted filter on kodak24 with \sigma_n = " + num2str(sig_n) + ", \sigma_s = " + num2str(sig_s) + ", \sigma_r = " + num2str(sig_r));

function MSF = mean_shift_filter(I,sig_s,sig_r)
    [r, c] = size(I);
    BWby2 = ceil(3*sig_s)+1; % BW = 6*sig_s + 1
    e = 0.01;
    MSF = zeros(size(I));
    for x = 1:c
        for y = 1:r
            f = [x y I(y,x)]; % feature vector
            while 1
                i1 = max(y-BWby2,1); i2 = min(y+BWby2,r); % neighbourhood start and end rows
                j1 = max(x-BWby2,1); j2 = min(x+BWby2,c); % neighbourhood start and end columns
                LI = I(i1:i2,j1:j2);
                [X, Y] = meshgrid(j1:j2,i1:i2);
                Gs = exp(-1*((X-f(1)).^2+(Y-f(2)).^2)/(2*sig_s^2)); % spatial gaussian filter
                Gr = exp(-1*((LI-f(3)).^2)/(2*sig_r^2)); % range gaussian filter
                G = Gs.*Gr;
                Wp = sum(G,'all');
                fx = sum(G.*X,'all')/Wp;
                fy = sum(G.*Y,'all')/Wp;
                fI = sum(G.*LI,'all')/Wp;
                if norm(f-[fx fy fI])> e
                    f = [fx fy fI];
                else 
                    break;
                end
            end
            MSF(y,x) = f(3);
        end
    end     
end