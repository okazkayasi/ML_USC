function [trainAccuracy, cvVal, testAccuracy] = divideAndReg(trX,trY,teX,teY,lambda)
    training = [trX, trY];
    testing = [teX, teY];
    divide = 8;
    sep1 = -2;
    for i = 1:divide
        sep = sep1 + (4/divide);
        coorX{i} = training(training(:,1) < sep & training(:,1) >= sep1,:);
        coorY{i} = training(training(:,2) < sep & training(:,2) >= sep1,:);
        testCoorX{i} = testing(testing(:,1) < sep & testing(:,1) >= sep1,:);
        testCoorY{i} = testing(testing(:,2) < sep & testing(:,2) >= sep1,:);
        sep1 = sep;
    end
    crossAcc = [];
    weightAcc = [];
    testAcc =[];
    trainAcc = [];
    for i = 1:divide
        for j = 1:divide
            part{i,j} = intersect(coorX{i},coorY{j},'rows');
            part2{i,j} = intersect(testCoorX{i},testCoorY{j},'rows');
            trainX{i,j} = part{i,j}(:,1:2);
            trainX{i,j} = [ones(size(trainX{i,j},1),1) trainX{i,j}];
            trainY{i,j} = part{i,j}(:,3)-1;
            testX{i,j} = part2{i,j}(:,1:2);
            testX{i,j} = [ones(size(testX{i,j},1),1) testX{i,j}];
            testY{i,j} = part2{i,j}(:,3)-1;
            [testA trainA] = logregGradReg(trainX{i,j}, trainY{i,j}, testX{i,j}, testY{i,j},0.1,1000,lambda);
            testAcc = [testAcc testA];
            trainAcc = [trainAcc trainA];
            cross = crossVal(trainX{i,j}, trainY{i,j},1,lambda);
            crossAcc = [crossAcc cross];
            weightAcc = [weightAcc; size(trainX{i,j},1)];
        end
    end    
    cvVal = crossAcc * weightAcc / sum(weightAcc);
    trainAccuracy = trainAcc * weightAcc / sum(weightAcc);
    testAccuracy = testAcc * weightAcc / sum(weightAcc);


end