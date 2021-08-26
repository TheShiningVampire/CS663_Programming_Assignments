clear; close all;

I1 = imread("LC1.png"); figure(1); imagesc(I1); colormap('gray'); title("LC1");
I2 = imread("LC2.jpg"); figure(2); imagesc(I2); colormap('gray'); title("LC2");

BW = 7; % bin width

% local histogram equalisation
LHE1 = cast(get_LHE(I1,BW),'uint8');
LHE2 = cast(get_LHE(I2,BW),'uint8');

figure(3); imagesc(LHE1); colormap('gray'); title("Local histogram equalisation of LC1 with bin width = "+num2str(BW));
figure(4); imagesc(LHE2); colormap('gray'); title("Local histogram equalisation of LC2 with bin width = "+num2str(BW));

% global histogram equalisation
GHE1 = histeq(I1,256);
GHE2 = histeq(I2,256);

figure(5); imagesc(GHE1); colormap('gray'); title("Global histogram equalisation of LC1 with bin width = "+num2str(BW));
figure(6); imagesc(GHE2); colormap('gray'); title("Global histogram equalisation of LC2 with bin width = "+num2str(BW));


%% functions %%

function LHE = get_LHE(I,BW) % BW : local bin width
    LHE = zeros(size(I));
    [r, c] = size(I);
    for x = 1:c
        for y = 1:r
            i1 = max(y-((BW-1)/2),1); i2 = min(y+((BW-1)/2),r); % local bin start and end rows
            j1 = max(x-((BW-1)/2),1); j2 = min(x+((BW-1)/2),c); % local bin start and end columns
            LI = I(i1:i2,j1:j2);
            LHE(y,x) = get_EP1(LI,(x-j1)+1,(y-i1)+1);
        end
    end
end

function EP = get_EP1(I,x,y) % EP : equalised pixel of I(x,y) % faster for larger BW
    Ic = I+1;
    pmf = accumarray(Ic(:),ones(1,numel(I)));
    pmf = [pmf;zeros(256-numel(pmf),1)];
    cdf = cumsum(pmf)/numel(I);
    EP = round(255*cdf(I(y,x)+1));
end

function EP = get_EP2(I,x,y) % EP : equalised pixel of I(x,y) % faster for smaller BW
    pmf = zeros(256,1);
    cdf = zeros(256,1);
    for i = 1:size(I,1)
        for j = 1:size(I,2)
            intensity = I(i,j) + 1;
            pmf(intensity) = pmf(intensity)+1;
        end
    end
    cdf(1) = pmf(1);
    for i = 2:256
        cdf(i) = cdf(i-1) + cdf(i);
    end
    EP = round(255*cdf(I(y,x)+1));
end
