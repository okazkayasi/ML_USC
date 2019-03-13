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
        K
        [val_logL(i,j), logL(i,j), iterator(i,j)] = my_EMalg(dataTr, dataVal, K);
    end
end