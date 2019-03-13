function test_acc = libsvm(train_x, train_y, test_x, test_y, C, d, g)

    if d == 0
        gamma = 4^g;
        [d2 d] = distMetric(train_x', train_x',eye(size(train_x,2)));
        gamma = gamma/d;
        opt = ['-q -t 2 -c ', num2str(C), ' -g ' num2str(gamma)];
    end
    if g == -10
        opt = ['-q -t 1 -c ', num2str(C), ' -d ' num2str(d)];
    end
    model = svmtrain2(train_y, train_x, opt);
    [y_hat, acc, a] = svmpredict2(test_y, test_x, model, '-q');
    test_acc = acc(1);
end