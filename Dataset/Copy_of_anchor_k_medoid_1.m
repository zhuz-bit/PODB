clc;close all
jsonStr = fileread('_annotations.coco.json');
data = jsondecode(jsonStr);

bboxWidths = [];
bboxHeights = [];
annotations = data.annotations;
for i = 1:length(annotations)
    bbox = annotations(i).bbox;
    bboxWidths = [bboxWidths; bbox(3)];
    bboxHeights = [bboxHeights; bbox(4)];
end

features = [bboxWidths, bboxHeights];

K = 9;

rng('default');
[idx, centroids] = kmeans(features, K);

distMatrix = pdist2(features, centroids);
[~, medoidIndices] = min(distMatrix, [], 1);
finalCentroids = features(medoidIndices, :);

disp(finalCentroids);

silhouetteVals = silhouette(features, idx);
meanSilhouette = mean(silhouetteVals);


daviesBouldin = davies_bouldin(features, idx);

chIndex = calinski_harabasz(features, idx);

disp(['Mean Silhouette Coefficient: ' num2str(meanSilhouette)]);
disp(['Davies-Bouldin Index: ' num2str(daviesBouldin)]);
disp(['Calinski-Harabasz Index: ' num2str(chIndex)]);

figure;
scatter(bboxWidths, bboxHeights, 'b', 'filled');
hold on;
scatter(finalCentroids(:, 1), finalCentroids(:, 2), 'r', 'filled');
xlabel('Width');
ylabel('Height');
legend('Data Points', 'Anchors');
title('Initial anchor result k-FlexiAnchor');
function dbIndex = davies_bouldin(X, idx)
    k = max(idx);
    clusterCenters = zeros(k, size(X, 2));
    dbIndex = zeros(k, 1);
    
    for i = 1:k
        clusterPoints = X(idx == i, :);
        clusterCenters(i, :) = mean(clusterPoints);
    end
    
    for i = 1:k
        intraClusterDistances = pdist2(X(idx == i, :), clusterCenters(i, :));
        intraClusterDistances(intraClusterDistances == 0) = inf;
        
        interClusterDistances = zeros(k-1, 1);
        for j = 1:k
            if j ~= i
                interClusterDistances(j) = norm(clusterCenters(i, :) - clusterCenters(j, :));
            end
        end
        
        dbIndex(i) = mean(intraClusterDistances) / max(interClusterDistances);
    end
    
    dbIndex = mean(dbIndex);
end
function chIndex = calinski_harabasz(X, idx)
    k = max(idx);
    clusterCenters = zeros(k, size(X, 2));
    clusterSizes = zeros(k, 1);
    
    for i = 1:k
        clusterPoints = X(idx == i, :);
        clusterCenters(i, :) = mean(clusterPoints);
        clusterSizes(i) = size(clusterPoints, 1);
    end
    
    totalMean = mean(X);
    
    numerator = 0;
    for i = 1:k
        numerator = numerator + clusterSizes(i) * norm(clusterCenters(i, :) - totalMean)^2;
    end
    
    denominator = 0;
    for i = 1:k
        for j = 1:size(X, 1)
            if idx(j) == i
                denominator = denominator + norm(X(j, :) - clusterCenters(i, :))^2;
            end
        end
    end
    
    chIndex = (numerator / (k - 1)) / (denominator / (size(X, 1) - k));
end

