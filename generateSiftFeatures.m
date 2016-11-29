function [siftfeatures] = generateSiftFeatures(data)
% Generates GIST features using LMgist for the CIFAR dataset format.
% NOTE: This function ONLY works with data given in the CIFAR dataset
% format. Attempting to use this function with any other dataset format
% will be...unpleasant.
    [nimages,~] = size(data);
    
    % Pre-allocate feature matrix for efficiency
    nfeatures = 0; %TODO: Calculate this (please don't be dynamic
    siftfeatures = zeros([nimages nfeatures]); 

    % Load first image and compute features
    % Future calls to LMgist will be faster
    img = rgb2gray(reshape(data(1,:),32,32,3));
    [siftfeatures(1, :), param] = 0; %TODO: Call sift.m
    
    % Compute features for remaining images
    for i = 2:nimages
        img = rgb2gray(reshape(data(i,:),32,32,3));
        siftfeatures(i, :) = 0; %TODO: Call sift.m
    end
end