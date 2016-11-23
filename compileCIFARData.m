function [fullData, fullLabels] = compileCIFARData(fileList, displayLabel)
% Concatenates the batches from the CIFAR dataset into a matrix of all data
% points and a vector of all labels.
%
% fileList must be given as a cell array of strings.

    % Prepare these matrices for massive amounts of data
    fullData = [];
    fullLabels = [];
    
    % Load and cat all data and labels
    for batch = fileList
        % Load the data
        load(batch{1});
        
        % Display label
        if exist('displayLabel','var') ~= 0
            fprintf('Processing %s\n', batch_label);
        end
        
        % Concatenate data and labels
        fullData = cat(1, fullData, data);
        fullLabels = cat(1, fullLabels, labels);
        
        % Clear out variables rather than overwriting
        clearvars data labels
    end
end