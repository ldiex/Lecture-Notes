#import "@preview/finite:0.5.0": automaton
#import "@preview/finite:0.5.0"

#set heading(numbering: "1.")
#set text(14pt, font:("Libertinus Serif", "Source Han Serif SC"))

#show heading.where(level: 1): set text(blue)
#show heading.where(level: 2): set text(navy)
  text(green, it)
}
#align(center)[
  #text("Mathematics Foundation in AI", 20pt)
]

#outline(depth: 2)
= 第一章: 机器学习与优化建模
== 矩阵奇异值分解
=== 定义
设 $A in bb(R)^(m times n)$, 则 $A$ 的 #strong[奇异值分解 (Singular
Value Decomposition, SVD)] 为 $ A = U Sigma V^T $ 其中
$U in bb(R)^(m times m)$ 和 $V in bb(R)^(n times n)$ 为正交矩阵,
$Sigma in bb(R)^(m times n)$ 为对角矩阵, 其对角线上的元素
$sigma_1 \, sigma_2 \, dots.h \, sigma_r$ (其中 $r = min { m \, n }$) 为
$A$ 的奇异值, 且满足
$sigma_1 gt.eq sigma_2 gt.eq dots.h gt.eq sigma_r gt.eq 0$. 

=== 分解方法 
1. 计算 $A^T A$ 和 $A A^T$ 的特征值和特征向量. 
2. 设 $A^T A$ 的特征值为 $lambda_1 \, lambda_2 \, dots.h \, lambda_n$ (按降序排列), 则 $A$ 的奇异值为 $sigma_i = sqrt(lambda_i)$, $i = 1 \, 2 \, dots.h \, r$.
3. $V$ 的列向量为 $A^T A$ 的单位特征向量.

== 范数
=== 向量范数
若实值函数 $bar.v.double dot.op bar.v.double : bb(R)^n arrow.r bb(R)$
满足下列条件: 
1. 正定性: $bar.v.double bold(x) bar.v.double gt.eq 0$, $forall bold(x) in bb(R)^n$. $bar.v.double x bar.v.double = 0 arrow.l.r.double bold(x) = bold(0)$. 
2. 齐次性: $bar.v.double alpha bold(x) bar.v.double = lr(|alpha|) bar.v.double bold(x) bar.v.double$, $forall a in bb(R)$, $bold(x) in bb(R)^n$. 
3. 三角不等式: $bar.v.double bold(x) + bold(y) bar.v.double lt.eq bar.v.double bold(x) bar.v.double + bar.v.double bold(y) bar.v.double$, $forall bold(x) \, bold(y) in bb(R)^n$. 

则 $bar.v.double dot.op bar.v.double$ 为向量范数

定义 $L_p$ 范数为
$ bar.v.double bold(x) bar.v.double_p = [sum_(j = 1)^n bar.v.double bold(x)_j bar.v.double^p]^(1 \/ p) \, quad 1 lt.eq p < oo $
特别地, 我们有 $bar.v.double bold(x) bar.v.double_oo = max_j lr(|x_j|)$.

=== 矩阵范数
==== 定义
若实值函数
$bar.v.double dot.op bar.v.double : bb(R)^(m times n) arrow.r bb(R)$
满足下列条件: 
1. 正定性: $bar.v.double A bar.v.double gt.eq 0$, $forall A in bb(R)^(m times n)$. $bar.v.double A bar.v.double = 0 arrow.l.r.double A = 0$. 
2. 齐次性: $bar.v.double alpha A bar.v.double = lr(|alpha|) bar.v.double A bar.v.double$, $forall a in bb(R)$, $A in bb(R)^(m times n)$. 
3. 三角不等式: $bar.v.double A + B bar.v.double lt.eq bar.v.double A bar.v.double + bar.v.double B bar.v.double$, $forall A \, B in bb(R)^(m times n)$.

则 $bar.v.double dot.op bar.v.double$ 为矩阵范数

==== 一些常见的矩阵范数
- Frobenius 范数:
  $ bar.v.double A bar.v.double_F = [sum_(i = 1)^m sum_(j = 1)^n a_(i j)^2]^(1 \/ 2) $

- 核范数 (Nuclear norm):
  $ bar.v.double A bar.v.double_(*) = sum_(i = 1)^r sigma_i $ 其中
  $sigma_i$ 为 $A$ 的奇异值, $r = min { m \, n }$. 或者我们也可以定义
  $sigma_i$ 为 $A$ 的非零奇异值, $r = upright("rank") \( A \)$.

- 谱范数 (Spectral norm):
  $ bar.v.double A bar.v.double_2 = sigma_1 = max_(bold(x) eq.not 0) frac(bar.v.double A bold(x) bar.v.double_2, bar.v.double bold(x) bar.v.double_2) $
  其中 $sigma_1$ 为 $A$ 的最大奇异值.

==== 矩阵内积
矩阵 $A \, B in bb(R)^(m times n)$ 的内积定义为
$ angle.l A \, B angle.r = upright("Tr") \( A^T B \) = sum_(i = 1)^m sum_(j = 1)^n a_(i j) b_(i j) $

我们有 Cauchy-Schwarz 不等式:
$ angle.l A \, B angle.r lt.eq bar.v.double A bar.v.double_F bar.v.double B bar.v.double_F $

== 酉矩阵和酉不变性
=== 酉矩阵
设 $U in bb(C)^(n times n)$, 如果 $U$ 满足 $U^(*) U = U U^(*) = I$, 则称
$U$ 为 #strong[酉矩阵 (Unitary Matrix)];. 这里 $U^(*)$ 为 $U$
的共轭转置, 即先对 $U$ 中的每个元素取共轭, 再转置.

特别地, 在实数域上, 酉矩阵称为 #strong[正交矩阵 (Orthogonal Matrix)];,
即 $Q^T Q = Q Q^T = I$.

=== 酉不变性
矩阵范数 $bar.v.double dot.op bar.v.double$ 如果满足
$ bar.v.double U A V bar.v.double = bar.v.double A bar.v.double \, quad forall U in bb(C)^(m times m) \, V in bb(C)^(n times n) upright(" 为酉矩阵") . $
则称 $bar.v.double dot.op bar.v.double$ 为 #strong[酉不变 (Unitary
Invariant)] 的.

