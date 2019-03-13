function [libsvm_acc,train_time,cv_libsvm] = polyLibsvm(train_x, train_y, test_x, test_y, number, power_range, d)
    tic;
    cv_libsvm = [];
    cv_time = [];
%     for i = power_range
%         tic;
%         c = number^i;
%         opt = ['-t 1 -c ', num2str(c), ' -d ', num2str(d), ' -v 3 -q'];
%         model = svmtrain2(train_y, train_x, opt);
%         cv_libsvm = [cv_libsvm model];
%         cv_time = [cv_time toc];
%     end
%     c_vals = number.^power_range;
%     cv_libsvm = [c_vals; cv_libsvm; cv_time];
%     cv_sorted = sortrows(cv_libsvm',-2);
%     c_opt = cv_sorted(1,1);

    libsvm_acc = {};
    for i = power_range
        tic;
        c = number^i
        opt = ['-b 1 -q -t 1 -c ', num2str(c), ' -d ' num2str(d)];
        model = svmtrain2(train_y, train_x, opt);
        [y_hat, acc, P] = svmpredict2(test_y, test_x, model, '-q -b 1');
        Probs{i+4} = P;
        yHat{i+4} = y_hat;
        libsvm_acc{i+4} = acc(1);
    end
    train_time = toc;
end