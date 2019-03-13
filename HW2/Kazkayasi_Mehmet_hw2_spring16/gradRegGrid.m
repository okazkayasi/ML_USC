function [grad] = gradRegGrid(w,X,Y,lambda,wNbor,n)
    m = length(Y);
    grad = (((sigmoidFunc(X*w) - Y)' * X)') ./ m - (lambda)*(n*w - wNbor);
    grad(1) = ((sigmoidFunc(X*w) - Y)' * X(:,1)) ./ m;

end