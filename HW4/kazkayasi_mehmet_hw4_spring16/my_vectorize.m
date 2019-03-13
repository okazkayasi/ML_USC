function weird = my_vectorize(data,K)
    n = size(data,1);
    m = size(data,2);
    %%%%%K = 5;
    %%% Initialize the centroids randomly
    for i = 1:K
        c{i} = zeros(1,m);
        for j = 1:m
            c{i}(j) = min(data(:,j))+ (max(data(:,j))-min(data(:,j))) * rand();  
        end
    end
    ind = zeros(n,1);
    holdIt = ones(n,1);
    count = 0;
    while mean(mean(ind == holdIt)) ~= 1 & count < 100
        %%% assign each data point to closest centroid
        holdIt = ind;
        distM = zeros(size(data));
        for j = 1:K
            distMat{j} = bsxfun(@minus, data, c{j});
            distVec{j} = sum(distMat{j} .* distMat{j}, 2); 
            distM(:,j) = distVec{j};
        end
        [A, ind] = min(distM,[],2);    
        %%% change locations of each centroid
        for i = 1:K
           c{i} = mean(data(ind == i,:));   
        end
        count = count + 1;
    end
    weird = zeros(size(data));
    for i = 1:K
       weird(ind == i,:) = bsxfun(@plus, weird(ind == i,:), c{i});
    end
    
end