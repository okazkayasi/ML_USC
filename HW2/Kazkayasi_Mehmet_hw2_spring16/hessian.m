function [H] = hessian(w,trainingX)   
    H = (sigmoidFunc(trainingX*w))' * (1 - sigmoidFunc(trainingX*w)) * trainingX' * trainingX;
end