function [trainAccuracies, cvVal, testAccuracies] = divideAndConquer(trX,trY,teX,teY)

    training = [trX, trY];
    testing = [teX, teY];
    k = 2;
    cvVal = [];
    trainAccuracies = [];
    testAccuracies = [];
    while k < 17
        divide = k;
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
                [testA trainA] = logregGrad3(trainX{i,j}, trainY{i,j}, testX{i,j}, testY{i,j},0.1,1000);
                testAcc = [testAcc testA];
                trainAcc = [trainAcc trainA];
                cross = crossVal(trainX{i,j}, trainY{i,j},0,1);
                crossAcc = [crossAcc cross];
                weightAcc = [weightAcc; size(trainX{i,j},1)];
            end
        end    
        cv = crossAcc * weightAcc / sum(weightAcc);
        weighted_train = trainAcc * weightAcc / sum(weightAcc);
        weighted_test = testAcc * weightAcc / sum(weightAcc);
        trainAccuracies = [trainAccuracies weighted_train];
        testAccuracies = [testAccuracies weighted_test];
        cvVal = [cvVal cv]; 

        k = k*2
    end

end



