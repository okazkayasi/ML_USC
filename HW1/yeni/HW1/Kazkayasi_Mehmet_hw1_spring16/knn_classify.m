function knn_classify()


    %%% Training data is shuffled since min function gets the first element
    %%% (lowest index) in case more than one data point is at the same
    %%% distance. That causes an unfairness while predicting Training data. 
    %%% Let's say first data point and last data point is at the same distance,
    %%% min function chooses first data point regardless. To prevent this and
    %%% give both data points equal chances, training data is shuffled. 

    %%% Shuffling process increased training accuracy significantly at low K
    %%% points.

    training = importdata('hw1_train.data');
    ordering = randperm(size(training,1));
    training = training(ordering,:);

    [train_data, train_label] = preProcess(training, training);
    [test_data, test_label] = preProcess(importdata('hw1_test.data'),training);
    [valid_data, valid_label] = preProcess(importdata('hw1_validation.data'),training);

    train_data = normalizeData(train_data, train_data);
    test_data = normalizeData(test_data, train_data);
    valid_data = normalizeData(valid_data, train_data);


    KNNvalid_accu = [];
    KNNtrain_accu = [];
    KNNtest_accu = [];
    for i = 1:8
        K = 2*i-1;
        [valid, train] = knn_classify1(train_data,train_label,valid_data,valid_label,K);
        [test, train] = knn_classify1(train_data,train_label,test_data,test_label,K);
        KNNvalid_accu = [KNNvalid_accu, valid];
        KNNtrain_accu = [KNNtrain_accu, train];
        KNNtest_accu = [KNNtest_accu, test];
    end
    KNNvalid_accu = [1,3,5,7,9,11,13,15; KNNvalid_accu]
    KNNtrain_accu = [1,3,5,7,9,11,13,15; KNNtrain_accu]
    KNNtest_accu = [1,3,5,7,9,11,13,15; KNNtest_accu]
end






