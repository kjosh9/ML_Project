function [ model ] = multinomialNB( data, labels )

    %Get a vector of classes
    model.classes = unique(labels);
    
    %Get the number of classes
    model.numClasses = length(model.classes);
    
    %Get number of features
    [~, model.numFeatures] = size(data);
    
    %get number of occurences of each label
    numbClassOccurs = histcounts(labels);
    
    %vector of priors
    priors = zeros(1, model.numClasses);
    
    %matrix of Gaussian distributions
    model.distributions(model.numClasses, model.numFeatures) = prob.NormalDistribution(0,0);
    
    for c = 1 : model.numClasses
        %Determine prior of each class
        priors(c, 1) = numbClassOccurs(1, c) / length(labels);
        
        %get indices of data of this class
        indices = find(labels == model.classes(c));
        
        
        for f = 1 : model.numFeatures
            %Extract vector of data points where feature f belongs to 
            %class c
            classData = data(indices, f);
            
            %Fit a Gaussian to to this data and store it in the
            %distribution matrix
            model.distributions(c, f) = fitdist(classData, 'Normal');
   
        end
    end
end

