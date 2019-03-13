load diabetic-test.mat;
test_x = x;
test_y = y;
test_y(test_y == 0) = -1;
load diabetic-train.mat;
train_x = x;
train_y = y;
train_y(train_y == 0) = -1;
[train_x, test_x] = standardizeData(train_x, test_x);
