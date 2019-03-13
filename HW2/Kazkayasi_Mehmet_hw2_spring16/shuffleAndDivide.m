function [training_data, testing_data] = shuffleAndDivide(rawData, trainPercentage)

    biasTerm = ones(size(rawData,1),1);
    data = [biasTerm, rawData];
    ordering = randperm(size(data,1));
    data = data(ordering,:);

    training_data = data(1:ceil(size(data,1)*trainPercentage),:);
    testing_data = data(ceil(size(data,1)*trainPercentage)+1:end,:);
    
end
