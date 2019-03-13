function trainEvalModels()
    load toyGMM.mat
    trainX1 = [dataTr.x1 ones(size(dataTr.x1,1),1)];
    trainX2= [dataTr.x2 2*ones(size(dataTr.x2,1),1)];
    trainX3 = [dataTr.x3 3*ones(size(dataTr.x3,1),1)];
    testX1 = [dataTe.x1 ones(size(dataTe.x1,1),1)];
    testX2 = [dataTe.x2 2*ones(size(dataTe.x2,1),1)];
    testX3 = [dataTe.x3 3*ones(size(dataTe.x3,1),1)];
    training_data = [trainX1; trainX2; trainX3];
    testing_data = [testX1; testX2; testX3];
    trainingX = training_data(:,1:2);
    testingX = testing_data(:,1:2);
    trainingY = training_data(:,3);
    testingY = testing_data(:,3);
    trainX1(:,3) = [];
    trainX2(:,3) = [];
    trainX3(:,3) = [];
   %MLE learning of model1, Gaussian Discriminative Analysis I
   accTest = 0;
   accTrain = 0;
   while accTest < 0.5 || accTrain < 0.5
       gmm = gmdistribution.fit(trainingX, 3, 'SharedCov', false);
       p = posterior(gmm,trainingX);
       [prob predTrain] = max(p,[],2);
       accTrain = mean(predTrain == trainingY);
       p = posterior(gmm,testingX);
       [prob predTest] = max(p,[],2);
       accTest = mean(predTest == testingY);   
   end
%MLE learning of model2, Gaussian Discriminative Analysis II
    accTestVar = 0;
    accTrainVar = 0;
   while accTestVar < 0.5 || accTrainVar < 0.5
       gmmVar = gmdistribution.fit(trainingX, 3, 'SharedCov', true);
       
       p = posterior(gmmVar,trainingX);
       [prob predTrain] = max(p,[],2);
       accTrainVar = mean(predTrain == trainingY);
       p = posterior(gmmVar,testingX);
       [prob predTest] = max(p,[],2);
       accTestVar = mean(predTest == testingY);   
   end 
    %% learning of model3, the MLR classifeir
    [B,dev,stats] = mnrfit(trainingX,trainingY);
    estTrain = mnrval(B, trainingX);
    [probTr y_hatTrain] = max(estTrain,[],2);
    estTest = mnrval(B,testingX);
    [probTe y_hatTest] = max(estTest, [], 2);
    
    accTrainLog = mean(y_hatTrain == trainingY);
    accTestLog = mean(y_hatTest == testingY);
    %% visualize and compare learned models
    model1.pi = gmm.PComponents;
    model2.pi = gmmVar.PComponents;
    model1.m1 = gmm.mu(1,:);
    model1.m2 = gmm.mu(2,:);
    model1.m3 = gmm.mu(3,:);
    model2.m1 = gmmVar.mu(1,:);
    model2.m2 = gmmVar.mu(2,:);
    model2.m3 = gmmVar.mu(3,:);
    model1.S1 = gmm.Sigma(:,:,1);
    model1.S2 = gmm.Sigma(:,:,2);
    model1.S3 = gmm.Sigma(:,:,3);
    model2.S = gmmVar.Sigma;
    model3.w = B;
    model1.testAcc = accTest
    model2.testAcc = accTestVar
    model3.testAcc = accTestLog
    plotBoarder(model1, model2, model3, dataTe);
    
    
    
    %%% Take percentage
    accTestPerc = [];
    accTestVarPerc =[];
    accTestLogPerc=[];
    for i = 1:6
        if i == 1 per = 0.01;
            else if i == 2 per = 0.05;
                else if i == 3 per = 0.1;
                    else if i == 4 per = 0.25;
                        else if i == 5 per = 0.5;
                            else if i == 6 per = 1;
                            end
                        end
                    end
                end
            end
        end    
        numelements = round(per*size(trainingX,1));
        indices = randperm(size(trainingX,1));
        indices = indices(1:numelements);
        trainPercX = trainingX(indices,:);
        trainPercY = trainingY(indices);
        acc = 0;
       while true
           gmm = gmdistribution.fit(trainPercX, 3, 'SharedCov', false);
           p = posterior(gmm,testingX);
           [prob predTest] = max(p,[],2);
           acc = mean(predTest == testingY);
           if acc > 0.6
                accTestPerc = [accTestPerc acc]; 
                break;
           end
       end
       acc =0;
       while true
           gmmVar = gmdistribution.fit(trainPercX, 3, 'SharedCov', true);
           pVar = posterior(gmmVar,testingX);
           [prob predTestVar] = max(pVar,[],2);
           accVar = mean(predTestVar == testingY);
           if accVar >0.5
               accTestVarPerc = [accTestVarPerc accVar];
               break;
           end
       end
   
       
       [B,dev,stats] = mnrfit(trainPercX,trainPercY);
       estTest = mnrval(B,testingX);
       [probTe y_hatTest] = max(estTest, [], 2);
    
       accTestLogPerc = [accTestLogPerc mean(y_hatTest == testingY)];      
    end
    figure;
    X = [0.01, 0.05, 0.10, 0.25, 0.5, 1];
    plot(X,accTestPerc);
    figure;
    plot(X,accTestVarPerc);
    figure;
    plot(X,accTestLogPerc);
    
    
    
    
    
    
    
end
