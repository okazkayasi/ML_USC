function [c_val, cv_acc] = crossvalidate(train_x, train_y, number, power_range)
    tic;
    [n p] = size(train_x);
    ordering = randsample(n,n);
    first = ordering(1:n/3);
    second = ordering(n/3+1:2*n/3);
    third = ordering(2*n/3+1:end);
    fold1_x = train_x(first,:);
    fold1_y = train_y(first);
    fold2_x = train_x(second,:);
    fold2_y = train_y(second);
    fold3_x = train_x(third,:);
    fold3_y = train_y(third);

    %%%%%%% Cross Validation
    cv_time1 = [];
    cv1_acc = [];
    for i = power_range
        tic;
        opt = trainsvm([fold1_x;fold2_x],[fold1_y;fold2_y],number^i);
        w = opt(1:19);
        b = opt(20);
        cv1_acc = [cv1_acc testsvm(w,b,fold3_x,fold3_y)];
        cv_time1 = [cv_time1 toc];
    end
    cv2_acc = [];
    cv_time2 = [];
    for i = power_range
        tic;
        opt = trainsvm([fold1_x;fold3_x],[fold1_y;fold3_y],number^i);
        w = opt(1:19);
        b = opt(20);
        cv2_acc = [cv2_acc testsvm(w,b,fold2_x,fold2_y)];
        cv_time2 = [cv_time2 toc];
    end
    cv3_acc = [];
    cv_time3 = [];
    for i = power_range
        tic;
        opt = trainsvm([fold2_x;fold3_x],[fold2_y;fold3_y],number^i);
        w = opt(1:19);
        b = opt(20);
        eta = opt(21:end);
        cv3_acc = [cv3_acc testsvm(w,b,fold1_x,fold1_y)];
        cv_time3 = [cv_time3 toc];
    end
    cv_time = [cv_time1; cv_time2; cv_time3];
    
    cv_accMat = [cv1_acc; cv2_acc; cv3_acc];
    c_vals = number.^power_range;
    cv_acc = [c_vals; mean(cv_accMat); sum(cv_time)];
    cv_sorted = sortrows(cv_acc',-2);
    c_val = cv_sorted(1,1);
    
end