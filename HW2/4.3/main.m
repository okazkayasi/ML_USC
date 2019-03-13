load toySpiral.mat
%%%discretization
 [trainAcc1, cvAcc1, testAcc1] = divideAndConquer(data1.xTr,data1.yTr,data1.xTe,data1.yTe);
 [trainAcc2, cvAcc2, testAcc2] = divideAndConquer(data2.xTr,data2.yTr,data2.xTe,data2.yTe);
 [trainAcc3, cvAcc3, testAcc3] = divideAndConquer(data3.xTr,data3.yTr,data3.xTe,data3.yTe);
 [trainAcc4, cvAcc4, testAcc4] = divideAndConquer(data4.xTr,data4.yTr,data4.xTe,data4.yTe);


%%%discretization with regularization
for i=1:4;
    lambda = 1/10^(i-1);
    [trainAccReg1{i}, cvAccReg1{i}, testAccReg1{i}] = divideAndReg(data1.xTr,data1.yTr,data1.xTe,data1.yTe,lambda)
    [trainAccReg2{i}, cvAccReg2{i}, testAccReg2{i}] = divideAndReg(data2.xTr,data2.yTr,data2.xTe,data2.yTe,lambda)
    [trainAccReg3{i}, cvAccReg3{i}, testAccReg3{i}] = divideAndReg(data3.xTr,data3.yTr,data3.xTe,data3.yTe,lambda)
    [trainAccReg4{i}, cvAccReg4{i}, testAccReg4{i}] = divideAndReg(data4.xTr,data4.yTr,data4.xTe,data4.yTe,lambda)
end


