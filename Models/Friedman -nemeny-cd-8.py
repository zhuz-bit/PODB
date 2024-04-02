import numpy as np
import pandas as pd
from scipy.stats import friedmanchisquare, rankdata
import matplotlib.pyplot as plt
import matplotlib
matplotlib.rcParams['font.family'] = 'Microsoft YaHei'


df = pd.read_excel('pdb.xlsx', index_col=0)


num_algorithms = df.shape[0]
num_metrics = df.shape[1]


ranks = np.zeros((num_algorithms, num_metrics))
for i in range(num_metrics):
    ranks[:, i] = rankdata(df.iloc[:, i], method='average')


mean_ranks = np.mean(ranks, axis=1)


for i in range(num_algorithms):
    print('算法', df.index[i], '的平均排名为：', mean_ranks[i])

f_statistic, p_value = friedmanchisquare(*ranks.T)


print('Friedman检验结果：')
print('统计量：', f_statistic)
print('p值：', p_value)


q_alpha = 2.343  # alpha=0.05, k=35
cd = q_alpha * np.sqrt(num_metrics * (num_metrics + 1) / (6 * num_algorithms))


fig, ax = plt.subplots()
ax.errorbar(mean_ranks, np.arange(num_algorithms), xerr=cd, fmt='o', capsize=5)
ax.set_xlabel('Average Ranking')
ax.set_ylabel('Algorithms')
ax.set_title('Nemenyi post inspection chart based PDB')
ax.set_yticks(np.arange(num_algorithms))
ax.set_yticklabels(df.index)
ax.grid(axis='y')
plt.show()
