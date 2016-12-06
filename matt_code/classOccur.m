function [ results] = classOccur(predicted, expected)
    len = length(expected);
    results = -ones(1,10);
    assert(len == length(predicted));
    for c = 0: (length(results) - 1)
       results(1 , c + 1) = length(find((predicted==expected) & (predicted == c)))y2;
    end
end
