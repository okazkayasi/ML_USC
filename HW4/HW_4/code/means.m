
function my_k_means(data,K)
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
    while mean(mean(ind == holdIt)) ~= 1
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
    end

    colors = [1,0,0;
              0,0,1;
              1,1,0;
              0,1,0;
              0,1,1];
    figure; cla;
    hold on;
    for i = 1:K
       if i < 6
            c = colors(i,:);
       else
           c = rand(1,3);
       end
       scatter(data(ind == i,1), data(ind == i,2),[],c,'filled');
    end
    hold off;
end
