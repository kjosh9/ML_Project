% function [ class ] = naiveBayesClassify(featureProbabilities, classProbability, testPoint)
% % Uses values learned in the naiveBayesLearn function to classify a movie
% % review
% 
%     if (1 - classProbability)*calculateClassProbability(-1, featureProbabilities, testPoint) <= classProbability*calculateClassProbability(1, featureProbabilities, testPoint)
%         class = 1;
%     else
%         class = -1;
%     end
% end

function [ class ] = naiveBayesClassify(featureProbabilities, classProbability, testPoint)
% Uses values learned in the naiveBayesLearn function to classify a movie
% review

    prob = classProbability / (1 - classProbability);
    for i = 1:size(testPoint, 2)
        if testPoint(i) == 1
            prob = prob * (featureProbabilities(i, 1)/featureProbabilities(i, 2));
        else
            prob = prob * ((1 - featureProbabilities(i, 1))/(1 - featureProbabilities(i, 2)));
        end
    end
    
    if prob >= 1
        class = 1;
    else
        class = -1;
    end
end

% function [p] = calculateClassProbability(class, probabilities, testPoint)
%     % Initialize the probability
%     p = 1;
%     
%     % Probabilities is given for class 1, so the corresponding
%     % probabilities for class -1 is 1 minus the probability
%     if class == -1
%         for i = 1:size(probabilities, 1)
%             if testPoint(i) == 1
%                 p = vpa(p * probabilities(i, 2));
%             else
%                 p = vpa(p * (1 - probabilities(i, 2)));
%             end
%         end
%     else
%         for i = 1:size(probabilities, 1)
%             if testPoint(i) == 1
%                 p = vpa(p * probabilities(i, 1));
%             else
%                 p = vpa(p * (1 - probabilities(i, 1))); 
%             end 
%         end
%     end
% end