clear;
close all;
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
fprintf("We get the minimum NCC = %d at an angle of %d degree \n",opt_ncc , opt_theta);
%% 
% Using Joint Entropy as the metric

theta = -45:1:45;
JEs = [];

for angle = theta
    J4= imrotate(J3,angle,"bilinear","crop");
    je = JE(J4 , J1);
    JEs = [JEs je];
end

figure,plot(theta , JEs);  xlabel("Angles (in degree)"); ylabel("Joint Entropy"); title("Plot of JE versus Theta");
opt_je = min(JEs);
opt_theta = theta(find(JEs== min(JEs)));
fprintf("We get the minimum JE = %d at an angle of %d degree \n",opt_je , opt_theta);
%%
% Using QMI as the metric
theta = -45:1:45;
QMIs = [];

for angle = theta
    J4= imrotate(J3,angle,"bilinear","crop");
    qmi = QMI(J4 , J1);
    QMIs = [QMIs qmi];
end

figure,plot(theta , QMIs);  xlabel("Angles (in degree)"); ylabel("QMI"); title("Plot of QMI versus Theta");
opt_qmi = min(QMIs);
opt_theta = theta(find(QMIs== max(QMIs)));
fprintf("We get the maximum QMI = %d at an angle of %d degree \n",opt_qmi , opt_theta);