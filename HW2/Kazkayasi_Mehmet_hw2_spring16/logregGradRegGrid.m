function [accTest, accTrain] = logregGradRegGrid(trainingX, trainingY, testingX, testingY, nu, iteration,lambda)
    training = [trainingX, trainingY];
    testing = [testingX, testingY];    
    sep1 = -2;
    for i = 1:8
        sep = sep1 + (4/8);
        coorX{i} = training(training(:,1) < sep & training(:,1) >= sep1,:);
        coorY{i} = training(training(:,2) < sep & training(:,2) >= sep1,:);
        testCoorX{i} = testing(testing(:,1) < sep & testing(:,1) >= sep1,:);
        testCoorY{i} = testing(testing(:,2) < sep & testing(:,2) >= sep1,:);
        sep1 = sep;
    end    
    w = {};
    for i = 1:8
        for j = 1:8
            w{i,j} = zeros(size(trainingX,2)+1,1);
        end
    end
    for k=1:iteration       
        for i = 1:8
            for j = 1:8
                n = 0;
                wNbor = 0;
                if i == 1
                    wNbor = w{i+1,j}; n = n + 1;
                        else if i == 8
                        wNbor = w{i-1,j}; n = n + 1;
                        else 
                            wNbor = w{i+1,j} + w{i-1,j}; n = n + 2;
                        end
                end
                if j == 1
                    wNbor = wNbor + w{i,j+1}; n = n + 1;
                    else if j == 8
                        wNbor = wNbor + w{i,j-1}; n = n + 1;
                        else 
                            wNbor = wNbor + w{i,j+1} + w{i,j-1}; n = n + 2;
                        end
                end
                part{i,j} = intersect(coorX{i},coorY{j},'rows');
                part2{i,j} = intersect(testCoorX{i},testCoorY{j},'rows');
                trainX{i,j} = part{i,j}(:,1:2);
                trainY{i,j} = part{i,j}(:,3)-1;
                testX{i,j} = part2{i,j}(:,1:2);
                testY{i,j} = part2{i,j}(:,3)-1;
                
                             
                w{i,j} = w{i,j} - nu .* gradRegGrid(w{i,j},trainX{i,j},trainY{i,j}, lambda, wNbor, n);
                
                weightTrain{i,j} = size(trainX{i,j},1);
                weightTest{i,j} = size(testX{i,j},1);
                accTrainMat{i,j} = estimate(w{i,j},trainX{i,j},trainY{i,j});
                accTestMat{i,j} = estimate(w{i,j},testX{i,j},testY{i,j});    
            end
        end
    end
    accTrain = 0;
    accTest = 0;
    totalWeightTr = 0;
    totalWeightTe = 0;
    for i = 1:8
        for j = 1:8
            if weightTrain{i,j} > 0
                accTrain = accTrain + accTrainMat{i,j};
                totalWeightTr = weightTrain{i,j};
            end
            if weightTest{i,j} >0
                accTest = accTest + accTestMat{i,j};
                totalWeightTe = weightTest{i,j};
            end
        end
    end
    accTrain = accTrain / totalWeightTr;
    accTest = accTest/ totalWeightTe;           
end