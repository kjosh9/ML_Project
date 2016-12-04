function predlabels = knn(traindata, trainlabels, testdata, options)
% Predicts data labels using the k-Nearest Neighbors algorithm.
% traindata: Data used to train the algorithm. Must be row oriented
% trainlabels: Labels associated with the training data
% testdata: The data to be tested. Must have the same second dimension as traindata
% options: Options to change how KNN is run
%   - distFun: Required if D is not given, function given to pdist2
%   - k: Number of neighbors to evaluate
%   - [D]: Precomputed distance matrix
%   - [weightFun]: Weighting function that takes distance as an argument

    % Set some useful variables
    ntest = size(testdata, 1);
    labels = unique(trainlabels);
    nlabels = size(labels);
    nlabels = nlabels(1);
    k = options.k;
    if isfield(options, 'weightFun')
        weightFun = options.weightFun;
    else
        weightFun = @(dist) 1;
    end
    if isfield(options, 'D')
        D = options.D;
    end
    
    
    % Preallocate for efficiency
    predlabels = zeros(ntest, 1);
    
    % Calculate pairwise distances
    if exist('D', 'var') == 0
        fprintf('Calculating distances...\n')
        distFun = options.distFun;
        if size(varargin) > 0
            tic
            D = pdist2(traindata, testdata, distFun, varargin);
            toc
        else
            tic
            D = pdist2(traindata, testdata, distFun);
            toc
        end
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