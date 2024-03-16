import numpy as np
import pandas as pd
from scipy.stats import friedmanchisquare, rankdata
import matplotlib.pyplot as plt
import matplotlib
matplotlib.rcParams['font.family'] = 'Microsoft YaHei'

# 读取Excel数据
df = pd.read_excel('pdb.xlsx', index_col=0)

# 获取算法数量和评估指标数量
num_algorithms = df.shape[0]
num_metrics = df.shape[1]

# 计算排名矩阵
ranks = np.zeros((num_algorithms, num_metrics))
for i in range(num_metrics):
    ranks[:, i] = rankdata(df.iloc[:, i], method='average')

# 计算平均排名
mean_ranks = np.mean(ranks, axis=1)

# 输出带算法名称的平均排名
for i in range(num_algorithms):
    print('算法', df.index[i], '的平均排名为：', mean_ranks[i])

# 执行Friedman检验
f_statistic, p_value = friedmanchisquare(*ranks.T)

# 输出Friedman检验结果
print('Friedman检验结果：')
print('统计量：', f_statistic)
print('p值：', p_value)

# 计算Nemenyi临界差异值
q_alpha = 2.343  # alpha=0.05, k=35
cd = q_alpha * np.sqrt(num_metrics * (num_metrics + 1) / (6 * num_algorithms))

# 画出Nemenyi事后检验图
fig, ax = plt.subplots()
ax.errorbar(mean_ranks, np.arange(num_algorithms), xerr=cd, fmt='o', capsize=5)
ax.set_xlabel('Average Ranking')
ax.set_ylabel('Algorithms')
ax.set_title('Nemenyi post inspection chart based PDB')
ax.set_yticks(np.arange(num_algorithms))
ax.set_yticklabels(df.index)
ax.grid(axis='y')
plt.show()
