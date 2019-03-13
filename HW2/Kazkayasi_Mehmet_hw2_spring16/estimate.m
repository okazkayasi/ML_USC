function [acc] = estimate(w,X,Y)
    estimateY = sigmoidFunc(X*w);
    estimateY(estimateY > 0.5) = 1;
    estimateY(estimateY <= 0.5) = 0;
    acc = mean(estimateY == Y);
end