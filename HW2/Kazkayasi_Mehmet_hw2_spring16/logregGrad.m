function [accTest, accTrain] = logregGrad(trainingX, trainingY, testingX, testingY, lambda, iteration)
    
    %initialize w
    w = zeros(size(trainingX,2),1);
    W = w;
    j = crossEntError(w,trainingX,trainingY);
    J = j;
    accTrain = [];
    accTest = [];
    for i=1:iteration       
        w = w - lambda .* grad(w,trainingX,trainingY);
        W = [W, w];
        accuracyTrain = estimate(w,trainingX,trainingY);
        accuracyTest = estimate(w,testingX,testingY);
        accTrain = [accTrain accuracyTrain];
        accTest = [accTest accuracyTest]; 
        j = crossEntError(w,trainingX,trainingY);
        J = [J, j];
    end
end