clear; close all;

Ib = im2double(imread('barbara256.png'));
Ik = im2double(imread('kodak24.png'));

figure(1); imagesc(Ib); colormap("gray"); title("Original barbara256");
figure(2); imagesc(Ik); colormap("gray"); title("Original kodak24");

sign = 5; % noise sd
sigs = 2; % filter spatial sd
sigr = 2/255; % filter range sd, scaled down for 0-1 range  

Ibn = Ib + (sign/255)*randn(size(Ib)); % not sure about this method of adding noise
Ikn = Ik + (sign/255)*randn(size(Ik));

figure(3); imagesc(Ibn); colormap("gray"); title("noisy barbara256 with \sigma_n = " + num2str(sign));
figure(4); imagesc(Ikn); colormap("gray"); title("noisy kodak24 with \sigma_n = " + num2str(sign));

BFb = mybilateralfilter(Ibn,sigs,sigr);
BFk = mybilateralfilter(Ikn,sigs,sigr);

figure(5); imagesc(BFb); colormap("gray"); 
title("filtered barbara256 with \sigma_n = " + num2str(sign) + ", \sigma_s = " + num2str(sigs) + ", \sigma_r = " + num2str(sigr*255));
figure(6); imagesc(BFk); colormap("gray");
title("filtered kodak24 with \sigma_n = " + num2str(sign) + ", \sigma_s = " + num2str(sigs) + ", \sigma_r = " + num2str(sigr*255));


%% functions %%

function BF = mybilateralfilter(I,sigs,sigr)
    BF = zeros(size(I));
    BWby2 = ceil(3*sigs); % bin width/2
    [r, c] = size(I);
    for x = 1:c
        for y = 1:r
            i1 = max(y-BWby2,1); i2 = min(y+BWby2,r); % local bin start and end rows
            j1 = max(x-BWby2,1); j2 = min(x+BWby2,c); % local bin start and end columns
            LI = I(i1:i2,j1:j2);
            [X, Y] = meshgrid(j1:j2,i1:i2);
            Gs = exp(-1*((X-x).^2+(Y-y).^2)/(2*sigs^2)); % spatial gaussian filter
            Gr = exp(-1*((LI-I(y,x)).^2)/(2*sigr^2)); % range gaussian filter, ignored 1/2*pi*sigr as it gets cancelled
            BF(y,x) = sum(Gs.*Gr.*LI,'all')/sum(Gs.*Gr,'all');
        end
    end    
end
