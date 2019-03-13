function[normalized_X] = normalizeData(data, train)


%%% labels are not normalized since they are categorical.
    x_hat = mean(train);
    stdevX = std(train);
    A = (bsxfun(@minus, data, x_hat));
    normalized_X = (bsxfun (@rdivide, A, stdevX));



end