向量的 $ell_2$ 范数和矩阵的 Frobenius 范数均为酉不变的.

== 经验风险最小化与期望风险最小化模型
=== 损失函数
损失函数是针对 #strong[单个] 具体的样本而言的,
用于衡量模型预测值与真实值之间的差异. 损失函数通常记作
$ell \( y \, f \( bold(x) ; bold(theta) \) \)$, 其中 $y$
是样本的真实标签, $f \( bold(x) ; bold(theta) \)$ 是模型对输入 $bold(x)$
的预测输出, $bold(theta)$ 是模型的参数.

=== 经验风险
经验风险 (Empirical Risk) 是在给定的训练数据集上计算的平均损失,
用于评估模型在训练数据上的表现. 设训练数据集为
${ \( bold(x)_i \, y_i \) }_(i = 1)^N$, 则经验风险定义为
$ R_(upright("emp")) \( bold(theta) \) = 1 / N sum_(i = 1)^N ell \( y_i \, f \( bold(x)_i ; bold(theta) \) \) $

=== 期望风险
期望风险 (Expected Risk) 是在整个数据分布上计算的平均损失,
用于评估模型在未见过的数据上的表现. 设数据分布为 $P \( bold(x) \, y \)$,
则期望风险定义为
$ R_(upright("exp")) \( bold(theta) \) = bb(E)_(\( bold(x) \, y \) tilde.op P) \[ ell \( y \, f \( bold(x) ; bold(theta) \) \) \] $
期望风险刻画的就是统计意义上的 #strong[母体];.

=== 结构风险
结构风险 (Structural Risk) 是在经验风险的基础上,
加入正则化项以控制模型复杂度, 从而防止过拟合. 结构风险定义为
$ R_(upright("srm")) = R_(upright("emp")) + lambda J \( bold(theta) \) $
这里 $J \( bold(theta) \)$ 衡量模型 (参数) 的复杂度, $lambda$
是正则化参数, 用于平衡经验风险和模型复杂度之间的权重.
通常我们用正则化项来惩罚过于复杂的模型, 以提升模型的泛化能力.
在这种情况下, 监督学习就变成了一个最优化问题
$ min_(bold(theta)) R_(upright("srm")) \( bold(theta) \) = min_(bold(theta)) [1 / N sum_(i = 1)^N ell \( y_i \, f \( bold(x)_i ; bold(theta) \) \) + lambda J \( bold(theta) \)] $

=== Bayes 风险
如果一个算法 $h^(*)$ 在全体数据集 $bb(D)$ 上是最好的算法, 则它的期望风险
$R_(upright("exp")) \( h^(*) \)$ 称为 #strong[Bayes 风险] (Bayes Risk).
换句话说, Bayes
风险是所有可能的算法中期望风险最小的算法所达到的风险水平.

=== 近似误差, 估计误差与泛化误差
记 1. $hat(h)_(cal(H))$ 是基于有限样本集合 $bb(S)$
根据经验风险最小从有限算法集合 $cal(H)$ 中选出的最佳算法
(i.e.~经验风险最小). 2. $h_(cal(H))^(*)$ 是基于全体数据集 $bb(D)$
根据期望风险最小从有限算法集合 $cal(H)$ 中选出的最佳算法
(i.e.~期望风险最小). 3. 假设 $h^(*)$ 的真实 Bayes 风险为 $R^(*)$

从一般性考虑, 大范围的最优肯定优于子范围的最优, 即:
$ R^(*) lt.eq R_(upright("exp")) \( h_(cal(H))^(*) \) lt.eq R_(upright("emp")) \( hat(h)_(cal(H)) \) $

我们定义 1. #strong[近似误差 (Approximation Error)];:
$R_(upright("exp")) \( h_(cal(H))^(*) \) - R^(*)$, 反映了算法集合
$cal(H)$ 的表达能力.

#block[
#set enum(numbering: "1.", start: 2)
+ #strong[估计误差 (Estimation Error)];:
  $R_(upright("emp")) \( hat(h)_(cal(H)) \) - R_(upright("exp")) \( h_(cal(H))^(*) \)$,
  反映了有限样本对算法选择的影响.

+ #strong[泛化误差 (Generalization Error)];:
  $R_(upright("emp")) \( hat(h)_(cal(H)) \) - R^(*)$,
  这里把上面两个限制都加上, 可以看出泛化误差是近似误差和估计误差之和.
]

=== 泛化误差限
引入 Hoeffding 不等式, 对于独立同分布的随机变量
$Z_1 \, Z_2 \, dots.h \, Z_N$, 且 $Z_i in \[ a \, b \]$, 设
$ P (1 / N S_N - bb(E) \[ Z \] gt.eq epsilon.alt) lt.eq exp (- frac(2 N epsilon.alt^2, \( b - a \)^2)) $

特别地, 当 $Z_i in \[ 0 \, 1 \]$ 时, 有
$ P (1 / N S_N - bb(E) \[ Z \] gt.eq epsilon.alt) lt.eq exp \( - 2 N epsilon.alt^2 \) $

我们考虑二分类问题, 损失函数为 0-1 损失函数, 即
$
ell(y, f(bold(x); bold(theta))) = cases(0 comma & y = f(bold(x); bold(theta)), 1 comma & y != f(bold(x); bold(theta)))
$

设训练数据集 $T = { \( bold(u)_i \, v_i \) }_(i = 1)^N$
独立同分布采样自总体分布 $P \( bold(u) \, v \)$, 其中
$bold(u)_i in bb(R)^n$, $v_i in { - 1 \, 1 }$ 设
$cal(H) = { h_1 \, h_2 \, dots.h \, h_k }$ 为有限假设空间, 且
$beta = lr(|cal(H)|)$ 为函数个数.

将 0-1 损失函数 $ell$ 视为随机变量, 由于始终有 $ell in \[ 0 \, 1 \]$,
因此可以使用 Hoeffding 不等式. 对于 #strong[任意一个函数] $h$, 由
$ P (R_(upright("emp")) \( h \) - R_(upright("exp")) \( h \) gt.eq epsilon.alt) lt.eq exp \( - 2 N epsilon.alt^2 \) $

