function[standard_train standard_test] = standardizeData(train, test)
      
    all_data = [train ; test];
    x_max = nanmax(all_data);
    x_min = nanmin(all_data);
    
    C = bsxfun(@minus,test,x_min);
    D = x_max - x_min;  
    standard_test = bsxfun(@rdivide,C,D);
    C = bsxfun(@minus,train,x_min);
    standard_train = bsxfun(@rdivide,C,D);
end
