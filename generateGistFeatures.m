function [gistfeatures] = generateGistFeatures(data)
% Generates GIST features using LMgist for the CIFAR dataset format.
% NOTE: This function ONLY works with data given in the CIFAR dataset
% format. Attempting to use this function with any other dataset format
% will be...unpleasant.
%
% This code is adapted from:
%    https://github.com/kavyasrinet/CIFAR-10/blob/master/code_with_GIST.m

    % Set GIST parameters
    clear param
    param.imageSize = [256 256]; % set a normalized image size
    param.orientationsPerScale = [8 8 8 8]; % number of orientations per scale (from HF to LF)
    param.numberBlocks = 4;
    param.fc_prefilt = 4;

    [nimages,~] = size(data);
    
    % Pre-allocate feature matrix for efficiency
    nfeatures = sum(param.orientationsPerScale)*param.numberBlocks^2;
    gistfeatures = zeros([nimages nfeatures]); 

    % Load first image and compute features
    % Future calls to LMgist will be faster
    img = reshape(data(1,:),32,32,3);
    [gistfeatures(1, :), param] = LMgist(img, '', param);
    
    % Compute features for remaining images
    for i = 2:nimages
        img = reshape(data(i,:),32,32,3);
        gistfeatures(i, :) = LMgist(img, '', param);
    end
end