现在我们计算在整个假设空间 $cal(H)$ 中, #strong[存在某个函数] $h$
使得上式成立的概率.

$ P \( exists h in cal(H) : R_(upright("emp")) \( h \) - R_(e x p) \( h \) gt.eq epsilon \) & = P \( union.big_(h in cal(H)) { R_(e m p) \( h \) - R_(e x p) \( h \) gt.eq epsilon } \)\
 & lt.eq sum_(h in cal(H)) P \( R_(e m p) \( h \) - R_(e x p) \( h \) gt.eq epsilon \)\
 & lt.eq sum_(h in cal(H)) exp \( - 2 n epsilon^2 \)\
 & = \| cal(H) \| exp \( - 2 n epsilon^2 \)\
 & = beta exp \( - 2 n epsilon^2 \) $

我们假设这个满足条件的函数为 $h_(cal(H))$, 则
$ P \( R_(upright("emp")) \( h_(cal(H)) \) - R_(upright("exp")) \( h_(cal(H)) \) < epsilon \) lt.eq 1 - beta exp \( - 2 n epsilon^2 \) $

令 $delta = beta exp \( - 2 n epsilon^2 \)$,
$epsilon \( delta \, beta \, N \) = sqrt(frac(1, 2 N) ln beta / delta)$,
则有

$ P \( R_(upright("emp")) \( h_(cal(H)) \) - R_(upright("exp")) \( h_(cal(H)) \) < epsilon \( delta \, beta \, N \) \) gt.eq 1 - delta $

这说明至少有 $1 - delta$ 的概率, 使得估计误差小于
$epsilon \( delta \, beta \, N \)$. 这就找到了估计误差的上界.

对于泛化误差的上节, 我们令
$ hat(h)_(cal(H)) = arg min_(h in cal(H)) R_(upright("emp")) \( h \) $

则有
$ bar.v.double R_(upright("emp")) \( hat(h)_(cal(H)) \) - R^(*) bar.v.double &lt.eq underbrace(R_(upright("emp")) \( hat(h)_(cal(H)) \) - R_(upright("exp")) \( h_(cal(H))^(*) \), #[估计误差]) + underbrace(R_(upright("exp")) \( h_(cal(H))^(*) \) - R^(*), #[近似误差])  \ &< epsilon \( delta \, beta \, N \) + #[近似误差] $

这就是泛化误差界,
它刻画了学习算法的经验风险与期望风险之间偏差和收敛速度.

由此可知: 1. 假设空间的复杂度 $beta$ 越大, 估计误差的上界越大,
泛化能力越差. 2. 训练样本数 $N$ 越大, 估计误差的上界越小, 泛化能力越强.

== 过拟合与欠拟合
=== 过拟合
过拟合 (Overfitting) 是指模型在训练数据上表现良好,
但在未见过的测试数据上表现较差的现象. 过拟合通常发生在模型过于复杂,
参数过多, 或训练数据量不足的情况下. 
=== 欠拟合 
欠拟合 (Underfitting) 是指模型在训练数据上和测试数据上都表现不佳的现象.

=== 模型评估
为了定量考虑这些问题, 往往将数据集进行随机分组, 一部分作为训练集
(Training Set), 用于模型训练; 另一部分作为测试集 (Test Set),
用于选择最合适的模型. 通过比较模型在训练集和测试集上的表现,
可以判断模型是否存在过拟合或欠拟合现象.

设在训练集 $T$ 上, 我们训练后的模型为 $h_T \( u \)$, 那么该模型对数据
$u$ 的预测输出为 $f \( macron(u) \) = bb(E)_T \[ h_T \( u \) \]$.

设验证集样本的真实值为 $v$, 由于会有噪声的存在,
样本的标签值可能与真实值有出入, 设标签值为 $v_T$, 噪声
$v_epsilon.alt = v - v_T$, 这里假设
$v_epsilon.alt in cal(N) \( 0 \, sigma^2 \)$.

定义 
1. #strong[偏差 (Bias)];: $upright("Bias") \( u \) = v_T - f \( macron(u) \)$, 衡量模型预测值的期望与真实值之间的差异. 
2. #strong[方差 (Variance)];: $upright("Var") \( u \) = bb(E)_T [\( h_T \( u \) - f \( macron(u) \) \)^2]$, 衡量模型预测值在不同训练集上的波动性. 
3. #strong[泛化误差 (Generalization Error)];: $upright("Err") \( u \) = bb(E)_T [\( h_T \( u \) - v \)^2]$, 衡量模型在新数据上的表现.

通过推导可以得到
$ upright("Err") \( u \) = upright("Bias")^2 \( u \) + upright("Var") \( u \) + sigma^2 $

== 最优化问题
=== 最优化问题的一般形式
最优化问题的一般形式为 $ min_(bold(x)) quad & f \( bold(x) \)\
upright("s.t.") quad & bold(x) in cal(X) $ 其中 
1. $bold(x) in bb(R)^n$ 为决策变量 (Decision Variable). 
2. $f : bb(R)^n arrow.r bb(R)$ 为目标函数 (Objective Function). 
3. $cal(X) subset.eq bb(R)^n$ 为可行域 (Feasible Region). 特别地, 当 $cal(X) = bb(R)^n$ 时, 称为无约束最优化问题 (Unconstrained Optimization Problem). 
4. 集合 $cal(X)$ 通常可以由约束函数 $c_i : bb(R)^n arrow.r bb(R)$ 来定义, 即 
$ cal(X) = { bold(x) in bb(R)^n : c_i \( bold(x) \) lt.eq 0 \, i = 1 \, 2 \, dots.h \, m ; med c_i \( bold(x) \) = 0 \, i = m + 1 \, m + 2 \, dots.h \, m + l } $
5. 在所有满足约束条件的决策变量中, 使目标函数取最小值的决策变量 $bold(x)^(*)$ 称为最优解 (Optimal Solution), 即 $ bold(x)^(*) = arg min_(bold(x) in cal(X)) f \( bold(x) \) $

=== 最优化问题的类型
+ 当目标函数和约束函数均为线性函数时, 问题称为 #strong[线性规划 (Linear
  Programming, LP)];.
