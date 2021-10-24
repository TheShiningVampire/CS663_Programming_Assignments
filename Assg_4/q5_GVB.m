% Reconstruction of face image from eigen vectors

clear; close all;

%% Get data points

train_set = []; % training set
train_sub = []; % training subjects
test_set = [];  % testing set
test_sub = [];  % testing subjects
for i=1:32
    imagefiles = dir("ORL/s"+num2str(i)+"/*.pgm");   
    for ii=1:length(imagefiles)
       currentfilename = imagefiles(ii).folder+"/"+imagefiles(ii).name;
       currentimage = im2double(imread(currentfilename));
       if(ii<=6)
           train_set = cat(2,train_set,currentimage(:));
           train_sub = cat(2,train_sub,i);
       else
           test_set = cat(2,test_set,currentimage(:));
           test_sub = cat(2,test_sub,i);
       end
    end
end

image = im2double(imread("ORL/s1/1.pgm"));
m=size(image,1); n = size(image,2);

figure(1);
imagesc(image); colormap("gray"); title("Original image");

%% eigen vectors, eigen coeff, reconstruction

mean_vector = mean(train_set,2);
X = train_set - mean_vector;

[U,S,V] = svd(X);
k = [2,10,20,50,75,100,125,150,175];
for i=1:length(k)
    eigen_space = U(:,1:k(i));
    eigen_coef = (eigen_space')*(X(:,1));
    recon_image = (eigen_space*eigen_coef);
    recon_image = reshape(recon_image,m,n);
    figure(i+1);
    imagesc(recon_image); colormap("gray"); title("Reconstructed image for k="+num2str(k(i)));
end

%% 25 eigen faces

eigen_space = U(:,1:25);
for i=1:25
   eigen_face = reshape(eigen_space(:,i),m,n);
   subplot(5,5,i); imagesc(eigen_face); colormap("gray");
end
