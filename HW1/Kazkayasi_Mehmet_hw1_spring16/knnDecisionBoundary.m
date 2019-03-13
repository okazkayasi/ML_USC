function [predY] = knnDecisionBoundary(training, labels, boundaryData, K)
    predY = [];
    for i = 1:size(boundaryData,1)
        mat = bsxfun(@minus, boundaryData(i,:), training).^2;
        mat = sum(mat,2);
        minMat = [];
        indMat = [];
        for k = 1:K
            [not, ind] =  min(mat);
            indMat = [indMat, ind];
            minMat = [minMat, not];
            mat(ind) = NaN;
        end 
        predY = [predY; mode(labels(indMat,:),1)];
    end
end