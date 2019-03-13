load hw4_circle.mat;
load hw4_blob.mat;

for i = 2:4
    if i == 4
        i = 5;
    end
    my_k_means(points,i);
    my_k_means(data2,i);
end