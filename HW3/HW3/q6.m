function q6()
    fprintf('Answer for 6.1 - 10 data points:');
    [bias10 var10] = linmod(10)
    fprintf('Answer for 6.2 - 100 data points:');
    [bias100 var100] = linmod(100) 
    fprintf('Answer for 6.4 - 100 data points and lambda = 0.01:');
    [biasreg1 varreg1] = reglinmod(0.01)
    fprintf('Answer for 6.4 - 100 data points and lambda = 0.1:');
    [biasreg2 varreg2] = reglinmod(0.1)
    fprintf('Answer for 6.4 - 100 data points and lambda = 1:');
    [biasreg3 varreg3] = reglinmod(1)
    fprintf('Answer for 6.4 - 100 data points and lambda = 10:');
    [biasreg4 varreg4] = reglinmod(10)
end