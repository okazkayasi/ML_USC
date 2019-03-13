function [crossEnt] = crossEntError(w,X,Y)
    crossEnt = (-Y)' * log(sigmoidFunc(X*w)) - (1-Y)' * log(1 - sigmoidFunc(X*w));
end
