function test_acc = ownlinear(train_x, train_y, test_x, test_y, C)
    opt = trainsvm(train_x, train_y,C);
    w = opt(1:19);
    b = opt(20);
    eta = opt(21:end);
    test_acc = testsvm(w,b,test_x,test_y);
end