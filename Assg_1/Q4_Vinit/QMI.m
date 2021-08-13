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