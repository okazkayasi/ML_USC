function opt = trainsvm(train_x, train_y, C)

    [n p] = size(train_x);
    %%C = 4^-6;
    H = eye(p);
    H(p+1,p+1) = 0;
    H(p+2:p+1+n,p+2:p+1+n) = 0;

    f = zeros(p+1,1);
    f = [f; C*ones(n,1)];

    yMat = diag(train_y,0);
    xMat = [train_x ones(n,1)];
    mat = yMat * xMat;
    A = -[mat eye(n)];
    b = -1 * ones(n,1);
    Aeq=[];
    Beq=[];
    lb = [-100 * ones(p+1,1); zeros(n,1)];
    [opt,fval] = quadprog(H,f,A,b,Aeq,Beq,lb);
end