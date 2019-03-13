function lrTemplate()
    load demoSynLR.mat

    
    % your codes here 
    
    w1A = lrFit(data1.x,data1.y); %with outlier example
    w1B = lrFit(data1.x(1:end-1,:),data1.y(1:end-1,:)); %w/o outlier example
    w2A = lrFit(data2.x,data2.y); %with outlier example
    w2B = lrFit(data2.x(1:end-1,:),data2.y(1:end-1,:)); %w/o outlier example
    w3A = lrFit(data3.x,data3.y); %with outlier example
    w3B = lrFit(data3.x(1:end-1,:),data3.y(1:end-1,:)); %w/o outlier example
    w4A = lrFit(data3.x,data4.y); %with outlier example
    w4B = lrFit(data3.x(1:end-1,:),data4.y(1:end-1,:)); %w/o outlier example
    
    w1x = ridgeFit(data1.x,data1.y,0.1);
    w1y = ridgeFit(data1.x,data1.y,1);
    w1z = ridgeFit(data1.x,data1.y,10);
    w2x = ridgeFit(data2.x,data2.y,0.1);
    w2y = ridgeFit(data2.x,data2.y,1);
    w2z = ridgeFit(data2.x,data2.y,10);
    w3x = ridgeFit(data3.x,data3.y,0.1);
    w3y = ridgeFit(data3.x,data3.y,1);
    w3z = ridgeFit(data3.x,data3.y,10);
    w4x = ridgeFit(data4.x,data4.y,0.1);
    w4y = ridgeFit(data4.x,data4.y,1);
    w4z = ridgeFit(data4.x,data4.y,10);
    
    h1 = leverage(data1.x);
    t1 = studentized(data1.x,data1.y,w1A,h1);
    d1 = cookDist(h1,t1,size(data1.x,2));
    
    h2 = leverage(data2.x);
    t2 = studentized(data2.x,data2.y,w2A,h2);
    d2 = cookDist(h2,t2,size(data2.x,2));
    
    h3 = leverage(data3.x);
    t3 = studentized(data3.x,data3.y,w3A,h3);
    d3 = cookDist(h3,t3,size(data1.x,3));   
    
    h4 = leverage(data4.x);
    t4 = studentized(data4.x,data4.y,w4A,h4);
    d4 = cookDist(h4,t4,size(data4.x,2));
    
    
    
    %%
        % demo of TA's plot functions
         figureLR = figure(1);
         set(figureLR,'Position',[100, 100, 1000, 800]);
         plotLRline(figureLR, 1, w1A, w1B, data1.x, data1.y);
         plotLRline(figureLR, 2, w2A, w2B, data2.x, data2.y);
         plotLRline(figureLR, 3, w3A, w3B, data3.x, data3.y);
         plotLRline(figureLR, 4, w4A, w4B, data4.x, data4.y);
         
         figureDecay = figure(2);
         set(figureDecay,'Position',[100, 100, 1000, 800]);
         plotLRlineThree(figureDecay, 1, w1x, w1y, w1z, data1.x, data1.y);
         plotLRlineThree(figureDecay, 2, w2x, w2y, w2z, data2.x, data2.y);
         plotLRlineThree(figureDecay, 3, w3x, w3y, w3z, data3.x, data3.y);
         plotLRlineThree(figureDecay, 4, w4x, w4y, w4z, data4.x, data4.y);
         
         figureSample = figure(3);
         set(figureSample,'Position',[100, 100, 1000, 800]);
         plotSamples(figureSample, 1, data1.x, data1.y, h1, t1, d1);
         plotSamples(figureSample, 2, data2.x, data2.y, h2, t2, d2);
         plotSamples(figureSample, 3, data3.x, data3.y, h3, t3, d3);
         plotSamples(figureSample, 4, data4.x, data4.y, h4, t4, d4);
end

function r = heldoutResidual(w, dataX, dataY)
    r = dataY - dataX*w;
end

