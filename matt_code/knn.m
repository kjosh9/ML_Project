function predlabels = knn(traindata, trainlabels, testdata, k, distFun, weightFun, varargin)
% Predicts data labels using the k-Nearest Neighbors algorithm.
% traindata: Data used to train the algorithm. Must be row oriented
% trainlabels: Labels associated with the training data
% testdata: The data to be tested. Must have the same second dimension as traindata
% k: Number of neighbors
% distFun: The distance function to use with pdist2
% weightFun: The weighting function to use. Takes a single argument of
%   distance
% varargin: Arguments for the distFun

    % Set some useful variables
    ntest = size(testdata, 1);
    labels = unique(trainlabels);
    nlabels = size(labels);
    nlabels = nlabels(1);
    
    % Preallocate for efficiency
    predlabels = zeros(ntest, 1);
    
    % Check if the weight function was given
    if exist('weightFun', 'var') == 0
        weightFun = @(dist) 1;
    end
    
    % Calculate pairwise distances
    if size(varargin) > 0
        tic
        D = pdist2(traindata, testdata, distFun, varargin);
        toc
    else
        tic
        D = pdist2(traindata, testdata, distFun);
        toc
    end
    
    % Loop through each test data point
    for i = 1:ntest
        % Sort the distances ascending
        [dists, indices] = sort(D(:, i));
        
        % Preallocate votes array
        votes = zeros(nlabels, 1);
        
        % Aggregate votes from k lowest distance neighbors
        for j = 1:k
            neighborLabel = trainlabels(indices(j));
            weight = weightFun(dists(j));
            votes(neighborLabel + 1) = votes(neighborLabel + 1) + weight;
        end
        
        % Get the predicted label
        [~, label] = max(votes);
        predlabels(i) = label - 1;
    end
end