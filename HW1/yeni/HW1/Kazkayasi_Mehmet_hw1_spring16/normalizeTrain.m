function[normalized_X, normalized_Y] = normalizeData(data, label, train, trainLabel)
    x_hat = mean(train);
    stdevX = std(train);
    y_hat = mean(trainLabel);
    stdevY = std(trainLabel);
    
    normalized_X = bsxfun (@rdivide, (bsxfun(@minus, data, x_hat), stdevX));
    normalized_Y = bsxfun (@rdivide, (bsxfun(@minus, label, y_hat), stdevY);



end
