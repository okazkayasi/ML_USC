function q1()
    load hw4_circle.mat;
    load hw4_blob.mat;

    for i = 2:4
        if i == 4
            i = 5;
        end
        means(points,i);
        means(data2,i);
    end
    fprintf('Answer to 4.1 is given in plots');
end