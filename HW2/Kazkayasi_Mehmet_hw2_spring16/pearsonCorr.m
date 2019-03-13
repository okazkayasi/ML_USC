function prc = pearsonCorr(X,Y)
    X(:,1) = [];
    sumX = sum(X);
    sumY = sum(Y);
    sumXsq = sum(X.^2);
    sumYsq = sum(Y.^2);
    sumXY = X'*Y;
    n = size(X,1);
    prc = [];
    for i = 1:size(X,2)
       bot1 = n*sumXsq(i) - sumX(i)^2;
       bot2 = n*sumYsq - sumY^2;
       top = n*sumXY(i) - sumX(i) * sumY;
       prc(i) = top/sqrt(bot1 * bot2);    
    end
    
end