function [grad] = gradReg(w,X,Y,lambda)
    m = length(Y);
    grad = (((sigmoidFunc(X*w) - Y)' * X)') ./ m + (lambda/m) * w;
    grad(1) = ((sigmoidFunc(X*w) - Y)' * X(:,1)) ./ m;

end
