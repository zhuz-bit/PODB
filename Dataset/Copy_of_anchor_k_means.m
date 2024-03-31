clc;close all
% 导入数据集
json_data = fileread('_annotations.coco.json'); % 替换为你的数据集路径
data = jsondecode(json_data);

% 提取目标框的宽度和高度
annotations = data.annotations;
num_annotations = numel(annotations);

widths = zeros(num_annotations, 1);
heights = zeros(num_annotations, 1);

for i = 1:num_annotations
    bbox = annotations(i).bbox;
    widths(i) = bbox(3);
    heights(i) = bbox(4);
end

% 将宽度和高度合并为一个矩阵
X = [widths, heights];

% 设置k-means算法的参数
k = 9; % 设定anchor的数量
max_iters = 10; % 最大迭代次数

% 使用k-means算法计算初始anchor
[idx, centroids] = kmeans(X, k, 'MaxIter', max_iters);

% 输出初始anchor
anchors = centroids; % centroids变量中存储了每个anchor的宽度和高度

% 绘制初始anchor
figure;
scatter(widths, heights, 'b', 'filled'); % 绘制目标框的散点图
hold on;
scatter(anchors(:, 1), anchors(:, 2), 'r', 'filled'); % 绘制初始anchor的散点图
xlabel('Width');
ylabel('Height');
legend('Data Points', 'Anchors');
title('Initial anchor result k-means');

% 计算轮廓系数（Silhouette Coefficient）
silhouette_vals = silhouette(X, idx);
silhouette_avg = mean(silhouette_vals);

% 计算Davies-Bouldin Index（DBI）
num_clusters = k; % 聚类的数量

% 计算聚类中心之间的欧氏距离
distances = pdist(centroids);

% 计算类内平均距离
intra_cluster_distances = zeros(num_clusters, 1);
for i = 1:num_clusters
    cluster_points = X(idx == i, :);
    cluster_size = size(cluster_points, 1);
    pairwise_distances = pdist(cluster_points);
    intra_cluster_distances(i) = sum(pairwise_distances) / cluster_size;
end

% 计算类间平均距离
inter_cluster_distances = squareform(distances);
inter_cluster_distances = max(inter_cluster_distances, [], 2);

% 计算DBI
dbi = mean((intra_cluster_distances + inter_cluster_distances) ./ intra_cluster_distances);

% 计算Calinski-Harabasz Index（CHI）
num_points = size(X, 1); % 数据点的数量

% 计算类内平方和
intra_cluster_sums = zeros(num_clusters, 1);
for i = 1:num_clusters
    cluster_points = X(idx == i, :);
    centroid = centroids(i, :);
    pairwise_distances = pdist2(cluster_points, centroid);
    intra_cluster_sums(i) = sum(pairwise_distances.^2);
end
intra_cluster_sum = sum(intra_cluster_sums);

% 计算类间平方和
total_mean = mean(X);
inter_cluster_sum = 0;
for i = 1:num_clusters
    cluster_points = X(idx == i, :);
    cluster_size = size(cluster_points, 1);
    cluster_mean = mean(cluster_points);
    inter_cluster_sum = inter_cluster_sum + cluster_size * sum((cluster_mean - total_mean).^2);
end

% 计算CHI
chi = inter_cluster_sum / intra_cluster_sum * (num_points - num_clusters) / (num_clusters - 1);

% 打印指标值
disp(['Silhouette Coefficient: ', num2str(silhouette_avg)]);
disp(['Davies-Bouldin Index: ', num2str(dbi)]);
disp(['Calinski-Harabasz Index: ', num2str(chi)]);

% 打印anchor信息
disp('Anchors:');
disp(anchors);
