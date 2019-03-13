function [new_accu, train_accu] = knn_classify1(train_data, train_label, new_data, new_label, K)
% k-nearest neighbor classifier
% Input:
%  train_data: N*D matrix, each row as a sample and each column as a
%  feature
%  train_label: N*1 vector, each row as a label
%  new_data: M*D matrix, each row as a sample and each column as a
%  feature
%  new_label: M*1 vector, each row as a label
%  K: number of nearest neighbors
% 
% Output:
%  new_accu: accuracy of classifying new_data
%  train_accu: accuracy of classifying train_data (using leave-one-out
%  strategy)
% 
% CSCI 567: Machine Learning, Spring 2016, Homework 1

    train = normalizeData(train_data, train_data);
    new = normalizeData(new_data, train_data);
    predY = [];
    for i = 1:size(train_data,1)
        mat = bsxfun(@minus, train_data(i,:), train_data).^2;
        mat = sum(mat,2);
        mat(i) = NaN;
        minMat = [];
        indMat = [];
        for k = 1:K
            [not, ind] =  min(mat);
            indMat = [indMat, ind];
            minMat = [minMat, not];
            mat(ind) = NaN;
        end
        predY = [predY; mode(train_label(indMat,:),1)];
    end
    
    train_accu = mean(mean(predY == train_label,2));
    
    
    %%% I wrote another part here since I should not take out the original
    %%% data point like I did at training dataset.
    predY = [];
    for i = 1:size(new_data,1)
        mat = bsxfun(@minus, new_data(i,:), train_data).^2;
        mat = sum(mat,2);
        minMat = [];
        indMat = [];
        for k = 1:K
            [not, ind] =  min(mat);
            indMat = [indMat, ind];
            minMat = [minMat, not];
            mat(ind) = NaN;
        end 
        
        predY = [predY; mode(train_label(indMat,:),1)];
    end
    new_accu = mean(mean(predY == new_label,2));
    
    
    
end