function [accTest, accTrain] = logregGrad3(trainingX, trainingY, testingX, testingY, nu, iteration)
    %initialize w
    if size(trainingX,1) < 1 || size(testingX,1) < 1
        accTest = 1;
        accTrain = 1;
        return;
    end
    w = zeros(size(trainingX,2),1);
    W = w;
    j = crossEntError(w,trainingX,trainingY);
    J = j;
    accTrain = [];
    accTest = [];
    for i=1:iteration       
        w = w - nu .* grad(w,trainingX,trainingY);
        W = [W, w];
        accTrain = estimate(w,trainingX,trainingY);
        accTest = estimate(w,testingX,testingY);
        j = crossEntError(w,trainingX,trainingY);
        J = [J, j];
    end
end