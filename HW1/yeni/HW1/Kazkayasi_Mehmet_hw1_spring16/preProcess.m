function[preprocessedX,preprocessedY] = preProcess(data, allFeature)
    

for i = 1:size(data)
    temp = strsplit(data{i},',');
    for j = 1:size(temp,2)
       splitted_data{i,j} = temp{j};
    end
end

for i = 1:size(allFeature)
    temp = strsplit(allFeature{i},',');
    for j = 1:size(temp,2)
       all_splitted_data{i,j} = temp{j};
    end
end

preprocessedX = [];
for i = 1:(size(temp,2)-1)
    bin = turnCategoricalFeatureToBinary(splitted_data(:,i),all_splitted_data(:,i));
    preprocessedX = [preprocessedX, bin];
end

preprocessedY =  char(splitted_data{:,7});
    
        
     
end


%     splittedStr = []
%     for n = 1:215
%         splittedStr = strsplit(train{n},',');
%         if char(splittedStr{1}) == 'med'
%             splittedStr{1} = 2;
%         elseif splittedStr{1} == 'low'
%             splittedStr{1} = 1;
%         elseif splittedStr{1} == 'high'
%             splittedStr{1} = 3;        	
%         end
%     end