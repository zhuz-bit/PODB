clc;close all

json_data = fileread('_annotations.coco.json');
data = jsondecode(json_data);

annotations = data.annotations;
num_annotations = numel(annotations);

widths = zeros(num_annotations, 1);
heights = zeros(num_annotations, 1);

for i = 1:num_annotations
    bbox = annotations(i).bbox;
    widths(i) = bbox(3);
    heights(i) = bbox(4);
end


X = [widths, heights];


k = 9; 
max_iters = 10; 


[idx, centroids] = kmeans(X, k, 'MaxIter', max_iters);


anchors = centroids; 


figure;
scatter(widths, heights, 'b', 'filled'); 
hold on;
scatter(anchors(:, 1), anchors(:, 2), 'r', 'filled');
xlabel('Width');
ylabel('Height');
legend('Data Points', 'Anchors');
title('Initial anchor result k-means');


silhouette_vals = silhouette(X, idx);
silhouette_avg = mean(silhouette_vals);


num_clusters = k; 

distances = pdist(centroids);

intra_cluster_distances = zeros(num_clusters, 1);
for i = 1:num_clusters
    cluster_points = X(idx == i, :);
    cluster_size = size(cluster_points, 1);
    pairwise_distances = pdist(cluster_points);
    intra_cluster_distances(i) = sum(pairwise_distances) / cluster_size;
end


inter_cluster_distances = squareform(distances);
inter_cluster_distances = max(inter_cluster_distances, [], 2);

dbi = mean((intra_cluster_distances + inter_cluster_distances) ./ intra_cluster_distances);


num_points = size(X, 1); % 数据点的数量


intra_cluster_sums = zeros(num_clusters, 1);
for i = 1:num_clusters
    cluster_points = X(idx == i, :);
    centroid = centroids(i, :);
    pairwise_distances = pdist2(cluster_points, centroid);
    intra_cluster_sums(i) = sum(pairwise_distances.^2);
end
intra_cluster_sum = sum(intra_cluster_sums);

total_mean = mean(X);
inter_cluster_sum = 0;
for i = 1:num_clusters
    cluster_points = X(idx == i, :);
    cluster_size = size(cluster_points, 1);
    cluster_mean = mean(cluster_points);
    inter_cluster_sum = inter_cluster_sum + cluster_size * sum((cluster_mean - total_mean).^2);
end

chi = inter_cluster_sum / intra_cluster_sum * (num_points - num_clusters) / (num_clusters - 1);

disp(['Silhouette Coefficient: ', num2str(silhouette_avg)]);
disp(['Davies-Bouldin Index: ', num2str(dbi)]);
disp(['Calinski-Harabasz Index: ', num2str(chi)]);


disp('Anchors:');
disp(anchors);
