% face recognition of ../../ORL database

clear;
tic;
%% Get data points

train_set = []; % training set
train_sub = []; % training subjects
test_set = []; % testing set
test_sub = []; % testing subjects

for i = 1:32
    imagefiles = dir("../../ORL/s" + num2str(i) + "/*.pgm");

    for ii = 1:length(imagefiles)
        currentfilename = imagefiles(ii).folder + "/" + imagefiles(ii).name;
        currentimage = im2double(imread(currentfilename));

        if (ii <= 6)
            train_set = cat(2, train_set, currentimage(:));
            train_sub = cat(2, train_sub, i);
        else
            test_set = cat(2, test_set, currentimage(:));
            test_sub = cat(2, test_sub, i);
        end

    end

end

n_train = size(train_set, 2);
n_test = size(test_set, 2);
mean_vector = mean(train_set, 2);

X = train_set - mean_vector;
Y = test_set - mean_vector;

%% Get eigen space and eigen coefficients

% % using svd
% [U, S, V] = svds(X);

% using eig
L = X' * X;
[V, D] = eig(L, 'vector');
[D, ind] = sort(D, 'descend');
V = V(:, ind);
U = X * V;

% Normalizing the eigen vectors
for i = 1:size(U, 2)
    U(:, i) = U(:, i) / norm(U(:, i));
end

k = [1, 2, 3, 5, 10, 15, 20, 30, 50, 75, 100, 150, 170];
recognition_rate = zeros(size(k));

for i = 1:length(k)
    eigen_space = U(:, 1:k(i));
    eigen_coef = (eigen_space') * X;
    test_coef = (eigen_space') * Y;
    recognition_count = 0;

    for j = 1:n_test
        [m, index] = min(sum((eigen_coef - test_coef(:, j)).^2));

        if train_sub(index) == test_sub(j)
            recognition_count = recognition_count + 1;
        end

    end

    recognition_rate(i) = recognition_count / n_test;
end

plot(k, recognition_rate, 'o-');
ylabel("Recognition rate", 'FontSize', 15); xlabel("k", 'FontSize', 15);

toc;
