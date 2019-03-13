function [crossEnt] = crossEntErrorReg(w,X,Y,lambda)
    n = length(Y);
    crossEnt = ((-Y)' * log(sigmoidFunc(X*w)) - (1-Y)' * log(1 - sigmoidFunc(X*w))) ...
        /n + (lambda/2*n)*w(2:end)'*w(2:end);
end
