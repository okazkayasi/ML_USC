function q2()
    load emGMM.mat;
    val_logL = zeros(5,5);
    logL = zeros(5,5);
    iterator = zeros(5,5);
    for i = 1:5
        if i == 1
            K = 3;
        else 
            K = K + 2;
        end
        for j = 1:5
            K;
            [val_logL(i,j), logL(i,j), iterator(i,j)] = my_EMalg(dataTr, dataVal, K);
        end
    end
    fprintf('Answer to Question 4.2: \n');
    fprintf('Validation log likelihood values:');
    val_logL
    fprintf('Training data log likelihood values:');
    logL
    fprintf('The number of iterations till convergence:');
    iterator
end
