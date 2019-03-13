function question1()
    data = importdata('spambase.data');
    [training_data, testing_data] = shuffleAndDivide(data, 0.5);

    trainingX = training_data(:,1:end-1);
    trainingY = training_data(:,end);
    testingX = testing_data(:,1:end-1);
    testingY = testing_data(:,end);

    [std_trainingX std_testingX] = standardizeData(testingX, trainingX);

    %%%logistic regression using Gradient Descent Batch
    [accTestGrad, accTrainGrad] = logregGrad(trainingX,trainingY,testingX, testingY, 0.000000015, 50000);
    %normalized
    [accTestGradStd, accTrainGradStd] = logregGrad(std_trainingX,trainingY,std_testingX, testingY, 0.01, 5000);
    testAccuracyGradient = accTestGrad(50000)
    trainAccuracyGradient = accTrainGrad(50000)
    trainAccuracyGradientStd = accTrainGradStd(5000)
    testAccuracyGradientStd = accTestGradStd(5000)
    x1 = 1:50000;
    x2 = 1:5000;
    figure;
    scatter(x1,accTrainGrad);
    figure;
    scatter(x1,accTestGrad);
    figure;
    plot(x2,accTrainGradStd);
    figure;
    plot(x2, accTestGradStd);

    %%logistic regression using Newton's Method
    [newtonTest, newtonTrain] = logregNewton(trainingX,trainingY,testingX,testingY);
    [newtonTestStd, newtonTrainStd] = logregNewton(std_trainingX,trainingY,std_testingX,testingY);
    testAccuracyNewton = newtonTest(11)
    trainAccuracyNewton = newtonTrain(11)
    testAccuracyNewtonStd = newtonTestStd(11)
    trainAccuracyNewtonStd = newtonTrainStd(11)
    x = 1:11;
    figure;
    plot(x,newtonTrain);
    figure;
    plot(x,newtonTest);
    figure;
    plot(x,newtonTrainStd);
    figure;
    plot(x,newtonTestStd);
    % 
    %%%%% Using glmfit function
    [glmTest, glmTrain] = logregGlm(trainingX,trainingY,testingX,testingY);
    [glmTestStd, glmTrainStd] = logregGlm(std_trainingX,trainingY,std_testingX,testingY);
    trainAccuracyGlm = glmTrain
    testAccuracyGlmStd = glmTestStd
    trainAccuracyGlmStd = glmTrainStd 
    testAccuracyGlm = glmTest
    mi = mutualInfo(trainingX,trainingY);
    prc = pearsonCorr(trainingX,trainingY);
    compare = [mi' prc' (1:57)'];
    comp = sortrows(compare, -1);
    subplot(1,2,1);
    plot(mi);
    subplot(1,2,2);
    plot(abs(prc));
    indices = comp(1:20,3);
    indices
    [glmTestMI, glmTrainMI] = logregGlm(std_trainingX(:,indices),trainingY,std_testingX(:,indices),testingY);
    glmTestMI
    glmTrainMI

end

