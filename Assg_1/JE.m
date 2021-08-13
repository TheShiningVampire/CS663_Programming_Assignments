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
    
    Hist1 = Hist;
    Hist1(find(Hist1 == 0)) = 1; % Made all the zero entries in the Histogram to 1 so that the log of them is 0
    Log2_Hist = log2(Hist1);
    x = -sum(Hist*Log2_Hist,"all" );
end