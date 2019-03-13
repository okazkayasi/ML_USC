function [accTest, accTrain] = logregGradReg(trainingX, trainingY, testingX, testingY, nu, iteration,lambda)
    
    %initialize w
    if size(trainingX,1) < 1 || size(testingX,1) < 1
        accTest = 1;
        accTrain = 1;
        return;
    end
    w = zeros(size(trainingX,2),1);
    W = w;
    j = crossEntErrorReg(w,trainingX,trainingY,lambda);
    J = j;
    accTrain = [];
    accTest = [];
    for i=1:iteration       
        w = w - nu .* gradReg(w,trainingX,trainingY,lambda);
        W = [W, w];
        accTrain = estimate(w,trainingX,trainingY);
        accTest = estimate(w,testingX,testingY);
        j = crossEntError(w,trainingX,trainingY);
        J = [J, j];
    end
end