+ 当目标函数和约束函数中至少有一个为非线性函数时, 问题称为
  #strong[非线性规划 (Nonlinear Programming, NLP)];.
+ 如果目标函数是二次函数而约束函数是线性函数, 则问题称为
  #strong[二次规划 (Quadratic Programming, QP)];.
+ 包含非光滑函数的问题称为 #strong[非光滑优化 (Nonsmooth Optimization)];.
+ 不能直接求导数的问题称为 #strong[无导数优化 (Derivative-free
  Optimization)];.
+ 变量只能取整数的问题称为 #strong[整数规划 (Integer Programming, IP)];.
+ 在线性约束下极小化关于半正定矩阵的线性函数的问题称为 #strong[半定规划
  (Semidefinite Programming, SDP)];.
+ 最优解只有少量非零元素的问题称为 #strong[稀疏优化 (Sparse
  Optimization)];.
+ 最优解是低秩矩阵的问题称为 #strong[低秩优化 (Low-rank Optimization)];.

=== 全局最优解和局部最优解
对于可行解 $macron(x) in cal(X)$, 定义如下概念: 
1. 如果 $f \( macron(x) \) lt.eq f \( x \)$ 对于所有 $x in cal(X)$ 成立, 则称 $macron(x)$ 为 #strong[全局极小解 (Global Minimum)];. 
2. 如果存在某个 $x in cal(X) inter B \( macron(x) \, epsilon.alt \)$ 成立, 其中 $B \( macron(x) \, epsilon.alt \) = { x in bb(R)^n : bar.v.double x - macron(x) bar.v.double < epsilon.alt }$, 则称 $macron(x)$ 为 #strong[局部极小解 (Local Minimum)];. 
3. 进一步地, 如果 $f \( macron(x) \) < f \( x \)$ 对于所有 $x in cal(X) inter B \( macron(x) \, epsilon.alt \)$ 且 $x eq.not macron(x)$ 成立, 则称 $macron(x)$ 为 #strong[严格局部极小解 (Strict Local Minimum)];. 
4. 如果一个点是局部极小解, 但不是严格局部极小解, 则称其为 #strong[非严格局部极小解 (Non-strict Local Minimum)];.

=== 优化算法的收敛性
对于实际的最优化问题, 我们常使用 #strong[迭代法 (Iterative Method)]
来求解. 设 ${ x^k }$ 为算法产生的迭代序列, 如果在某种范数
$bar.v.double dot.op bar.v.double$ 下, 对于某个局部 (或全局) 最优解
$x^(*)$, 有
$lim_(k arrow.r oo) bar.v.double x^k - x^(*) bar.v.double = 0$,
则称迭代序列 ${ x^k }$ #strong[依点列] 收敛于 $x^(*)$, 相应的算法称为是
#strong[依点列收敛到局部 (或全局) 最优解];.

如果从任意的出发点 $x^0 in cal(X)$ 开始, 迭代序列 ${ x^k }$
都依点列收敛于某个局部 (或全局) 最优解 $x^(*)$, 则称该算法
#strong[全局依点列收敛到局部 (或全局) 最优解];. 对于 #strong[凸优化]
问题, 因为任意局部最优解也是全局最优解,
所以全局依点列收敛到局部最优解等价于全局依点列收敛到全局最优解.

=== 算法的渐进收敛速度
设 ${ x^k }$ 为算法产生的迭代序列, $x^(*)$ 为某个局部 (或全局) 最优解:
\1. 算法 (点列) $cal(Q)$-线性收敛 (Q-linear Convergence): 存在
$ bar.v.double x^(k + 1) - x^(*) bar.v.double lt.eq mu bar.v.double x^k - x^(*) bar.v.double $
\2. 算法 (点列) $cal(Q)$-超线性收敛 (Q-superlinear Convergence):
$ lim_(k arrow.r oo) frac(bar.v.double x^(k + 1) - x^(*) bar.v.double, bar.v.double x^k - x^(*) bar.v.double) = 0 $
\3. 算法 (点列) $cal(Q)$-次线性收敛 (Q-sublinear Convergence):
$ lim_(k arrow.r oo) frac(bar.v.double x^(k + 1) - x^(*) bar.v.double, bar.v.double x^k - x^(*) bar.v.double) = 1 $
这里超线性收敛速度最快, 次线性收敛速度最慢, 分别是线性收敛的两个极端.

#block[
#set enum(numbering: "1.", start: 4)
+ 算法 (点列) $cal(Q)$-二次收敛 (Q-quadratic Convergence): 存在

+ 算法 (点列) $cal(R)$-线性收敛 (R-linear Convergence): 存在一个
  $cal(Q)$-线性收敛到 0 的非负数列 ${ v_k }$, 使得对于所有
  $k gt.eq k_0$, 有 $ bar.v.double x^k - x^(*) bar.v.double lt.eq v_k $
  类似地可以定义 $cal(R)$-超线性收敛和 $cal(R)$-次线性收敛. 从
  $cal(R)$-收敛速度的定义可以看出序列 ${ v_k }$ 的收敛速度被另一个序列
  ${ v_k }$ 所控制, 当知道 $v_k$ 的形式时, 我们也称算法 (点列)
  的收敛速度为 $cal(O) \( v_k \)$.
]

=== 优化算法的收敛准则
在实际应用中, 由于计算资源和时间的限制, 我们通常不会让算法无限迭代下去,
而是设定一个合理的停止准则 (Stopping Criterion), 当满足该准则时,
算法停止迭代并输出当前的解作为最终结果.

对于无约束优化问题, 常用的收敛准则有
$ frac(f \( x^k \) - f \( x^(*) \), max { \| f \( x^(*) \) \| \, 1 }) < epsilon.alt_1 \, quad bar.v.double nabla f \( x^k \) bar.v.double < epsilon.alt_2 $
其中 $epsilon.alt_1 \, epsilon.alt_2$ 为预设的精度阈值, $x^(*)$
为问题的最优解 (如果已知的话).
这个准则结合了目标函数值的变化和梯度的大小,
能够较好地反映算法的收敛情况.

