clear; close all;

Ib = imread('barbara256.png');
Ik = imread('kodak24.png');

figure(1); imagesc(Ib); colormap("gray"); title("barbara256");
figure(2); imagesc(Ik); colormap("gray"); title("kodak24");

sign = 5; sigs = 2; sigr = 2; % noise sd, filter spatial sd, filter range sd  

Ibn = im2double(Ib + cast(sign*randn(size(Ib)),'uint8')); % not sure about this method of adding noise
Ikn = im2double(Ik + cast(sign*randn(size(Ik)),'uint8'));

figure(3); imagesc(Ibn); colormap("gray"); title("noisy barbara256 with \sigma_n = " + num2str(sign));
figure(4); imagesc(Ikn); colormap("gray"); title("noisy kodak24 with \sigma_n = " + num2str(sign));

BFb = mybilateralfilter(Ibn,sigs,sigr);
BFk = mybilateralfilter(Ikn,sigs,sigr);

figure(5); imagesc(BFb); colormap("gray"); 
title("filtered barbara256 with \sigma_n = " + num2str(sign) + ", \sigma_s = " + num2str(sigs) + ", \sigma_r = " + num2str(sigr));
figure(6); imagesc(BFk); colormap("gray");
title("filtered kodak24 with \sigma_n = " + num2str(sign) + ", \sigma_s = " + num2str(sigs) + ", \sigma_r = " + num2str(sigr));


%% functions %%

function BF = mybilateralfilter(I,sigs,sigr)
    BF = zeros(size(I));
    BW = 6*sigs+1; % bin width
    [r, c] = size(I);
    for x = 1:c
        for y = 1:r
            i1 = max(y-((BW-1)/2),1); i2 = min(y+((BW-1)/2),r); % local bin start and end rows
            j1 = max(x-((BW-1)/2),1); j2 = min(x+((BW-1)/2),c); % local bin start and end columns
            LI = I(i1:i2,j1:j2);
            [X, Y] = meshgrid(j1:j2,i1:i2);
            Gs = exp(-1*((X-x).^2+(Y-y).^2)/(2*sigs)); % spatial gaussian filter
            Gr = exp(-1*((LI-I(y,x)).^2)/(2*sigr)); % range gaussian filter, ignored 1/2*pi*sigr as it gets cancelled
            BF(y,x) = sum(Gs.*Gr.*LI,'all')/sum(Gs.*Gr,'all');
        end
    end    
end
