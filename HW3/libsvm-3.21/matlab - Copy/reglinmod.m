function [bias, variance] = reglinmod(lambda)
    n = 100;
    for i = 1:100
       x{i} = unifrnd(-1,1,n,1) ;
       y{i} = normrnd(2*x{i}.^2,sqrt(0.1));
       y_clean{i} = 2*x{i}.^2;
       
       X = [ones(n,1), x{i}, x{i}.^2];
       w{i} = (X'* X +lambda * eye(3))^-1 *X' *y{i};
       yhat{i} = X*w{i};
       mse{i} = ((yhat{i} - y{i})' * (yhat{i} - y{i}))/n;
       bias_all{i} = ((yhat{i} - y_clean{i})' * (yhat{i} - y_clean{i}))/n;        
    end
    bias = mean(cell2mat(bias_all));
    
    mean4 = mean(cell2mat(w),2);
    
    for i = 1:100
        var{i} = ((X*w{i} - X*mean4)'*(X*w{i} - X*mean4))/n; 
    end
    
    variance = mean(cell2mat(var));

end