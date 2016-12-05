% Load data and features
fprintf('Loading features and labels...\n')
load ./data/gist_data.mat
load ./data/cifar10.mat

% Load precomputed cityblock distance
fprintf('Loading city distance matrix...\n')
load ./data/city.mat

% Test city distance over k and save error rates
fprintf('Testing city distance for k = 1-100\n')
errors = zeros(100, 1);
predictions = zeros(100, 10000);
parfor k = 1:100
    preds = knn(features(1:40000, :), labels(1:40000), features(40001:50000, :), struct('k', k, 'D', cityDistance));
    errors(k, 1) = mean(preds ~= labels(40001:50000));
    predictions(k, :) = preds';
end

% Save city error
save ./predictions/city_error.mat errors
save ./predictions/city_predictions.mat predictions

% Clear city distances
clearvars cityDistance

% Load precomputed cosine distance
fprintf('Loading cosine distance matrix...\n')
load ./data/cosine.mat

% Test city distance over k and save error rates
fprintf('Testing cosine distance for k = 1-100\n')
errors = zeros(100, 1);
predictions = zeros(100, 10000);
parfor k = 1:100
    preds = knn(features(1:40000, :), labels(1:40000), features(40001:50000, :), struct('k', k, 'D', cosineDistance));
    errors(k, 1) = mean(preds ~= labels(40001:50000));
    predictions(k, :) = preds';
end

% Save city error
save ./predictions/cosine_error.mat errors
save ./predictions/cosine_predictions.mat predictions

% Clear city distances
clearvars cosineDistance
