function [libsvm_acc,train_time, cv_libsvm] = myLibsvm(train_x, train_y, test_x, test_y, number, power_range, d)
    tic;
    cv_libsvm = [];
    cv_time = [];
    for i = power_range
        tic;
        c = number^i;
        opt = ['-t 0 -c ', num2str(c), ' -v 3 -q'];
        model = svmtrain2(train_y, train_x, opt);
        cv_libsvm = [cv_libsvm model];
        cv_time = [cv_time toc];
    end
    c_vals = number.^power_range;
    cv_libsvm = [c_vals; cv_libsvm; cv_time];
    cv_sorted = sortrows(cv_libsvm',-2);
    c_opt = cv_sorted(1,1);
    train_time = toc;
    opt = ['-q -t 0 -c ', num2str(c_opt)];
    model = svmtrain2(train_y, train_x, opt);
    [y_hat, acc, a] = svmpredict2(test_y, test_x, model, '-q');
    libsvm_acc = acc(1);

end