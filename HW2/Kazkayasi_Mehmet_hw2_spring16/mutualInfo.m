function mi = mutualInfo(X,Y)
    X(:,1) = [];
    p = convertBin(X,Y);
    mi = [];
    for i = 1:size(p,2)
        mi(i) = 0;
        n = sum(sum(p{i}));
        row_sum = sum(p{i},2);
        col_sum = sum(p{i},1);
        for j = 1:10
            p_x = row_sum(j)/n;
            for k = 1:2
                p_xy = p{i}(j,k)/n;
                p_y = col_sum(k)/n;
                if p_xy > 0
                    mi(i) = mi(i) + p_xy * log(p_xy/(p_x*p_y));
                end
            end
        end
        
    end
    
    
end
