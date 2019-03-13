function kNN()
    load hw1boundary.mat
    training = normalizeData(features, features);

    bound = [];
    for i = 1:100
        for j = 1:100
            bound = [bound; i/100,j/100];
        end
    end

    boundaryData = normalizeData(bound,features);
    for i = 1:4
        if i == 1
           K = 1;
           figure('Name', 'K = 1')
        elseif i == 2
           K = 5;
           figure('Name', 'K = 5')
        elseif i == 3
           K = 15;
           figure('Name', 'K = 15')
        else
           K = 25;
           figure('Name', 'K = 25')
        end
        predY = knnDecisionBoundary(features,labels,bound,K);
        s = scatter(bound(predY==1,1), bound(predY==1,2));
        hold on;
        s.Marker = '*';
        s.MarkerEdgeColor = 'r';
        s1 = scatter(bound(predY==-1,1), bound(predY==-1,2));
        s1.Marker ='*';
        s1.MarkerEdgeColor = 'b';
    end
end