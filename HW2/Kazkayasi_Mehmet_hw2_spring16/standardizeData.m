function[standard_train standard_test] = standardizeData(test, train)
    
    hold = train(:,1);
    hold2 = test(:,1);
    train(:,1) = [];
    test(:,1) = [];
    
    all_data = [train ; test];
    x_max = nanmax(all_data);
    x_min = nanmin(all_data);
    
    C = bsxfun(@minus,test,x_min);
    D = x_max - x_min;  
    std_test = bsxfun(@rdivide,C,D);
    standard_test = [hold2 std_test];
    C = bsxfun(@minus,train,x_min);
    std_train = bsxfun(@rdivide,C,D);
    standard_train = [hold std_train];
end