对于有约束优化问题, 还需要考虑约束违反度, 即要求最后得到的点满足
$ max { c_i \( x^k \) \, 0 } < epsilon.alt_3 \, & quad i = 1 \, 2 \, dots.h \, m\
\| c_i \( x^k \) \| < epsilon.alt_4 \, & quad i = m + 1 \, m + 2 \, dots.h \, m + l $
其中 $epsilon.alt_3 \, epsilon.alt_4$ 为预设的精度阈值.
这个准则确保了最终解不仅在目标函数上接近最优, 还满足约束条件.

=== 最优化的实例
==== 最小二乘法线性回归
给定训练数据集 ${ \( bold(x)_i \, y_i \) }_(i = 1)^N$, 其中 $bold(x)_i in bb(R)^n$ 为输入特征, $y_i in bb(R)$ 为目标值. 我们假设模型为线性模型, 即 $ f \( bold(x) ; bold(theta) \) = bold(theta)^T bold(x) $ 其中 $bold(theta) in bb(R)^n$ 为模型参数. 我们使用均方误差 (MSE) 作为损失函数, 即 $ell \( y \, f \( bold(x) ; bold(theta) \) \) = \( y - f \( bold(x) ; bold(theta) \) \)^2$. 如果有偏置项, 则可以将输入特征扩展为 $bold(x)' = \[ 1 \, bold(x)^T \]^T$, 参数扩展为 $bold(theta)' = \[ theta_0 \, bold(theta)^T \]^T$, 其中 $theta_0$ 为偏置项.

我们定义 #strong[增广矩阵]
$tilde(X) = \[ bold(x)_1 \, bold(x)_2 \, dots.h \, bold(x)_N \]^T in bb(R)^(N times n)$
和 #strong[目标值向量]
$bold(y) = \[ y_1 \, y_2 \, dots.h \, y_N \]^T in bb(R)^N$.
则经验风险可以写成矩阵形式
$ R_(upright("emp")) \( bold(theta) \) = 1 / N bar.v.double tilde(X) bold(theta) - bold(y) bar.v.double_2^2 $
最优化问题就为 $min_(bold(theta)) R_(upright("emp")) \( bold(theta) \)$.
这个问题有解析解
$ bold(theta)^(*) = \( tilde(X)^T tilde(X) \)^(- 1) tilde(X)^T bold(y) $
==== 岭回归 
岭回归 (Ridge Regression) 是在最小二乘法的基础上, 引入
$L_2$ 正则化项以防止过拟合. 岭回归的目标函数为
$ R_(upright("ridge")) \( bold(theta) \) = bar.v.double tilde(X) bold(theta) - bold(y) bar.v.double_2^2 + lambda bar.v.double bold(theta) bar.v.double_2^2 $
$ bold(theta)^(*) = \( tilde(X)^T tilde(X) + lambda I \)^(- 1) tilde(X)^T bold(y) $

#strong[岭回归的几何解释];: 岭回归的最优化问题
$ min_(bold(theta)) bar.v.double tilde(X) bold(theta) - bold(y) bar.v.double_2^2 + lambda bar.v.double bold(theta) bar.v.double_2^2 $
等价于约束最优化问题
$ min_(bold(theta)) quad & bar.v.double tilde(X) bold(theta) - bold(y) bar.v.double_2^2\
upright("s.t.") quad & bar.v.double bold(theta) bar.v.double_2^2 lt.eq t $
这个约束条件定义了一个以原点为中心的球体, 岭回归的解 $bold(theta)^(*)$
必须位于这个球体内.

#strong[Woodbury-Sherman-Morrison 公式];: 回顾岭回归的解析解
$ bold(theta)^(*) = \( tilde(X)^T tilde(X) + lambda I \)^(- 1) tilde(X)^T bold(y) $
设这里 $X$ 的维度为 $N times D$, 其中 $N$ 为样本数, $D$ 为特征数. 那么
$\( tilde(X)^T tilde(X) + lambda I \)$ 的维度为 $D times D$. 当 $D$
很大时, 计算其逆矩阵的时间复杂度为 $cal(O) \( D^3 \)$,
这在高维数据下是无法接受的.

这时, Woodbury-Sherman-Morrison 公式就派上用场了. 该公式指出, 对于
$2 times 2$ 的可逆分块矩阵 $mat(delim: "(", A, B; C, D)$ 满足 $A$ 和 $D$
可逆, 则有
$ \( A - B D^(- 1) C \)^(- 1) B D^(- 1) = A^(- 1) B \( D - C A^(- 1) B \)^(- 1) $

令 $A = lambda I$, $B = tilde(X)^T$, $C = - tilde(X)$, $D = I$, 则有
$ \( tilde(X)^T tilde(X) + lambda I \)^(- 1) tilde(X)^T = tilde(X)^T \( lambda I + tilde(X) tilde(X)^T \)^(- 1) $
这里的计算复杂度为 $cal(O) \( N^3 \)$. 所以当 $N < D$ 时, 使用
Woodbury-Sherman-Morrison 公式可以显著降低计算复杂度.

==== 稀疏优化
给定 $b in bb(R)^m$, $A in bb(R)^(m times n)$, 且有 $m lt.double n$.
我们希望找到一个尽可能稀疏的 $x in bb(R)^n$, 使得 $A x = b$.

注意到由于 $m lt.double n$, 该线性方程组有无穷多解, 重构出原始信号看似很难．但是, 这些解当中大部分是不重要的, 真正有用的解是所谓的 #strong[稀疏解];, 即原始信号中大部分元素为零, 只有少数元素非零. 因此, 我们可以将问题转化为
$ \( ell_p \) : min bar.v.double x bar.v.double_p\
upright("s.t.") quad A x = b \, quad p = 0 \, 1 \, 2 \, dots.h $ 当
$p = 0$ 时, $bar.v.double x bar.v.double_0$ 表示 $x$ 中非零元素的个数, 该问题称为 #strong[$ell_0$ 优化问题];. 该问题是 NP-hard 的, $bar.v.double x bar.v.double_0$ 的取值只能为整数, 不能使用常规的最优化方法. 同时需要注意的是, $ell_1$ 和 $ell_2$ 的解也不一定相同.

