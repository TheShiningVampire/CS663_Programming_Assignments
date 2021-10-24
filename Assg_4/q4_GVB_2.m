% face recognition of Yale Face database
clear; close all;

%% Get data points
train_set = [];
train_sub = [];
test_set = [];
test_sub = [];
for i=[1:13,15:39]
    imagefiles = dir("CroppedYale/yaleB"+num2str(i,'%02d')+"/*.pgm");   
    for ii=1:length(imagefiles)
       currentfilename = imagefiles(ii).folder+"/"+imagefiles(ii).name;
       currentimage = im2double(imread(currentfilename));
       if(ii<=40)
           train_set = cat(2,train_set,currentimage(:));
           train_sub = cat(2,train_sub,i);
       else
           test_set = cat(2,test_set,currentimage(:));
           test_Sub = cat(2,test_sub,i);
       end
    end
end
%save("Yale_Face_data.mat");

%% 

%load("Yale_Face_data.mat");

k = [1,2,3,5,10,15,20,30,50,60,65,75,100,200,300,500,1000];
recognition_rate = face_recognition_a(train_set,train_sub,test_set,test_sub,k);
plot(k,recognition_rate);

%% functions

function recognition_rate = face_recognition_a(train_set,train_sub,test_set,test_sub,k)
    mean_vector = mean(train_set,2);
    X = train_set - mean_vector;
    Y = test_set - mean_vector;
    n_test = size(test_set,2);
    
    [U,S,V] = svd(X);
    recognition_rate=zeros(size(k));
    for i=1:length(k)
        eigen_space = U(:,1:k(i));
        eigen_coef = (eigen_space')*X;
        test_coef = (eigen_space')*Y;
        recognition_count = 0;
        for j = 1:n_test
            [m,index] = min(sum((eigen_coef-test_coef(:,j)).^2));
            if train_sub(index)==test_sub(j)
                recognition_count = recognition_count + 1;
            end
        end
        recognition_rate(i) = recognition_count/n_test;
    end
end

% ignoring the three eigen coeff of three max eigen values
function recognition_rate = face_recognition_b(train_set,train_sub,test_set,test_sub,k)
    mean_vector = mean(train_set,2);
    X = train_set - mean_vector;
    Y = test_set - mean_vector;
    n_test = size(test_set,2);
    
    [U,S,V] = svd(X);
    recognition_rate=zeros(size(k));
    for i=1:length(k)
        eigen_space = U(:,1:k(i));
        eigen_coef = (eigen_space')*X;
        eigen_coef = eigen_coef(4:end,:); % remove the three eigen coeff of max eig val
        test_coef = (eigen_space')*Y;
        test_coef = test_coef(4:end,:); % remove the three eigen coeff of max eig val
        recognition_count = 0;
        for j = 1:n_test
            [m,index] = min(sum((eigen_coef-test_coef(:,j)).^2));
            if train_sub(index)==test_sub(j)
                recognition_count = recognition_count + 1;
            end
        end
        recognition_rate(i) = recognition_count/n_test;
    end
end
