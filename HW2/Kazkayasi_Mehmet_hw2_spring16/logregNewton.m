function [accTest, accTrain] = logregNewton(trainingX,trainingY,testingX,testingY)
    
    w = zeros(size(trainingX,2),1);
    j = crossEntError(w,trainingX,trainingY);
    W = w; J = j;
    accTrain=estimate(w,trainingX,trainingY);
    accTest=estimate(w,testingX,testingY);
    for i = 1:10    
        w = w - inv(hessian(w,trainingX)) * grad(w,trainingX,trainingY);
        W = [W, w];
        accuracyTrain = estimate(w,trainingX,trainingY);
        accuracyTest = estimate(w,testingX,testingY);
        accTrain = [accTrain accuracyTrain];
        accTest = [accTest accuracyTest]; 
        j = crossEntError(w,trainingX,trainingY);
        J = [J, j];
    end
end