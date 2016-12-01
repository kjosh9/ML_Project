function cv_error = knncv(traindata, trainlabels, n, k, f, D)
    % Precalculate constants
    partitionsize = floor(size(traindata, 1)/n);
    nerrors = 0;
    
    % Exclude each partition once
    for i = 1:n
        % Partition data
        [trainsubset, testsubset, trainsubsetlabels, testsubsetlabels] = partition(traindata, trainlabels, partitionsize, i);
        
        % Calculate the test labels
        if exist('D', 'var') == 0
            testlabels = knn(trainsubset, trainsubsetlabels, testsubset, k, f);
        else
            testlabels = knn(trainsubset, trainsubsetlabels, testsubset, k, f, D);
        end
        
        % Count errors in this fold
        for j = 1:size(testlabels)
            if testlabels(j, 2) ~= testsubsetlabels(j)
                nerrors = nerrors + 1;
            end
        end
    end
    cv_error = nerrors/size(traindata, 1);
end

function [train, test, trainlabels, testlabels] = partition(data, datalabels, partitionsize, testIndex)
    if testIndex == 1
        train = data((partitionsize + 1):end, :);
        test = data(1:partitionsize, :);
        trainlabels = datalabels((partitionsize + 1):end);
        testlabels = datalabels(1:partitionsize);
    elseif testIndex == floor(size(data, 1)/partitionsize)
        train = data(1:(partitionsize*(testIndex - 1)), :);
        test = data((partitionsize*(testIndex - 1) + 1):end, :);
        trainlabels = datalabels(1:(partitionsize*(testIndex - 1)));
        testlabels = datalabels((partitionsize*(testIndex - 1) + 1):end);
    else
        train = data([1:(partitionsize*testIndex) (partitionsize*(testIndex + 1) + 1):end], :);
        test = data((partitionsize*(testIndex) + 1):(partitionsize*(testIndex + 1)), :);
        trainlabels = datalabels([1:(partitionsize*testIndex) (partitionsize*(testIndex + 1) + 1):end]);
        testlabels = datalabels((partitionsize*(testIndex) + 1):(partitionsize*(testIndex + 1)));
    end
end