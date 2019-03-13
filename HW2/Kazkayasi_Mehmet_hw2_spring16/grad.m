function [gradients] = grad(w,X,Y)
    gradients = ((sigmoidFunc(X*w)-Y)'*X)';

end
