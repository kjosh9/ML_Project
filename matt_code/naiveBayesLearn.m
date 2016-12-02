function [featureProbabilities,  classProbability] = naiveBayesLearn( data, labels )
% Learns parameters for movie review classification

    % Initialization
    numClasses = 2;
    numData = size(data, 1);
    numFeatures = size(data, 2);
    featureCounts = ones(numFeatures,numClasses);
    classCount = 0;
    
    % Count occurrences of class 1 and features that occur with class 1
    % data points
    for i = 1:numData
        if labels(1, i) == 1
            % Increase count for true features
            for j = 1:numFeatures
                if data(i, j) == 1
                    featureCounts(j, 1) = featureCounts(j, 1) + 1;
                end
            end
            
            % Increase class count
            classCount = classCount + 1;
        else
            % Increase count for true features
            for j = 1:numFeatures
                if data(i, j) == 1
                    featureCounts(j, 2) = featureCounts(j, 2) + 1;
                end
            end
        end
    end
    
    % Calculate probabilities
    featureProbabilities(:, 2) = featureCounts(:, 2)/classCount;
    featureProbabilities(:, 1) = featureCounts(:, 1)/(numData - classCount);
    classProbability = classCount/numData;
end

