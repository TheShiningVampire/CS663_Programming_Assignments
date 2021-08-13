function x = NCC(J1,J2)
    num = 0;
    den1 = 0;
    den2 = 0;
    J1_mean = mean(J1 ,"all");
    J2_mean = mean(J2 , "all");
    
    for i = 1:min(size(J2,1) ,size(J1 , 1))
        for j = 1:min(size(J2,2), size(J1 ,2))
            if (J1(i,j)>20 && J2(i,j)>20)
                num = num + (J2(i,j) - J2_mean)*(J1(i,j)-J1_mean);
                den1 = den1 + (J2(i,j) - J2_mean)^2;
                den2 = den2 + (J1(i,j) - J1_mean)^2;            
            end
        end
    end
    
    x = abs(num)/(sqrt(den1*den2));
end