function [val_logL, logL, iterator] = my_EMalg(dataTr, dataVal, K)
    load emGMM.mat;
    % K = 5;
    data = dataTr;
    %%%% randomly initialize the parameters
    n = size(data,1);
    m = size(data,2);
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

    belongM = zeros(n,K);
    logL = 0;
    iterator = 0;
    logHold = -1;
    while logL - logHold > 0.0001 | iterator < 3
        iterator = iterator + 1;
        logHold = logL;
        %%%% Calculate each datapoints possibility for each GMM
        for i = 1:n
           for j = 1:K
               belongM(i,j) = mvnpdf(data(i,:),mu{j},C{j});  
           end
           belongM(i,:) = belongM(i,:) ./ sum(belongM(i,:));
        end

        %%%% Calculate the parameters again
        sumSigma = sum(belongM);
        holdW = sumSigma ./ sum(sumSigma);
        for i =1:K
           w{i} =  holdW(i);
        end

        for i = 1:K
            a = sum(data(:,1) .* belongM(:,i)) / sum(belongM(:,i));
            b = sum(data(:,2) .* belongM(:,i)) / sum(belongM(:,i));
            mu{i} = [a,b];
        end

        for i = 1:K
            summed = zeros(m,m);
            for j = 1:n
                co = belongM(j,i) * ((data(j,:) - mu{i})' * (data(j,:) - mu{i}));
                summed = summed + co;
            end
            C{i} = summed ./ sum(belongM(:,i));
        end

        %%% calculate the log-likelihood
        lTerm = 0;
        rTerm = 0;
        logL = 0;
        for i = 1:n
            for j = 1:K
                lTerm = lTerm + belongM(i,j)*log(w{j});
                rTerm = rTerm + belongM(i,j)*log(mvnpdf(data(i,:),mu{j},C{j}));
            end
        end
        logL = lTerm + rTerm;
    end
    %%%% assign each datapoint in Validation set to components
    [p q] = size(dataVal);
    valBelong = zeros(p,q);
    for i = 1:p
       for j = 1:K
           varBelong(i,j) = mvnpdf(dataVal(i,:),mu{j},C{j});  
       end
       varBelong(i,:) = varBelong(i,:) ./ sum(varBelong(i,:));
    end
    %%% calculate log-likelihood on validation
    lTerm = 0;
    rTerm = 0;
    val_logL = 0;
    for i = 1:n
        for j = 1:K
            lTerm = lTerm + varBelong(i,j)*log(w{j});
            rTerm = rTerm + varBelong(i,j)*log(mvnpdf(dataVal(i,:),mu{j},C{j}));
        end
    end
    val_logL = lTerm + rTerm;
end
