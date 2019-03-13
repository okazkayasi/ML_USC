function q5()
    clear all;
    format short g;
    load diabetic-test.mat;
    test_x = x;
    test_y = y;
    test_y(test_y == 0) = -1;
    load diabetic-train.mat;
    train_x = x;
    train_y = y;
    train_y(train_y == 0) = -1;
    [train_x, test_x] = standardizeData(train_x, test_x);



    %5.3
    %%% crossvalidate function returns the best C value among 
    %%% 4^-6,4^-5,...,4^2 values
    %%% User can modify the number and power range (3rd and 4th)
    %%% input variables
    [c_val cv_data] = crossvalidate(train_x, train_y, 4, -6:2);
    test_acc = ownlinear(train_x, train_y, test_x, test_y, c_val);

    %5.4
    [libsvm_acc, libsvm_train_time, cv_mat] = myLibsvm(train_x, train_y, test_x, test_y, 4, -6:2);

    %5.5.a
    polAccuracy = {};
    pol_total_time = {};
    polCVmat = {};
    for d = 1:3
        [polAccuracy{d}, pol_total_time{d}, polCVmat{d}] = polyLibsvm(train_x, train_y, test_x, test_y, 4, -3:7, d);
    end
    %5.5.b
    rbfAccuracy = {};
    rbf_total_time = {};
    rbfCVmat = {};
    for g = 1:10
        [rbfAccuracy{g}, rbf_total_time{g}, rbfCVmat{g}] = rbfLibsvm(train_x, train_y, test_x, test_y, 4, -3:7, 4, g-8);
    end




    fprintf('Answer to 5.3(first row C, second average accuracy, third average time):');
    cv_data
    fprintf('Best C value according to CV is:');
    c_val
    fprintf('Test Accuracy using the best C Value:');
    test_acc
    fprintf('Answer to 5.4(first row C, second average accuracy, third average time):');
    cv_mat
    fprintf('Answer to 5.5.a Polynomial(first row C, second average accuracy, third average time):');
    fprintf('For D = 1:');
    polCVmat{1}
    fprintf('For D = 2:');
    polCVmat{2}
    fprintf('For D = 3:');
    polCVmat{3}
    fprintf('Answer to 5.5.b RBF Kernel(first row C, second average accuracy, third average time):');
    fprintf('For gamma = (4^-7)/d:');
    rbfCVmat{1}
    fprintf('For gamma = (4^-6)/d:');
    rbfCVmat{2}
    fprintf('For gamma = (4^-5)/d:');
    rbfCVmat{3}
    fprintf('For gamma = (4^-4)/d:');
    rbfCVmat{4}
    fprintf('For gamma = (4^-3)/d:');
    rbfCVmat{5}
    fprintf('For gamma = (4^-2)/d:');
    rbfCVmat{6}
    fprintf('For gamma = (4^-1)/d:');
    rbfCVmat{7}
    fprintf('For gamma = (4^0)/d:');
    rbfCVmat{8}
    fprintf('For gamma = (4^1)/d:');
    rbfCVmat{9}
    fprintf('For gamma = (4^2)/d:');
    rbfCVmat{10}

    X = sortrows(polCVmat{1}',-2);
    polCV1 = [X(1,1:2), 1, -10];
    X = sortrows(polCVmat{2}',-2);
    polCV2 = [X(1,1:2), 2, -10];
    X = sortrows(polCVmat{3}',-2);
    polCV3 = [X(1,1:2), 3, -10];

    X = sortrows(rbfCVmat{1}',-2);
    rbfCV1 = [X(1,1:2), 0, -7];
    X = sortrows(rbfCVmat{2}',-2);
    rbfCV2 = [X(1,1:2), 0, -6];
    X = sortrows(rbfCVmat{3}',-2);
    rbfCV3 = [X(1,1:2), 0, -5];
    X = sortrows(rbfCVmat{4}',-2);
    rbfCV4 = [X(1,1:2), 0, -4];
    X = sortrows(rbfCVmat{5}',-2);
    rbfCV5 = [X(1,1:2), 0, -3];
    X = sortrows(rbfCVmat{6}',-2);
    rbfCV6 = [X(1,1:2), 0, -2];
    X = sortrows(rbfCVmat{7}',-2);
    rbfCV7 = [X(1,1:2), 0, -1];
    X = sortrows(rbfCVmat{8}',-2);
    rbfCV8 = [X(1,1:2), 0, 0];
    X = sortrows(rbfCVmat{9}',-2);
    rbfCV9 = [X(1,1:2), 0, 1];
    X = sortrows(rbfCVmat{10}',-2);
    rbfCV10 = [X(1,1:2), 0, 2];

    allMatrix = [polCV1; polCV2; polCV3; rbfCV1; rbfCV2; rbfCV3; rbfCV4;...
        rbfCV5; rbfCV6; rbfCV7; rbfCV8; rbfCV9; rbfCV10];

    X = sortrows(allMatrix, -2);
    c = X(1,1);
    d = X(1,3);
    gamma = X(1,4);
    test_accuracy = libsvm(train_x, train_y, test_x, test_y, c, d, gamma);
    fprintf('Answer to 5.5 Test Accuracy:');
    test_accuracy
end