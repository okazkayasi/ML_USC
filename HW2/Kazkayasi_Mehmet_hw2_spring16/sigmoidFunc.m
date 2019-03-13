function [g] = sigmoidFunc(z)
    g = 1 ./(1+ exp(-z));
    g(isnan(g)) = 0;
end
