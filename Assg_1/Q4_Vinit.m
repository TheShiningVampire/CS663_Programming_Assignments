clear;
close all;
clc;

J1 = im2double(imread('T1.jpg'));
J2 = im2double(imread('T2.jpg'));

J1 = J1 + 1;
J2 = J2 + 1; 

%figure, imagesc(J1); colormap("gray"); axis("equal");
J3 = imrotate(J2 , 28.5 , "bilinear","crop");
figure, imagesc(J1); colormap("gray"); axis("equal"); title("Target image"); impixelinfo; 
figure, imagesc(J3); colormap("gray"); axis("equal"); title("Rotated image"); impixelinfo; 
%% 
% Using NCC as the metricz

theta = -45:1:45;
nccs = [];
JEs = [];
QMIs = [];

for angle = theta
    J4= imrotate(J3,angle,"bilinear","crop");
    J4 = J4-1;
    J4(find(J4==-1)) = 0;
    ncc = NCC(J4 , J1);
    je = JE(J4 , J1);
    qmi = QMI(J4 , J1);

    nccs = [nccs ncc];
    JEs = [JEs je];
    QMIs = [QMIs qmi];
end

% Plots of the three metrics vs theta
figure,plot(theta , nccs);  xlabel("Angles (in degree)"); ylabel("Normalised Cross Correlation (NCC)"); title("Plot of NCC versus Theta");
opt_ncc = min(nccs);
opt_theta_ncc = theta(find(nccs== min(nccs)));
fprintf("We get the minimum NCC = %d at an angle of %d degree \n",opt_ncc , opt_theta_ncc);

figure,plot(theta , JEs);  xlabel("Angles (in degree)"); ylabel("Joint Entropy"); title("Plot of JE versus Theta");
opt_je = max(JEs);
opt_theta_je = theta(find(JEs== max(JEs)));
fprintf("We get the minimum JE = %d at an angle of %d degree \n",opt_je , opt_theta_je);

figure,plot(theta , QMIs);  xlabel("Angles (in degree)"); ylabel("QMI"); title("Plot of QMI versus Theta");
opt_qmi = min(QMIs);
opt_theta_qmi = theta(find(QMIs== max(QMIs)));
fprintf("We get the maximum QMI = %d at an angle of %d degree \n",opt_qmi , opt_theta_qmi);

% Showing the aligned images using the three metrics

J_aligned_ncc = imrotate(J3 , opt_theta_ncc , "bilinear","crop");
J_aligned_je = imrotate(J3 , opt_theta_je , "bilinear","crop");
J_aligned_qmi = imrotate(J3 , opt_theta_qmi , "bilinear","crop");   

figure, subplot(1,3,1);
imagesc(J_aligned_ncc); colormap("gray"); axis("equal"); title("Aligned image using NCC");
subplot(1,3,2);
imagesc(J_aligned_je); colormap("gray"); axis("equal"); title("Aligned image using JE");
subplot(1,3,3);
imagesc(J_aligned_qmi); colormap("gray"); axis("equal"); title("Aligned image using QMI");

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Funtions % 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function x = NCC(J1,J2)
    num = 0;
    den1 = 0;
    den2 = 0;
    J1_mean = mean(J1 ,"all");
    J2_mean = mean(J2 , "all");
    
    for i = 1:min(size(J2,1) ,size(J1 , 1))
        for j = 1:min(size(J2,2), size(J1 ,2))
            if (J1(i,j)>0 && J2(i,j)>0)
                num = num + (J2(i,j) - J2_mean)*(J1(i,j)-J1_mean);
                den1 = den1 + (J2(i,j) - J2_mean)^2;
                den2 = den2 + (J1(i,j) - J1_mean)^2;            
            end
        end
    end
    
    x = abs(num)/(sqrt(den1*den2));
end

function x = JE(J1 , J2)
    %Make the Joint histograms of the images
    % We make the histogram with bins of width 1
    % Hence we round the image intensities to the closest integer
    
    J1 = round(J1);
    J2 = round(J2);
    
    Hist = zeros(256,256);
    for i = 1:min(size(J2,1) ,size(J1 , 1))
        for j = 1:min(size(J2,2), size(J1 ,2))
            if (J1(i,j)>0 && J2(i,j)>0)
                Hist(J1(i,j),J2(i,j)) = Hist(J1(i,j),J2(i,j)) + 1;           
            end
        end
    end
    
    Hist = Hist/numel(Hist);
    Hist1 = Hist;
    Hist1(find(Hist1 == 0)) = 1; % Made all the zero entries in the Histogram to 1 so that the log of them is 0
    Log2_Hist = log2(Hist1);
    x = -sum(Hist*Log2_Hist,"all" );
end

function x = QMI(J1 , J2)
    %  QMI Make the Joint histograms of the images
    % 
    % We make the histogram with bins of width 1 Hence we round the image intensities 
    % to the closest integer
        
        J1 = round(J1);
        J2 = round(J2);
        
        Hist = zeros(256,256);
        for i = 1:min(size(J2,1) ,size(J1 , 1))
            for j = 1:min(size(J2,2), size(J1 ,2))
                if (J1(i,j)>0 && J2(i,j)>0)
                    Hist(J1(i,j),J2(i,j)) = Hist(J1(i,j),J2(i,j)) + 1;           
                end
            end
        end
        
        Hist = Hist/numel(Hist);
        Hist_J1 = sum(Hist,1);
        Hist_J2 = sum(Hist,2);
        Hist_Diff = Hist - Hist_J2*Hist_J1;
        Hist_Diff_Squared = Hist_Diff.^2;
        x = sum(Hist_Diff_Squared,"all");
end

