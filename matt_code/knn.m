function predlabels = knn(traindata, trainlabels, testdata, k, f, D)
    ntrain = size(trainlabels);
    ntest = size(testdata, 1);
    nlabels = 8;
    predlabels = zeros(ntest, 2);
    
    % If D was not given, calculate it using f
    if (exist('D', 'var')) == 0
        D = pdist2(traindata, testdata, f);
    end
    
    % Loop through each test data point
    for i = 1:ntest
        [neighbors, neighborIndices] = sort(D(:, i));
        votes = zeros(nlabels, 1);
        for j = 1:k
            neighborLabel = trainlabels(neighborIndices(j));
            weight = 1/sqrt(neighbors(j) + .001);
            %weight = 1/neighbors(j)^k;
            votes(neighborLabel) = votes(neighborLabel) + weight;
        end
        [~, label] = max(votes);
        predlabels(i,:) = [i label];
    end
end