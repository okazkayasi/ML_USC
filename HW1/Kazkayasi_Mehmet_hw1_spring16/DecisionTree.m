function DecisionTree()
    training = importdata('hw1_train.data');
    [train_data, train_label] = preProcess(training, training);
    [test_data, test_label] = preProcess(importdata('hw1_test.data'),training);
    [valid_data, valid_label] = preProcess(importdata('hw1_validation.data'),training);

    [validEntro, validGini, trainEntro,trainGini] = deciderTree(train_data, train_label, valid_data,valid_label);
    [testEntro, testGini, trainEntro,trainGini] = deciderTree(train_data, train_label, test_data,test_label);

    trainEntro
    trainGini
    validEntro
    validGini
    testEntro
    testGini
end