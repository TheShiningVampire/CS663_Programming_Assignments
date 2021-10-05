clear; close all;

%% Input image

Ib = im2double(imread('barbara256.png'));
[H, W] = size(Ib);
Ib_0 = padarray(Ib, [ceil(H/2) ceil(W/2)]);
Fb_0 = fftshift(fft2(Ib_0));
figure(1); imagesc(log(1+abs(Fb_0))); colormap("jet"); colorbar;

%% Ideal low pass filter

D = 40;
LPF = zeros(2*H,2*W);
[X, Y] = meshgrid(-(W-1):W,-(H-1):H); 
b = X.^2+Y.^2 <= D^2;
LPF(b) = 1;
figure(2); imagesc(log(1+abs(LPF))); colormap('jet'); colorbar;
LPF_0 = ifft2(ifftshift(LPF));

IIb_0 = ifft2(ifftshift(Fb_0.*LPF));
FIIb_0 = fftshift(fft2(IIb_0));
figure(3); imagesc(log(1+abs(FIIb_0))); colormap("jet"); colorbar;

IIb = real(IIb_0(129:384,129:384));
figure(4); imagesc(IIb); colormap('gray');

%% Gaussian low pass filter

sig = 40;
[X, Y] = meshgrid(-(W-1):W,-(H-1):H);
GLPF = exp(-(X.^2+Y.^2)/(2*sig^2));
figure(5); imagesc(log(1+abs(GLPF))); colormap('jet'); colorbar;

IIb_0 = ifft2(ifftshift(Fb_0.*GLPF));
FIIb_0 = fftshift(fft2(IIb_0));
figure(6); imagesc(log(1+abs(FIIb_0))); colormap("jet"); colorbar;

IIb = real(IIb_0(129:384,129:384));
figure(7); imagesc(IIb); colormap('gray');
