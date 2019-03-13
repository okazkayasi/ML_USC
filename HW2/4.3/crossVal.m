    
    function loocv = crossVal(trainX, trainY, reg,lambda)
        if size(trainX,1) < 2
            loocv = 1;
            return
        end
        A = trainX;
        B = trainY;
        a = [];
        for i = 1:size(trainX,1)
            trainX = A;
            trainY = B;
            cValX = trainX(i,:);
            cValY = trainY(i,:);
            trainX(i,:) = [];
            trainY(i) = [];
            if reg == 0
                a = [a logregGrad(trainX,trainY,cValX,cValY,0.15,500)];        
            else
                a = [a logregGradReg(trainX,trainY,cValX,cValY,0.15,500,lambda)];  
            end                   
        end
        loocv = mean(a);
    end