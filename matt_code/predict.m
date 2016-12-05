function [ predictions ] = predict( model, data)
    %Get number of test data and features
    [numbData, ~] = size(data);
    
    %initialize vector of predictions
    predictions = -ones(numbData, 1);
    
    for i = 1 : numbData
        %fprintf('%d\n',i);
        %make row vector of probabilities on classes
        pred_array = zeros(1, model.numClasses);
        
        for c = 1 : model.numClasses
            for f = 1 : model.numFeatures
                pred_array(1, c) = pred_array(1, c) + log(pdf(model.distributions(c, f), data(i, f)));
            end
        end
        %find class with maximum position
        [~, index] = max(pred_array);
        
        %store predicted class
        predictions(i, 1) = model.classes(index, 1);
    end
    
end

