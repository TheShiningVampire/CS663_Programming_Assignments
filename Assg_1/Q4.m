clear;
clc;

J1 = imread('T1.jpg');
J2 = imread('T2.jpg');

J1 = double(J1);
J2 = double(J2);


J1 = J1 + 1;
J2 = J2 + 1; 

%figure, imagesc(J1); colormap("gray"); axis("equal");
J3 = imrotate(J2 , 28.5 , "bilinear","crop");
figure, imagesc(J1); colormap("gray"); axis("equal"); impixelinfo; 
figure, imagesc(J2); colormap("gray"); axis("equal"); impixelinfo; 
figure, imagesc(J3); colormap("gray"); axis("equal"); impixelinfo; 
J_rotate= imrotate(J3,-29,"bilinear","crop");
figure, imagesc(J_rotate); colormap("gray"); axis("equal"); impixelinfo;
%% 
% Using NCC as the metric

theta = -45:1:45;
nccs = [];

for angle = theta
    J4= imrotate(J3,angle,"bilinear","crop");
    ncc = NCC(J4 , J1);
    nccs = [nccs ncc];
end

figure,plot(theta , nccs);  xlabel("Angles (in degree)"); ylabel("Normalised Cross Correlation (NCC)"); title("Plot of NCC versus Theta");
opt_ncc = min(nccs);
opt_theta = theta(find(nccs== min(nccs)));
fprintf("We get the minimuum NCC = %d at an angle of %d degree \n",opt_ncc , opt_theta);
%%
% Using