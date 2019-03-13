load emGMM.mat;
K = 5;
data = dataTr;
%%%% randomly initialize the parameters
n = size(dataTr,1);
m = size(dataTr,2);
cov = diag(diag(rand(m)))*8;

for i = 1:K
    w{i} = rand();
    mu{i} = [];
    for j = 1:m
        mu{i} = [mu{i}, min(data(:,j))+ (max(data(:,j))-min(data(:,j))) * rand()]; 
    end
    C{i} = cov;
end
normTerm = sum(cell2mat(w));
for i = 1:K
    w{i} = w{i}/normTerm;
end

%%%% Calculate each datapoints possibility for each GMM
belongM = zeros(n,K);
for i = 1:n
   for j = 1:K
       belongM(i,j) = mvnpdf(data(i,:),mu{j},C{j});   
   end   
end

%%%% Calculate the parameters again
sumSigma = sum(belongM);
holdW = sumSigma ./ sum(sumSigma);
for i =1:K
   w{i} =  holdW(i);
end    
for i = 1:K
    rightSide = [];
    for j = 1:m
        rightSide = [rightSide, belongM(:,i) .* dataTr(:,j)];
    end
    rs = sum(rightSide);
    mu{i} = rs ./ sumSigma(i);
end

for i = 1:K
    summed = zeros(m,m);
    for j = 1:n
        co = (dataTr(j,:) - mu{i})' * (dataTr(j,:) - mu{i});
        summed = summed + co;
    end
    C{i} = summed ./ sumSigma(i);
end

