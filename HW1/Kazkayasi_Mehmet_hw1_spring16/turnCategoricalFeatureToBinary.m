function [binaryFeatureMatrix] = turnCategoricalFeatureToBinary(categoricalFeature,allFeature)

numberOfSamples = size(categoricalFeature,1);
howManyCategory = size(unique(allFeature),1);
categories = unique(allFeature);



binaryFeatureMatrix = zeros(numberOfSamples,howManyCategory);

    for i=1:howManyCategory    
         binaryFeatureMatrix(:,i) = strcmp(categoricalFeature,categories(i));       
    end
end