#strong[LASSO 问题];: 考虑带 $ell_1$ 正则化的最小二乘问题, 即
$ min_x bar.v.double A x - b bar.v.double_2^2 + lambda bar.v.double x bar.v.double_1 $
该问题称为 LASSO (Least Absolute Shrinkage and Selection Operator) 问题,
该问题可以被看作是 $ell_1$ 优化问题的一个变种. 通过调整正则化参数
$lambda$, 可以控制解的稀疏性.

==== 回归分析
考虑线性模型 $b = A x + epsilon.alt$, 假设
$epsilon.alt tilde.op cal(N) \( 0 \, sigma^2 I \)$, 则我们可以得到给定
$A$ 和 $x$ 时, 观测值 $b$ 的条件概率分布为
$ p \( b divides A \, x \) = frac(1, \( 2 pi \)^(m \/ 2) sigma^m) exp (- frac(1, 2 sigma^2) bar.v.double A x - b bar.v.double_2^2) $
我们希望估计一个最优的 $x$ 使得观测值 $b$ 出现的概率最大,
即最大化对数似然函数
$ max_x log p \( b divides A \, x \) = max_x - frac(1, 2 sigma^2) bar.v.double A x - b bar.v.double_2^2 + upright("const") $

可以看到这个最优化问题等价于最小化 $bar.v.double A x - b bar.v.double_2^2$,
这就是最小二乘法. 也就是说, #strong[当假设误差是高斯白噪声时,
最小二乘解就是线性回归模型的最大似然解];.

#strong[Tikhonov 正则化];: 为了平衡数据拟合和模型复杂度,
我们可以引入正则化项, 得到 Tikhonov 正则化问题
$ min_x bar.v.double A x - b bar.v.double_2^2 + lambda bar.v.double x bar.v.double_2^2 $

这就类似于最小二乘法中的岭回归. 由于正则项的存在,
该问题的目标函数为强凸函数, 解的性质得到改善

#strong[LASSO 问题及其变形] 另一方面, 如果希望解 $x$ 是稀疏的, 可以添加
$ell_1$ 正则化项, 得到 LASSO 问题
$ min_x bar.v.double A x - b bar.v.double_2^2 + lambda bar.v.double x bar.v.double_1 $
也可以考虑问题
$ min_x bar.v.double A x - b bar.v.double_2^2 \, quad upright("s.t.") quad bar.v.double x bar.v.double_1 lt.eq t $
考虑到噪声 $epsilon.alt$ 的存在, 我们可以将约束条件改为
$bar.v.double A x - b bar.v.double_2^2 lt.eq nu$, 这样就得到了一个等价的优化问题
$ min_x bar.v.double x bar.v.double_1 \, quad upright("s.t.") quad bar.v.double A x - b bar.v.double_2^2 lt.eq nu $
如果参数 $x$ 具有 #strong[分组稀疏性] (Group Sparsity), 即 $x$
的分量可分为 $G$ 个组, 每个组内的参数必须同时为零或同时非零,
为此人们提出了 #strong[分组 LASSO 问题];:
$ min_x bar.v.double A x - b bar.v.double_2^2 + mu sum_(g = 1)^G sqrt(n_g) bar.v.double x_(cal(I)_g) bar.v.double_2 $
其中 $cal(I)_g$ 是第 $g$ 个组的索引, 且
$ n_g = lr(|cal(I)_g|) \, quad sum_(g = 1)^G n_g = n $
这里的正则项也可以被看做是 $bar.v.double x_(cal(I)_g) bar.v.double_2$ 的
$ell_1$ 范数, 也就是对每个组的 $ell_2$ 范数求和. 分组 LASSO
问题把稀疏性从单个特征提升到了组的级别上，但不要求组内的稀疏性.

如果需要同时保证分组以及单个特征的稀疏性, 可以考虑将两种正则项结合起来,
即有稀疏分组 LASSO 模型
$ min_x bar.v.double A x - b bar.v.double_2^2 + mu sum_(g = 1)^G sqrt(n_g) bar.v.double x_(cal(I)_g) bar.v.double_2 + lambda bar.v.double x bar.v.double_1 $

当特征 $x$ 本身不稀疏但在某种变换下是稀疏的, 则需调整正则项
$ min_x bar.v.double A x - b bar.v.double_2^2 + lambda bar.v.double F x bar.v.double_1 $
特别地, 如果要求 $x$ 相邻元素之间是稀疏的 (i.e.~相邻元素之间的差分稀疏),
则可以取
$ F = mat(delim: "(", 1, - 1, 0, dots.h.c, 0; 0, 1, - 1, dots.h.c, 0; dots.v, dots.v, dots.down, dots.down, dots.v; 0, 0, dots.h.c, 1, - 1) in bb(R)^(\( n - 1 \) times n) $

#strong[逻辑回归 (Logistic Regression)];: 考虑二分类问题, 设
$y in { - 1 \, 1 }$, 输入特征为 $bold(x) in bb(R)^n$. 我们假设输出 $y$
的条件概率分布为
$ p \( y = 1 divides bold(x) \) & = sigma \( bold(w)^T bold(x) \) = frac(1, 1 + e^(- bold(w)^T bold(x))) ;\
p \( y = - 1 divides bold(x) \) & = 1 - p \( y = 1 divides bold(x) \) = frac(e^(- bold(w)^T bold(x)), 1 + e^(- bold(w)^T bold(x))) $
这可以被统一为
$ p \( y divides bold(x) \) = frac(1, 1 + e^(- y bold(w)^T bold(x))) $
由此可以写出对数似然函数
$ ell \( bold(w) \) & = sum_(i = 1)^N log p \( y_i divides bold(x)_i \) = - sum_(i = 1)^N log \( 1 + e^(- y_i bold(w)^T bold(x)_i) \)\
 $ 在此基础上加上正则项
$ R_(upright("emp")) \( bold(w) \) = sum_(i = 1)^N log \( 1 + e^(- y_i bold(w)^T bold(x)_i) \) + lambda bar.v.double bold(w) bar.v.double_2^2 $

==== 支持向量机 (SVM)
TODO 

==== 低秩矩阵恢复 
我们考虑下面的实际问题:

