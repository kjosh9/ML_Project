
%testfeatgist - testdata
%trainlabels - trainlabels
%trainfeatgist - traindata
%k - number of nearest neighbors
%f - distance metric
%D - ?


%this really only works with euclidean distance

function predlabels = knn(traindata, trainlabels, testdata, k, f, D)
    

    %calculate the dissimilarity of the test point x onto each of the train points    
    l1 = size(testdata, 1);
    predlabels = zeros(l1,1);
    
    for i = 1:l1
        
        Dist = pdist2(testdata(i,:), traindata, f);
               
        %find the train point x^n wich is nearest to x
        
        %sort the stuff to be in an order of least to greatest
        [sortdist, distindex] = sort(Dist);
        
        classes = zeros(k,1);
        
        %find the i3th closest index
        %put in kindex
            
        classes(1:k,1) = trainlabels(distindex(1,1:k),1);
        
        
        %assign the class label
        %find the most common class of kindex and assign to predlabels(i)
        predlabels(i,1) = mode(classes);
        
        %in the case that there are two or more nearest neighbours with
        %different class labels, the most numerous class is chosen.
        %maybe not instantiate this
               
    end
end



