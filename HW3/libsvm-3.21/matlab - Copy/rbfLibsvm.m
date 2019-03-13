function [libsvm_acc,train_time,cv_libsvm] = rbfLibsvm(train_x, train_y, test_x, test_y, number, power_range, n2, gamma)
    gamma = n2^gamma;
    tic;
    cv_libsvm = [];
    cv_time = [];
    [d2 d] = distMetric(train_x',train_x',eye(size(train_x,2)));
    gamma = gamma/d;
    for i = power_range
        tic;
        c = number^i;
        opt = ['-t 2 -c ', num2str(c), ' -g ', num2str(gamma), ' -v 3 -q'];
        model = svmtrain2(train_y, train_x, opt);
        cv_libsvm = [cv_libsvm model];
        cv_time = [cv_time toc];
    end
    c_vals = number.^power_range;
    cv_libsvm = [c_vals; cv_libsvm; cv_time];
    cv_sorted = sortrows(cv_libsvm',-2);
    c_opt = cv_sorted(1,1);
    train_time = toc;
    opt = ['-q -t 2 -c ', num2str(c_opt), ' -g ' num2str(gamma)];
    model = svmtrain2(train_y, train_x, opt);
    [y_hat, acc, a] = svmpredict2(test_y, test_x, model, '-q');
    libsvm_acc = acc(1);

end