某视频网站提供了约 48 万用户对 1 万 7 千多部电影的上亿条评级数据,
希望对用户的电影评级进行预测，从而改进用户电影推荐系统,
为每个用户更有针对性地推荐影片. 显然每一个用户不可能看过所有的电影,
每一部电影也不可能收集到全部用户的评级. 电影评级由用户打分 1 星到 5
星表示, 记为取值 $1 tilde.op 5$ 的整数. 我们将电影评级放在一个矩阵 $M$
中, $M$ 的每一行表示不同用户, 每一列表示不同电影, $M_(i j)$ 表示用户 $i$
对电影 $j$ 的评级. 由于每个用户只看过部分电影, 因此矩阵 $M$
是一个稀疏矩阵, 其中大部分元素为 0.

由于用户对电影的评级受多种因素影响, 如用户的兴趣、电影的类型、导演等,
因此我们可以假设矩阵 $M$ 的秩较低. 我们形式化这个问题为, 令 $Sigma$
是矩阵 $M$ 中所有已知评级元素的下标的集合, 即
$Sigma = { \( i \, j \) : M_(i j) eq.not 0 }$, 我们希望找到一个低秩矩阵
$X$ 使得
$ min_(X in bb(R)^(m times n)) upright("rank") \( X \) quad upright("s.t.") quad X_(i j) = M_(i j) \, quad \( i \, j \) in Sigma $
回顾矩阵的核范数定义为
$ bar.v.double X bar.v.double_(*) = sum_(i = 1)^(min \( m \, n \)) sigma_i \( X \) $
其中 $sigma_i \( X \)$ 是矩阵 $X$ 的奇异值. 由于核范数是一个凸函数,
因此我们可以将上述问题转化为
$ min_(X in bb(R)^(m times n)) bar.v.double X bar.v.double_(*) quad upright("s.t.") quad X_(i j) = M_(i j) \, quad \( i \, j \) in Sigma $
\
考虑到观测可能出现误差, 我们可以给出该问题的二次罚函数形式
$ min_(X in bb(R)^(m times n)) bar.v.double X bar.v.double_(*) + lambda sum_(\( i \, j \) in Sigma) \( X_(i j) - M_(i j) \)^2 $
又考虑到低秩矩阵可以被分解 $X = L R^T$, 其中 $L in bb(R)^(m times r)$,
$R in bb(R)^(n times r)$, $r lt.double min \( m \, n \)$ 是矩阵的秩,
因此我们可以将问题转化为
$ min_(L in bb(R)^(m times r) \, R in bb(R)^(n times r)) sum_(\( i \, j \) in Sigma) \( L_i^T R_j - M_(i j) \)^2 + alpha bar.v.double L bar.v.double_F^2 + beta bar.v.double R bar.v.double_F^2 $
这里 $bar.v.double L bar.v.double_F$ 和 $bar.v.double R bar.v.double_F$ 分别是矩阵 $L$
和 $R$ 的 Frobenius 范数, 它的作用是消除 $L$ 和 $R$
在放缩意义下的不唯一性, $alpha$ 和 $beta$ 是正则化参数.

= 第二章: 凸集与凸函数
== 凸集的定义
=== 凸集的几何定义
在 $bb(R)^n$ 中, 对于任意两个点 $x_1 \, x_2 in bb(R)^n$,
连接这两点的直线定义为
$ { theta x_1 + \( 1 - theta \) x_2 \, theta in bb(R) } $ 特别地, 当
$theta in \[ 0 \, 1 \]$ 时, 该直线退化为线段.

如果过集合 $cal(C)$ 中任意两点 $x_1 \, x_2$ 的 #strong[直线] 都包含在
$cal(C)$ 中, 即
$ theta x_1 + \( 1 - theta \) x_2 in cal(C) \, quad forall x_1 \, x_2 in cal(C) \, thin forall theta in bb(R) $
则称集合 $cal(C)$ 是 #strong[仿射集 (Affine Set)];. 如果过集合 $cal(C)$
中任意两点 $x_1 \, x_2$ 的 #strong[线段] 都包含在 $cal(C)$ 中, 即
$ theta x_1 + \( 1 - theta \) x_2 in cal(C) \, quad forall x_1 \, x_2 in cal(C) \, thin forall theta in \[ 0 \, 1 \] $
则称集合 $cal(C)$ 是 #strong[凸集 (Convex Set)];. 仿射集肯定是凸集.

=== 凸集的性质
+ 如果 $cal(S)$ 是凸集, 则
  $k cal(S) = { k x divides x in cal(S) \, thin k in bb(R) }$ 也是凸集.
+ 如果 $cal(S)$ 和 $cal(T)$ 都是凸集, 则
  $cal(S) + cal(T) = { x + y divides x in cal(S) \, y in cal(T) }$
  也是凸集.
+ 如果 $cal(S)$ 和 $cal(T)$ 都是凸集, 则 $cal(S) sect cal(T)$ 也是凸集.
+ 凸集的内部 (Interior) 和闭包 (Closure) 也是凸集. 这里
  - 内部定义为
    其中
    $B \( x \, r \) = { y in bb(R)^n : bar.v.double y - x bar.v.double < r }$.
  - 闭包定义为
    $upright("cl") \( cal(C) \) = cal(C) union { x : x upright(" 是 ") cal(C) upright(" 的极限点") }$.

=== 凸组合和凸包
形如
$ theta_1 x_1 + theta_2 x_2 + dots.h.c + theta_k x_k \, quad theta_i gt.eq 0 \, i = 1 \, 2 \, dots.h \, k ; quad sum_(i = 1)^k theta_i = 1 $
的点称为点 $x_1 \, x_2 \, dots.h \, x_k$ 的 #strong[凸组合 (Convex
Combination)]

集合 $cal(S)$ 中所有点的凸组合构成的集合称为 $cal(S)$ 的 #strong[凸包
(Convex Hull)];, 记为 $upright("conv") \( cal(S) \)$. 显然,
$upright("conv") \( cal(S) \)$ 是最小的包含 $cal(S)$ 的凸集.

同时, 我们也有 $upright("conv") \( cal(S) \) subset.eq cal(S)$ 当且仅当
$cal(S)$ 是凸集.

