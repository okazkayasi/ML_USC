
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
    belongM = zeros(n,K);
    holdIt = ones(n,K);
    while mean(mean(belongM == holdIt)) ~= 1
        %%% assign each data point to closest centroid
        holdIt = belongM;
        for i = 1:n
            best = inf; %just a large value
            for j = 1:K
               distance = (c{j}-data(i,:)) * (c{j}-data(i,:))';
               if distance < best
                   best = distance;
                   belongM(i,:) = zeros(1,K);
                   belongM(i,j) = 1;
               end
            end 
        end
        %%% change locations of each centroid
        L = logical(belongM);
        for i = 1:K
           c{i} = mean(data(L(:,i),:));   
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
       scatter(data(L(:,i),1), data(L(:,i),2),[],c,'filled');
    end
    hold off;
end
