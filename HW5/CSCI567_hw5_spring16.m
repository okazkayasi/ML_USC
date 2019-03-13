load x_test.mat
load x_train.mat
load y_test.mat
load y_train.mat

eigenvecs = get_sorted_eigenvecs(x_train);

figure;
for i = 1:8
    subplot(2,4,i)
    imshow(double(reshape(eigenvecs(:,i), 16, 16)),[]);
    title([num2str(i) 'th eigendigit'])
    hold on;
end

K = [1, 3, 5, 15, 100];
figs = [250, 300, 450, 500, 3000];
figure;
for i = 1:length(K)
   subplot(5,6,6*(i-1)+1)
   imshow(double(reshape(x_train(figs(i),:), 16, 16)),[])
   title(['original image of #' num2str(i)])
   hold on;
end
for i = 1:length(K)
    eigen = eigenvecs(:,1:K(i));
    new_x = x_train * eigen * eigen';
    for j = 1:length(figs)
        subplot(5,6,(j-1)*6 + 1 + i);
        imshow(double(reshape(new_x(figs(j),:), 16, 16)),[])
        title(['#' num2str(figs(j)) ' #pc = ' num2str(K(i))])
        hold on;       
    end 
end

time = zeros(1,length(K));
acc_train = zeros(1,length(K));
acc_test = zeros(1,length(K));
for i = 1:length(K)
    tic;
    eigen = eigenvecs(:,1:K(i));
    train = bsxfun(@minus, x_train, mean(x_train,1));
    test = bsxfun(@minus, x_test, mean(x_train,1));
    train = train*eigen;
    test = test*eigen;
    
    tree = fitctree(train, y_train, 'SplitCriterion', 'deviance');
    y_hat_train = predict(tree, train);
    y_hat_test = predict(tree, test);
    
    acc_train(i) = mean(y_hat_train == y_train);
    acc_test(i) = mean(y_hat_test == y_test);
    time(i) = toc;
end

fprintf('The answer of section-b is given by figure-1.\n')
fprintf('The answer of section-c is given by figure-2.\n')
fprintf('The training accuracy of compressed dataset when K = (1,3,5,15,100) respectively:')
acc_train
fprintf('The testing accuracy of compressed dataset when K = (1,3,5,15,100) respectively:')
acc_test
fprintf('The computation time of classification tree on compressed dataset when K = (1,3,5,15,100) respectively:')
time