=== 仿射组合和仿射包
形如
$ theta_1 x_1 + theta_2 x_2 + dots.h.c + theta_k x_k \, quad sum_(i = 1)^k theta_i = 1 $
的点称为点 $x_1 \, x_2 \, dots.h \, x_k$ 的 #strong[仿射组合 (Affine
Combination)];. 仿射组合与凸组合的区别在于, 仿射组合的系数 $theta_i$
可以为负数.

集合 $cal(S)$ 中所有点的仿射组合构成的集合称为 $cal(S)$ 的
#strong[仿射包 (Affine Hull)];, 记为 $upright("aff") \( cal(S) \)$.
显然, $upright("aff") \( cal(S) \)$ 是最小的包含 $cal(S)$ 的仿射集.

=== 锥组合和凸锥
相比于凸组合和仿射组合, 锥组合不要求系数之和为 1. 形如
$ theta_1 x_1 + theta_2 x_2 + dots.h.c + theta_k x_k \, quad theta_i gt.eq 0 \, i = 1 \, 2 \, dots.h \, k $
的点称为点 $x_1 \, x_2 \, dots.h \, x_k$ 的 #strong[锥组合 (Conical
Combination)];.

若集合 $cal(S)$ 中的任意点的锥组合都包含在 $cal(S)$ 中, 则称集合
$cal(S)$ 是 #strong[凸锥 (Convex Cone)];.

== 重要的凸集举例
=== 超平面和半空间
在 $bb(R)^n$ 中, 设 $a in bb(R)^n$, $a eq.not 0$, $b in bb(R)$, 则集合
$ cal(H) = { x in bb(R)^n : a^T x = b } $ 称为 #strong[超平面
(Hyperplane)];. 超平面将 $bb(R)^n$ 分成两个部分, 即
$ cal(H)_(-) = { x in bb(R)^n : a^T x lt.eq b } \, quad cal(H)_(+) = { x in bb(R)^n : a^T x gt.eq b } $
超平面是仿射集, 也是凸集.

#strong[半空间 (Half-space)] 是指超平面 $cal(H)$ 的任一侧, 即
$cal(H)_(-)$ 或 $cal(H)_(+)$. 半空间是凸集, 但不是仿射集.

=== 多面体
#strong[多面体 (Polyhedron)]
是指由有限个线性不等式和线性等式所定义的集合, 即
$ cal(P) = { x in bb(R)^n : A x lt.eq b \, thin C x = d } $ 其中
$A in bb(R)^(m times n)$, $b in bb(R)^m$, $C in bb(R)^(l times n)$,
$d in bb(R)^l$. $x lt.eq$ 和 $=$ 分别表示逐元素的比较.

多面体是有限个半空间和超平面的交, 因此由凸集的性质可知, 其为凸集.

=== 范数球和椭球
#strong[范数球 (Norm Ball)] 是指形如
$ cal(B) = { x in bb(R)^n : bar.v.double x - x_c bar.v.double lt.eq r } $
$bar.v.double dot.op bar.v.double$ 为某种范数. 范数球是凸集.

#strong[椭球 (Ellipsoid)] 是指形如
$ cal(E) = { x in bb(R)^n : \( x - x_c \)^T P^(- 1) \( x - x_c \) lt.eq 1 } $
的集合, 其中 $x_c in bb(R)^n$ 为椭球心, $P in bb(R)^(n times n)$
为对称正定矩阵. 椭球是凸集.

椭球也可以被表示为
$ cal(E) = { x_c + A u : bar.v.double u bar.v.double_2 lt.eq 1 } $ 其中
$A in bb(R)^(n times n)$ 满足 $P = A A^T$. 这里的 $A$
可以被看做是将单位球映射到椭球的线性变换矩阵.

=== 范数锥
#strong[范数锥 (Norm Cone)] 是指形如
$ cal(K) = { \( x \, t \) in bb(R)^(n + 1) : bar.v.double x bar.v.double lt.eq t \, thin t gt.eq 0 } $
的集合, 其中 $bar.v.double dot.op bar.v.double$ 为某种范数. 范数锥是凸锥.
特别地, 用 $ell_2$ 范数定义的范数锥称为 #strong[二次锥]

=== 特殊矩阵集合和 (半) 正定锥
- #strong[对称矩阵集合];: 设 $cal(S)^n$ 表示所有 $n times n$
  实对称矩阵的集合, 即
  $ cal(S)^n = { X in bb(R)^(n times n) : X = X^T } $

- #strong[半正定矩阵集合];: 设 $cal(S)_(+)^n$ 表示所有 $n times n$
  实对称半正定矩阵的集合, 即
  $ cal(S)_(+)^n = { X in cal(S)^n : X succ.curly.eq 0 } $

这里 $X succ.curly.eq 0$ 表示矩阵 $X$ 是半正定的, 即对于任意非零向量
$z in bb(R)^n$, 有 $z^T X z gt.eq 0$. 我们一般称 $cal(S)_(+)^n$ 为
#strong[半正定锥 (Positive Semidefinite Cone)];, 它是一个凸锥.

- #strong[正定矩阵集合];: 设 $cal(S)_(+ +)^n$ 表示所有 $n times n$
  实对称正定矩阵的集合, 即
  $ cal(S)_(+ +)^n = { X in cal(S)^n : X succ 0 } $

== 保凸的运算
=== 仿射变换的保凸性
设 $f : bb(R)^n arrow.r bb(R)^m$ 是一个仿射变换, 即
$f \( x \) = A x + b$, 其中 $A in bb(R)^(m times n)$, $b in bb(R)^m$, 则
- 凸集在 $f$ 下的像是凸集
$ f \( cal(C) \) = { f \( x \) : x in cal(C) } "is convex if" cal(C) "is convex" $

- 凸集在 $f$ 下的原像是凸集
  
$ f^(- 1) \( cal(D) \) = { x : f \( x \) in cal(D) } "is convex if" cal(D) "is convex" $

#strong[例子];, 对于双曲锥
$ cal(C) = { \( x \, t \) in bb(R)^(n + 1) : bar.v.double x bar.v.double_2^2 lt.eq t u \, thin t gt.eq 0 \, thin u gt.eq 0 } $
