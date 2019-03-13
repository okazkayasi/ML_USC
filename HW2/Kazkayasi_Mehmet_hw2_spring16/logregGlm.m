function [accTest, accTrain] = logregGlm(trainingX,trainingY,testingX,testingY)

    [w,dev,stats] = glmfit(trainingX,trainingY,'binomial','link','logit');
    trainFit = glmval(w,trainingX,'logit');
    trainFit(trainFit > 0.5) = 1;
    trainFit(trainFit <= 0.5) = 0;
    accTrain = mean(trainFit == trainingY);
    
    testFit = glmval(w,testingX,'logit');
    testFit(testFit > 0.5) = 1;
    testFit(testFit <= 0.5) = 0;
    accTest = mean(testFit == testingY);

end