function w = lrFit(dataX,dataY)
    w = inv(dataX'*dataX)*dataX'*dataY;
end

function w = ridgeFit(dataX,dataY,lambda)
 	w = inv(dataX'*dataX + lambda*eye(size(dataX,2)))*dataX'*dataY;
end

function h = leverage(dataX)
    H = dataX*inv(dataX'*dataX)*dataX';
    h = diag(H);
end

function t = studentized(dataX,dataY,w,h)
    r = heldoutResidual(w, dataX, dataY);
    t = r./(std(r)*sqrt(1-h));  
end

function d = cookDist(h,t,k)
    d = (h./(1-h)).*(t.^2./(1+k));
end

function plotLRline(figureLR, subPID, w1, w2, dataX, dataY)
% [dataX, dataY]: coordinates of data samples
% w: the linear regresison parameters

    w1 = transpose(w1(:));
    w2 = transpose(w2(:));
    dataY = dataY(:);
    if size(dataX,1)~=length(dataY)
        dataX=dataX';
    end
    if size(dataX,1)~=length(dataY)
        error('data size inconsistent');
    end
    
    bl = [min(dataX(:,2))-1, min(dataY)-1];
    ur = [max(dataX(:,2))+1, max(dataY)+1];
    figure(figureLR)
    subplot(2,2,subPID), plot(dataX(1:end-2,2), dataY(1:end-2),'o','MarkerSize',8,'LineWidth',2);
    hold on, 
    plot(dataX(end-1,2), dataY(end-1),'go','MarkerSize',8,'LineWidth',2);
    plot(dataX(end,2), dataY(end),'ro','MarkerSize',8,'LineWidth',2);
    plot([bl(1), ur(1)], [w1*[1;bl(1)], w1*[1;ur(1)]],'k-','lineWidth',3);
    plot([bl(1), ur(1)], [w2*[1;bl(1)], w2*[1;ur(1)]],'m-','lineWidth',3);
    hleg = legend('majority','leverage','outlier','LR','LR w/o outlier');
    set(hleg,'Location','NorthWest','FontSize',12,'FontWeight','Demi');
    title(['(' num2str(subPID), ')'],'FontSize',12,'FontWeight','Demi')
    xlabel('x','FontSize',15,'FontWeight','Demi')
    ylabel('y','FontSize',15,'FontWeight','Demi')
end
function plotLRlineThree(figureLR, subPID, w1, w2, w3, dataX, dataY)
% [dataX, dataY]: coordinates of data samples
% w: the linear regresison parameters

    w1 = transpose(w1(:));
    w2 = transpose(w2(:));
    w3 = transpose(w3(:));
    dataY = dataY(:);
    if size(dataX,1)~=length(dataY)
        dataX=dataX';
    end
    if size(dataX,1)~=length(dataY)
        error('data size inconsistent');
    end
    
    bl = [min(dataX(:,2))-1, min(dataY)-1];
    ur = [max(dataX(:,2))+1, max(dataY)+1];
    figure(figureLR)
    subplot(2,2,subPID), plot(dataX(1:end-2,2), dataY(1:end-2),'o','MarkerSize',8,'LineWidth',2);
    hold on, 
    plot([bl(1), ur(1)], [w1*[1;bl(1)], w1*[1;ur(1)]],'k-','lineWidth',3);
    plot([bl(1), ur(1)], [w2*[1;bl(1)], w2*[1;ur(1)]],'m-','lineWidth',3);
    plot([bl(1), ur(1)], [w3*[1;bl(1)], w3*[1;ur(1)]],'g-','lineWidth',3);
    plot(dataX(end-1,2), dataY(end-1),'go','MarkerSize',8,'LineWidth',2);
    plot(dataX(end,2), dataY(end),'ro','MarkerSize',8,'LineWidth',2);
    
    hleg = legend('majority','0.1','1','10');
    set(hleg,'Location','NorthWest','FontSize',12,'FontWeight','Demi');
    title(['(' num2str(subPID), ')'],'FontSize',12,'FontWeight','Demi')
    xlabel('x','FontSize',15,'FontWeight','Demi')
    ylabel('y','FontSize',15,'FontWeight','Demi')
end
function plotSamples(figureLR, subPID, dataX, dataY, h, t, d)
% h, t, d: 
%   leverage, studentized_residual, cook's distance of samples
    [~, idxH] = max(h);
    [~, idxT] = max(t);
    [~, idxD] = max(d);
    
    dataY = dataY(:);
    if size(dataX,1)~=length(dataY)
        dataX=dataX';
    end
    if size(dataX,1)~=length(dataY)
        error('data size inconsistent');
    end
    
    figure(figureLR)
    subplot(2,2,subPID), plot(dataX(1:end-2,2), dataY(1:end-2),'o','MarkerSize',8,'LineWidth',2);
    hold on, 
    plot(dataX(end-1,2), dataY(end-1),'go','MarkerSize',8,'LineWidth',2);
    plot(dataX(end,2), dataY(end),'ro','MarkerSize',8,'LineWidth',2);
    plot(dataX(idxH(1),2), dataY(idxH(1)), 'cd','MarkerSize',12,'LineWidth',3);
    plot(dataX(idxT(1),2), dataY(idxT(1)), 'ms','MarkerSize',12,'LineWidth',3);
    plot(dataX(idxD(1),2), dataY(idxD(1)), 'k>','MarkerSize',12,'LineWidth',3);
    hleg = legend('majority','leverage','outlier','max-H','max-T','max-Cook');
    set(hleg,'Location','NorthWest','FontSize',12,'FontWeight','Demi');
    title(['(', num2str(subPID), ')'],'FontSize',12,'FontWeight','Demi')
    xlabel('x','FontSize',15,'FontWeight','Demi')
    ylabel('y','FontSize',15,'FontWeight','Demi')
end
