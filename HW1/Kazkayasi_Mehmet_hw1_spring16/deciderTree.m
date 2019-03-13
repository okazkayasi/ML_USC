

function [newEntroY, newGiniY, trainEntroY, trainGiniY] = deciderTree(train_data, train_label, new_data, new_label)
    trainGiniY = [];
    newGiniY = [];
    for i=1:10
        tree = fitctree(train_data,train_label,'MinLeafSize',i,'SplitCriterion','gdi','prune','off');
        trainGiniY = [trainGiniY, mean(mean(predict(tree,train_data) == train_label))];
        newGiniY = [newGiniY, mean(mean(predict(tree,new_data) == new_label))];
    end
    trainEntroY = [];
    newEntroY = [];
    for i=1:10
        tree = fitctree(train_data,train_label,'MinLeafSize',i,'SplitCriterion','deviance','prune','off');
        trainEntroY = [trainEntroY, mean(mean(predict(tree,train_data) == train_label))];
        newEntroY = [newEntroY, mean(mean(predict(tree,new_data) == new_label))];
    end
    newEntroY = [1:10;newEntroY];
    trainEntroY = [1:10;trainEntroY];
    newGiniY = [1:10;newGiniY];
    trainGiniY = [1:10;trainGiniY];
end