%     modeldata1=fitgmdist(trainX1,1);
%     modeldata2=fitgmdist(trainX2,1);
%     modeldata3=fitgmdist(trainX3,1);
%     n = size(trainingX,1);
%     prior1 = size(trainX1,1)/n;
%     prior2 = size(trainX2,1)/n;
%     prior3 = size(trainX3,1)/n;
%     
%     Ptrain1 = 1/((2*pi) * sqrt(det(modeldata1.Sigma))) ...
%         * exp(-0.5*(bsxfun(@minus,trainingX,modeldata1.mu)) * modeldata1.Sigma^-1 *...
%         (bsxfun(@minus,trainingX,modeldata1.mu))');
%     prob1 = diag(Ptrain1);
%     
%     Ptrain2 = 1/((2*pi) * sqrt(det(modeldata2.Sigma))) ...
%         * exp(-0.5*(bsxfun(@minus,trainingX,modeldata2.mu)) * modeldata2.Sigma^-1 *...
%         (bsxfun(@minus,trainingX,modeldata2.mu))');
%     prob2 = diag(Ptrain2);
%         
%     Ptrain3 = 1/((2*pi) * sqrt(det(modeldata3.Sigma))) ...
%         * exp(-0.5*(bsxfun(@minus,trainingX,modeldata3.mu)) * modeldata3.Sigma^-1 *...
%         (bsxfun(@minus,trainingX,modeldata3.mu))');           
%     prob3 = diag(Ptrain3);      
%     
%     probsTrain = [prob1 prob2 prob3];
%     [prob predTrain] = max(probsTrain,[],2);
%     accTrain = mean(predTrain == trainingY);
%     
%     Ptest1 = 1/((2*pi) * sqrt(det(modeldata1.Sigma))) ...
%         * exp(-0.5*(bsxfun(@minus,testingX,modeldata1.mu)) * modeldata1.Sigma^-1 *...
%         (bsxfun(@minus,testingX,modeldata1.mu))');
%     prob1Test = diag(Ptest1);
%     
%     Ptest2 = 1/((2*pi) * sqrt(det(modeldata2.Sigma))) ...
%         * exp(-0.5*(bsxfun(@minus,testingX,modeldata2.mu)) * modeldata2.Sigma^-1 *...
%         (bsxfun(@minus,testingX,modeldata2.mu))');
%     prob2Test = diag(Ptest2);
%         
%     Ptest3 = 1/((2*pi) * sqrt(det(modeldata3.Sigma))) ...
%         * exp(-0.5*(bsxfun(@minus,testingX,modeldata3.mu)) * modeldata3.Sigma^-1 *...
%         (bsxfun(@minus,testingX,modeldata3.mu))');           
%     prob3Test = diag(Ptest3); 
%  
%     probsTest = [prob1Test prob2Test prob3Test];
%     [prob predTest] = max(probsTest,[],2);
%     accTest = mean(predTest == testingY);    
%     