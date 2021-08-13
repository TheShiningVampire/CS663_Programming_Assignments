clear;
im = imread ('barbara.png'); % read an image in any format: jpg, bmp, png, gif, tif, pgm, ppm, etc...
% by default all images have the 'uint8' datatype
% before performing any arithmetic operations on them, convert them to
% double.
im = double(im);

figure, imshow(im/255); % imshow IS part of the image processing toolbox
im1 = im + randn(size(im))*10; % note: randn(size(im)) is an array of same size as image, with each entry of the array being a draw from a Gaussian distribution
figure, imshow(im1/255);
% another way:
figure,imagesc(im); colormap(gray); axis('equal'); % imagesc is NOT part of the image processing toolbox
impixelinfo;
im1(im1 < 0) = 0; im1(im1 > 255)= 255; im1 = uint8(im1);
imwrite(im1,'barbara_noisy.png'); % before using imwrite, you MUST conver the image into uint8 format!

% histogram equalization
imeq = histeq(uint8(im));
figure, imshow(imeq);

% image filtering
myfilter = fspecial('average',[5 5]);
imf = imfilter(uint8(im),myfilter); % filter the image with a 5 x 5 mean filter
figure, imshow(imf);
