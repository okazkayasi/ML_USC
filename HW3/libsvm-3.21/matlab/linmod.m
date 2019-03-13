function [biases, variances] = linmod(n)
%n = 10;
    for i = 1:100
       x{i} = unifrnd(-1,1,n,1) ;
       y{i} = normrnd(2*x{i}.^2,sqrt(0.1));
       y_clean{i} = 2*x{i}.^2;
       
       yhat1{i} = 1;
       mse1{i} = ((yhat1{i} - y{i})' * (yhat1{i} - y{i}))/n;
       bias1{i} = ((yhat1{i} - y_clean{i})' * (yhat1{i} - y_clean{i}))/n;
       var1{i} = ((yhat1{i} - mean(yhat1{i}))' * (yhat1{i} - mean(yhat1{i})))/n;

       X = ones(n,1);
       w2{i} = (X'*X)^-1 * X'*y{i};
       yhat2{i} = X*w2{i};
       mse2{i} = ((yhat2{i} - y{i})' * (yhat2{i} - y{i}))/n;
       bias2{i} = ((yhat2{i} - y_clean{i})' * (yhat2{i} - y_clean{i}))/n;

%        w3{i} = (X'*X)^-1 * X'*y{i};
       mdl3{i} = fitlm(x{i},y{i});
       w3{i} = mdl3{i}.Coefficients.Estimate;
       yhat3{i} = predict(mdl3{i}, x{i});
             
%      yhat3{i} = X*w3{i};
       mse3{i} = ((yhat3{i} - y{i})' * (yhat3{i} - y{i}))/n;
       bias3{i} = ((yhat3{i} - y_clean{i})' * (yhat3{i} - y_clean{i}))/n;

%        X = [X, x{i}.^2];
%        w4{i} = (X'*X)^-1 * X'*y{i};
%        yhat4{i} = X*w4{i};
       X = [x{i}, x{i}.^2];
       mdl4{i} = fitlm(X,y{i});
       w4{i} = mdl4{i}.Coefficients.Estimate;    
       yhat4{i} = predict(mdl4{i}, X);
       mse4{i} = ((yhat4{i} - y{i})' * (yhat4{i} - y{i}))/n;
       bias4{i} = ((yhat4{i} - y_clean{i})' * (yhat4{i} - y_clean{i}))/n;

%        X = [X, x{i}.^3];
%        w5{i} = (X'*X)^-1 * X'*y{i};
%        yhat5{i} = X*w5{i};
       X = [x{i}, x{i}.^2, x{i}.^3];
       mdl5{i} = fitlm(X,y{i});
       w5{i} = mdl5{i}.Coefficients.Estimate;
       yhat5{i} = predict(mdl5{i}, X);
       mse5{i} = ((yhat5{i} - y{i})' * (yhat5{i} - y{i}))/n;
       bias5{i} = ((yhat5{i} - y_clean{i})' * (yhat5{i} - y_clean{i}))/n;

%        X = [X, x{i}.^4];
%        w6{i} = (X'*X)^-1 * X'*y{i};
%        yhat6{i} = X*w6{i};
       X = [x{i}, x{i}.^2, x{i}.^3, x{i}.^4];
       mdl6{i} = fitlm(X,y{i});
       w6{i} = mdl6{i}.Coefficients.Estimate;
       yhat6{i} = predict(mdl6{i}, X);
       mse6{i} = ((yhat6{i} - y{i})' * (yhat6{i} - y{i}))/n;
       bias6{i} = ((yhat6{i} - y_clean{i})' * (yhat6{i} - y_clean{i}))/n;

    end
    mean2 = mean(cell2mat(w2));
    x2 = ones(n,1);
    mean3 = mean(cell2mat(w3),2);
    mean4 = mean(cell2mat(w4),2);   
    mean5 = mean(cell2mat(w5),2);
    mean6 = mean(cell2mat(w6),2); 
    
    for i = 1:100
        x3 = [x2, x{i}];
        x4 = [x3, x{i}.^2];
        x5 = [x4, x{i}.^3];
        x6 = [x5, x{i}.^4];
        var2{i} = ((x2*w2{i} - x2*mean2)'*(x2*w2{i} - x2*mean2))/n;
        var3{i} = ((x3*w3{i} - x3*mean3)'*(x3*w3{i} - x3*mean3))/n;
        var4{i} = ((x4*w4{i} - x4*mean4)'*(x4*w4{i} - x4*mean4))/n;
        var5{i} = ((x5*w5{i} - x5*mean5)'*(x5*w5{i} - x5*mean5))/n;
        var6{i} = ((x6*w6{i} - x6*mean6)'*(x6*w6{i} - x6*mean6))/n;
    end

    
    biases = [mean(cell2mat(bias1)); mean(cell2mat(bias2)); mean(cell2mat(bias3)); ...
        mean(cell2mat(bias5)); mean(cell2mat(bias5)); mean(cell2mat(bias6))];
    variances = [mean(cell2mat(var1)); mean(cell2mat(var2)); mean(cell2mat(var3)); ...
        mean(cell2mat(var4)); mean(cell2mat(var5)); mean(cell2mat(var6))];
    

    figure;
    hist(cell2mat(bias1),10,1,'w'),title(['Histogram of MSE for g1, sample number =',num2str(n)]);
    figure;
    hist(cell2mat(bias2),10,1,'w'),title(['Histogram of MSE for g2, sample number =',num2str(n)]);
    figure;
    hist(cell2mat(bias3),10,1,'w'),title(['Histogram of MSE for g3, sample number =',num2str(n)]);
    figure;
    hist(cell2mat(bias4),10,1,'w'),title(['Histogram of MSE for g4, sample number =',num2str(n)]);
    figure;
    hist(cell2mat(bias5),10,1,'w'),title(['Histogram of MSE for g5, sample number =',num2str(n)]);
    figure;
    hist(cell2mat(bias6),10,1,'w'),title(['Histogram of MSE for g6, sample number =',num2str(n)]);

    
end
