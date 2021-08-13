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
J_rotate= imrotate(J1,28,"bilinear","crop");
figure, imagesc(J_rotate); colormap("gray"); axis("equal"); impixelinfo; 

%%
% Using NCC as the metric

theta = -45:1:45;
nccs = [];

for angle = theta
    J_rotate= imrotate(J1,angle,"bilinear","crop");
    num = 0;
    den1 = 0;
    den2 = 0;
    J3_mean = mean(J3 ,"all");
    J_rotate_mean = mean(J_rotate , "all");
    
    for i = 1:min(size(J_rotate,1) ,size(J3 , 1))
        for j = 1:min(size(J_rotate,2), size(J3 ,2))
            if (J3(i,j)>20 && J_rotate(i,j)>20)
                num = num + (J_rotate(i,j) - J_rotate_mean)*(J3(i,j)-J3_mean);
                den1 = den1 + (J_rotate(i,j) - J_rotate_mean)^2;
                den2 = den2 + (J3(i,j) - J3_mean)^2;            
            end
        end
    end
    
    ncc = abs(num)/(sqrt(den1*den2));
    nccs = [nccs ncc];
end

plot(theta , nccs)

theta(find(nccs== max(nccs)))