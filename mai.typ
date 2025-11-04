#import "@preview/showybox:2.0.4": showybox

#import "@preview/equate:0.3.2": equate
#import "@preview/ilm:1.4.1": *
#import "@preview/finite:0.5.0": automaton
#import "@preview/finite:0.5.0"

#set text(font:("Libertinus Serif", "Source Han Serif SC"))

#show heading.where(level: 1): set text(navy.lighten(0%))
#show heading.where(level: 2): set text(navy.lighten(20%))
#show heading.where(level: 3): set text(navy.lighten(40%))

#show ref: it => {
  text(purple.darken(30%), it)
}

#show: ilm.with(
  title: [Mathematics Foundation in Machine Learning],
  date: datetime.today(),
  author: "Tianlin Pan",
  table-of-contents: outline(depth: 2),
)

#show: equate.with(breakable: true, sub-numbering: true)
#set math.equation(numbering: "(1.1)")

#set heading(numbering: "1.1.1")
#set page(numbering: "1")
#set text(14pt)
#show raw: set text(font: ("Maple Mono NF"), size: 12pt)

#let frameSettings = (
  border-color: navy,
  title-color: navy.lighten(30%),
  body-color: navy.lighten(95%),
  footer-color: navy.lighten(80%)
)

#let frameSettingsEastern = (
  border-color: eastern,
  title-color: eastern.lighten(30%),
  body-color: eastern.lighten(95%),
  footer-color: eastern.lighten(80%)
)

#page(
)[
  #align(horizon)[
    "正则语言" 的大陆:
    1. 文法 (Grammar) 建造了大陆上的景观
    2. 机器 (The Acceptor): DFA $<==>$ NFA;  代数 (The Descriptor): 正则表达式. 它们是大陆上的交通工具
    3. 泵引理 (Pumping Lemma): 大陆上的自然法则, 确定了大陆的边界
  ]
]

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

#showybox(
  title: "SVD 的意义",
  frame: frameSettingsEastern,
)[
  SVD 的本质是 *分解*. 它告诉我们任何复杂的线性变换 $A$ 都可以被拆分成三步:
  1. 一次旋转 (由 $V^T$ 描述),
  2. 一次沿着坐标轴的缩放 (由 $Sigma$ 描述, 缩放因子为奇异值),
  3. 再一次旋转 (由 $U$ 描述).
]

=== 分解方法 
1. 计算 $A^T A$ 和 $A A^T$ 的特征值和特征向量. 
2. 设 $A^T A$ 的特征值为 $lambda_1 \, lambda_2 \, dots.h \, lambda_n$ (按降序排列), 则 $A$ 的奇异值为 $sigma_i = sqrt(lambda_i)$, $i = 1 \, 2 \, dots.h \, r$.
3. $V$ 的列向量为 $A^T A$ 的单位特征向量.

== 范数
=== 向量范数
若实值函数 $norm(dot.op) : bb(R)^n arrow.r bb(R)$
满足下列条件: 
1. 正定性: $norm(bold(x)) gt.eq 0$, $forall bold(x) in bb(R)^n$. $norm(x) = 0 arrow.l.r.double bold(x) = bold(0)$. 
2. 齐次性: $norm(alpha bold(x)) = lr(|alpha|) norm(bold(x))$, $forall a in bb(R)$, $bold(x) in bb(R)^n$. 
3. 三角不等式: $norm(bold(x) + bold(y)) lt.eq norm(bold(x)) + norm(bold(y))$, $forall bold(x) \, bold(y) in bb(R)^n$. 

则 $norm(dot.op)$ 为向量范数

定义 $L_p$ 范数为
$ norm(bold(x))_p = [sum_(j = 1)^n norm(bold(x)_j)^p]^(1 \/ p) \, quad 1 lt.eq p < oo $
特别地, 我们有 $norm(bold(x))_oo = max_j lr(|x_j|)$.

=== 矩阵范数
==== 定义
若实值函数
$norm(dot.op) : bb(R)^(m times n) arrow.r bb(R)$
满足下列条件: 
1. 正定性: $norm(A) gt.eq 0$, $forall A in bb(R)^(m times n)$. $norm(A) = 0 arrow.l.r.double A = 0$. 
2. 齐次性: $norm(alpha A) = lr(|alpha|) norm(A)$, $forall a in bb(R)$, $A in bb(R)^(m times n)$. 
3. 三角不等式: $norm(A + B) lt.eq norm(A) + norm(B)$, $forall A \, B in bb(R)^(m times n)$.

则 $norm(dot.op)$ 为矩阵范数

==== 一些常见的矩阵范数
- Frobenius 范数:
  $ norm(A)_F = [sum_(i = 1)^m sum_(j = 1)^n a_(i j)^2]^(1 \/ 2) $

- 核范数 (Nuclear norm):
  $ norm(A)_(*) = sum_(i = 1)^r sigma_i $ 其中
  $sigma_i$ 为 $A$ 的奇异值, $r = min { m \, n }$. 或者我们也可以定义
  $sigma_i$ 为 $A$ 的非零奇异值, $r = upright("rank") \( A \)$.

- 谱范数 (Spectral norm):
  $ norm(A)_2 = sigma_1 = max_(bold(x) eq.not 0) frac(norm(A bold(x))_2, norm(bold(x))_2) $
  其中 $sigma_1$ 为 $A$ 的最大奇异值.
  
  
#showybox(
  title: "矩阵范数的直观图像",
  frame: frameSettings,
)[
  1. *Frobenius 范数*: 相当于把一个矩阵拉直为一个向量后, 计算该向量的 $L_2$ 范数. 它衡量了矩阵中所有元素的整体大小, 所以常用来做深度学习损失函数的正则化项.

  2. *谱范数*: 一个矩阵作用于一个单位球体, 会将其变形为一个椭球体. 该椭球体的长轴长度就是矩阵的谱范数, 谱范数衡量了矩阵在某个方向上的最大伸缩能力. 这是因为谱范数等于矩阵的最大奇异值, 而奇异值描述了矩阵在不同的特征方向上的伸缩比例.

  3. *核范数*: 同样是将单位球体变换为椭球体, 核范数是这个椭球体所有半轴的长度之和. 这可以被看作是矩阵变换后产生的椭球体 "尺寸" 的一种度量. 它可以被看作是矩阵的秩的一个凸近似 (通过最小化核范数, 我们通常可以有效地找到一个低秩的矩阵), 衡量了矩阵中包含信息的复杂程度.
]

==== 矩阵内积
矩阵 $A \, B in bb(R)^(m times n)$ 的内积定义为
$ angle.l A \, B angle.r = upright("Tr") \( A^T B \) = sum_(i = 1)^m sum_(j = 1)^n a_(i j) b_(i j) $

我们有 Cauchy-Schwarz 不等式:
$ angle.l A \, B angle.r lt.eq norm(A)_F norm(B)_F $

== 酉矩阵和酉不变性
=== 酉矩阵
设 $U in bb(C)^(n times n)$, 如果 $U$ 满足 $U^(*) U = U U^(*) = I$, 则称
$U$ 为 #strong[酉矩阵 (Unitary Matrix)];. 这里 $U^(*)$ 为 $U$
的共轭转置, 即先对 $U$ 中的每个元素取共轭, 再转置.

特别地, 在实数域上, 酉矩阵称为 #strong[正交矩阵 (Orthogonal Matrix)];,
即 $Q^T Q = Q Q^T = I$.

酉矩阵就是一种保持向量长度和角度的线性变换, 它就是复数空间中的旋转和反射变换. 如果某个对矩阵/向量的度量在旋转和反射变换下是不变的, 那么这个度量就是酉不变的.

=== 酉不变性
矩阵范数 $norm(dot.op)$ 如果满足
$ norm(U A V) = norm(A) \, quad forall U in bb(C)^(m times m) \, V in bb(C)^(n times n) upright(" 为酉矩阵") . $
则称 $norm(dot.op)$ 为 #strong[酉不变 (Unitary
Invariant)] 的.

向量的 $ell_2$ 范数和矩阵的 Frobenius 范数均为酉不变的 (因为旋转和反射不会改变向量的长度).

有一个比较重要的性质是, 矩阵 $F$ 范数的平方等于矩阵奇异值的平方和:
$
norm(A)_F^2 = sum_(i = 1)^r sigma_i^2 
$
这是 $F$ 范数的酉不变性的直接结果. 在一个固定的坐标系下, 我们总可以通过旋转变换把矩阵 $A$ 转化为一个对角矩阵 (即其奇异值矩阵 $Sigma$), 这样计算 $F$ 范数就变得非常简单. 
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
$ norm(R_(upright("emp")) \( hat(h)_(cal(H)) \) - R^(*)) &lt.eq underbrace(R_(upright("emp")) \( hat(h)_(cal(H)) \) - R_(upright("exp")) \( h_(cal(H))^(*) \), #[估计误差]) + underbrace(R_(upright("exp")) \( h_(cal(H))^(*) \) - R^(*), #[近似误差])  \ &< epsilon \( delta \, beta \, N \) + #[近似误差] $

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
2. 如果存在某个 $x in cal(X) inter B \( macron(x) \, epsilon.alt \)$ 成立, 其中 $B \( macron(x) \, epsilon.alt \) = { x in bb(R)^n : norm(x - macron(x)) < epsilon.alt }$, 则称 $macron(x)$ 为 #strong[局部极小解 (Local Minimum)];. 
3. 进一步地, 如果 $f \( macron(x) \) < f \( x \)$ 对于所有 $x in cal(X) inter B \( macron(x) \, epsilon.alt \)$ 且 $x eq.not macron(x)$ 成立, 则称 $macron(x)$ 为 #strong[严格局部极小解 (Strict Local Minimum)];. 
4. 如果一个点是局部极小解, 但不是严格局部极小解, 则称其为 #strong[非严格局部极小解 (Non-strict Local Minimum)];.

=== 优化算法的收敛性
对于实际的最优化问题, 我们常使用 #strong[迭代法 (Iterative Method)]
来求解. 设 ${ x^k }$ 为算法产生的迭代序列, 如果在某种范数
$norm(dot.op)$ 下, 对于某个局部 (或全局) 最优解
$x^(*)$, 有
$lim_(k arrow.r oo) norm(x^k - x^(*)) = 0$,
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
$ norm(x^(k + 1) - x^(*)) lt.eq mu norm(x^k - x^(*)) $
\2. 算法 (点列) $cal(Q)$-超线性收敛 (Q-superlinear Convergence):
$ lim_(k arrow.r oo) frac(norm(x^(k + 1) - x^(*)), norm(x^k - x^(*))) = 0 $
\3. 算法 (点列) $cal(Q)$-次线性收敛 (Q-sublinear Convergence):
$ lim_(k arrow.r oo) frac(norm(x^(k + 1) - x^(*)), norm(x^k - x^(*))) = 1 $
这里超线性收敛速度最快, 次线性收敛速度最慢, 分别是线性收敛的两个极端.

#block[
#set enum(numbering: "1.", start: 4)
+ 算法 (点列) $cal(Q)$-二次收敛 (Q-quadratic Convergence): 存在

+ 算法 (点列) $cal(R)$-线性收敛 (R-linear Convergence): 存在一个
  $cal(Q)$-线性收敛到 0 的非负数列 ${ v_k }$, 使得对于所有
  $k gt.eq k_0$, 有 $ norm(x^k - x^(*)) lt.eq v_k $
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
$ frac(f \( x^k \) - f \( x^(*) \), max { \| f \( x^(*) \) \| \, 1 }) < epsilon.alt_1 \, quad norm(nabla f \( x^k \)) < epsilon.alt_2 $
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
$ R_(upright("emp")) \( bold(theta) \) = 1 / N norm(tilde(X) bold(theta) - bold(y))_2^2 $
最优化问题就为 $min_(bold(theta)) R_(upright("emp")) \( bold(theta) \)$.
这个问题有解析解
$ bold(theta)^(*) = \( tilde(X)^T tilde(X) \)^(- 1) tilde(X)^T bold(y) $
==== 岭回归 
岭回归 (Ridge Regression) 是在最小二乘法的基础上, 引入
$L_2$ 正则化项以防止过拟合. 岭回归的目标函数为
$ R_(upright("ridge")) \( bold(theta) \) = norm(tilde(X) bold(theta) - bold(y))_2^2 + lambda norm(bold(theta))_2^2 $
$ bold(theta)^(*) = \( tilde(X)^T tilde(X) + lambda I \)^(- 1) tilde(X)^T bold(y) $

#strong[岭回归的几何解释];: 岭回归的最优化问题
$ min_(bold(theta)) norm(tilde(X) bold(theta) - bold(y))_2^2 + lambda norm(bold(theta))_2^2 $
等价于约束最优化问题
$ min_(bold(theta)) quad & norm(tilde(X) bold(theta) - bold(y))_2^2\
upright("s.t.") quad & norm(bold(theta))_2^2 lt.eq t $
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
$ \( ell_p \) : min norm(x)_p\
upright("s.t.") quad A x = b \, quad p = 0 \, 1 \, 2 \, dots.h $ 当
$p = 0$ 时, $norm(x)_0$ 表示 $x$ 中非零元素的个数, 该问题称为 #strong[$ell_0$ 优化问题];. 该问题是 NP-hard 的, $norm(x)_0$ 的取值只能为整数, 不能使用常规的最优化方法. 同时需要注意的是, $ell_1$ 和 $ell_2$ 的解也不一定相同.

#strong[LASSO 问题];: 考虑带 $ell_1$ 正则化的最小二乘问题, 即
$ min_x norm(A x - b)_2^2 + lambda norm(x)_1 $
该问题称为 LASSO (Least Absolute Shrinkage and Selection Operator) 问题,
该问题可以被看作是 $ell_1$ 优化问题的一个变种. 通过调整正则化参数
$lambda$, 可以控制解的稀疏性.

==== 回归分析
考虑线性模型 $b = A x + epsilon.alt$, 假设
$epsilon.alt tilde.op cal(N) \( 0 \, sigma^2 I \)$, 则我们可以得到给定
$A$ 和 $x$ 时, 观测值 $b$ 的条件概率分布为
$ p \( b divides A \, x \) = frac(1, \( 2 pi \)^(m \/ 2) sigma^m) exp (- frac(1, 2 sigma^2) norm(A x - b)_2^2) $
我们希望估计一个最优的 $x$ 使得观测值 $b$ 出现的概率最大,
即最大化对数似然函数
$ max_x log p \( b divides A \, x \) = max_x - frac(1, 2 sigma^2) norm(A x - b)_2^2 + upright("const") $

可以看到这个最优化问题等价于最小化 $norm(A x - b)_2^2$,
这就是最小二乘法. 也就是说, #strong[当假设误差是高斯白噪声时,
最小二乘解就是线性回归模型的最大似然解];.

#strong[Tikhonov 正则化];: 为了平衡数据拟合和模型复杂度,
我们可以引入正则化项, 得到 Tikhonov 正则化问题
$ min_x norm(A x - b)_2^2 + lambda norm(x)_2^2 $

这就类似于最小二乘法中的岭回归. 由于正则项的存在,
该问题的目标函数为强凸函数, 解的性质得到改善

#strong[LASSO 问题及其变形] 另一方面, 如果希望解 $x$ 是稀疏的, 可以添加
$ell_1$ 正则化项, 得到 LASSO 问题
$ min_x norm(A x - b)_2^2 + lambda norm(x)_1 $
也可以考虑问题
$ min_x norm(A x - b)_2^2 \, quad upright("s.t.") quad norm(x)_1 lt.eq t $
考虑到噪声 $epsilon.alt$ 的存在, 我们可以将约束条件改为
$norm(A x - b)_2^2 lt.eq nu$, 这样就得到了一个等价的优化问题
$ min_x norm(x)_1 \, quad upright("s.t.") quad norm(A x - b)_2^2 lt.eq nu $
如果参数 $x$ 具有 #strong[分组稀疏性] (Group Sparsity), 即 $x$
的分量可分为 $G$ 个组, 每个组内的参数必须同时为零或同时非零,
为此人们提出了 #strong[分组 LASSO 问题];:
$ min_x norm(A x - b)_2^2 + mu sum_(g = 1)^G sqrt(n_g) norm(x_(cal(I)_g))_2 $
其中 $cal(I)_g$ 是第 $g$ 个组的索引, 且
$ n_g = lr(|cal(I)_g|) \, quad sum_(g = 1)^G n_g = n $
这里的正则项也可以被看做是 $norm(x_(cal(I)_g))_2$ 的
$ell_1$ 范数, 也就是对每个组的 $ell_2$ 范数求和. 分组 LASSO
问题把稀疏性从单个特征提升到了组的级别上，但不要求组内的稀疏性.

如果需要同时保证分组以及单个特征的稀疏性, 可以考虑将两种正则项结合起来,
即有稀疏分组 LASSO 模型
$ min_x norm(A x - b)_2^2 + mu sum_(g = 1)^G sqrt(n_g) norm(x_(cal(I)_g))_2 + lambda norm(x)_1 $

当特征 $x$ 本身不稀疏但在某种变换下是稀疏的, 则需调整正则项
$ min_x norm(A x - b)_2^2 + lambda norm(F x)_1 $
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
$ R_(upright("emp")) \( bold(w) \) = sum_(i = 1)^N log \( 1 + e^(- y_i bold(w)^T bold(x)_i) \) + lambda norm(bold(w))_2^2 $

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
$ norm(X)_(*) = sum_(i = 1)^(min \( m \, n \)) sigma_i \( X \) $
其中 $sigma_i \( X \)$ 是矩阵 $X$ 的奇异值. 由于核范数是一个凸函数,
因此我们可以将上述问题转化为
$ min_(X in bb(R)^(m times n)) norm(X)_(*) quad upright("s.t.") quad X_(i j) = M_(i j) \, quad \( i \, j \) in Sigma $
\
考虑到观测可能出现误差, 我们可以给出该问题的二次罚函数形式
$ min_(X in bb(R)^(m times n)) norm(X)_(*) + lambda sum_(\( i \, j \) in Sigma) \( X_(i j) - M_(i j) \)^2 $
又考虑到低秩矩阵可以被分解 $X = L R^T$, 其中 $L in bb(R)^(m times r)$,
$R in bb(R)^(n times r)$, $r lt.double min \( m \, n \)$ 是矩阵的秩,
因此我们可以将问题转化为
$ min_(L in bb(R)^(m times r) \, R in bb(R)^(n times r)) sum_(\( i \, j \) in Sigma) \( L_i^T R_j - M_(i j) \)^2 + alpha norm(L)_F^2 + beta norm(R)_F^2 $
这里 $norm(L)_F$ 和 $norm(R)_F$ 分别是矩阵 $L$
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

#showybox(
  title: "仿射集是平移后的线性子空间",
  frame: frameSettings,
)[
  $C$ 是仿射集, 则存在某个点 $x_0 in bb(R)^n$ 和某个线性子空间 $cal(V)$, 使得
  $
    C = x_0 + cal(V) = { x_0 + v | v in cal(V) } 
  $
]

=== 凸集的性质
+ 如果 $cal(S)$ 是凸集, 则
  $k cal(S) = { k x divides x in cal(S) \, thin k in bb(R) }$ 也是凸集.
+ 如果 $cal(S)$ 和 $cal(T)$ 都是凸集, 则
  $cal(S) + cal(T) = { x + y divides x in cal(S) \, y in cal(T) }$
  也是凸集.
+ 如果 $cal(S)$ 和 $cal(T)$ 都是凸集, 则 $cal(S) sect cal(T)$ 也是凸集.
+ 凸集的内部 (Interior) 和闭包 (Closure) 也是凸集. 这里
  - 内部定义为 $"int" \( cal(C) \) = { x in cal(C) : exists r gt.double 0 \,  "s.t."  B \( x \, r \) subset.eq cal(C) }$,
    其中
    $B \( x \, r \) = { y in bb(R)^n : norm(y - x) < r }$.
  - 闭包定义为
    $upright("cl") \( cal(C) \) = cal(C) union { x : x "is the limit point of" cal(C) }$.

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
$ cal(B) = { x in bb(R)^n : norm(x - x_c) lt.eq r } $
$norm(dot.op)$ 为某种范数. 范数球是凸集.

#strong[椭球 (Ellipsoid)] 是指形如
$ cal(E) = { x in bb(R)^n : \( x - x_c \)^T P^(- 1) \( x - x_c \) lt.eq 1 } $
的集合, 其中 $x_c in bb(R)^n$ 为椭球心, $P in bb(R)^(n times n)$
为对称正定矩阵. 椭球是凸集.

椭球也可以被表示为
$ cal(E) = { x_c + A u : norm(u)_2 lt.eq 1 } $ 其中
$A in bb(R)^(n times n)$ 满足 $P = A A^T$. 这里的 $A$
可以被看做是将单位球映射到椭球的线性变换矩阵.

=== 范数锥
#strong[范数锥 (Norm Cone)] 是指形如
$ cal(K) = { \( x \, t \) in bb(R)^(n + 1) : norm(x) lt.eq t \, thin t gt.eq 0 } $
的集合, 其中 $norm(dot.op)$ 为某种范数. 范数锥是凸锥.
特别地, 用 $ell_2$ 范数定义的范数锥称为 #strong[二次锥]

=== 特殊矩阵集合和 (半) 正定锥
- #strong[对称矩阵集合];: 设 $cal(S)^n$ 表示所有 $n times n$
  实对称矩阵的集合, 即
  $ cal(S)^n = { X in bb(R)^(n times n) : X = X^T } $

- #strong[半正定矩阵集合];: 设 $cal(S)_(+)^n$ 表示所有 $n times n$
  实对称半正定矩阵的集合, 即
  $ cal(S)_(+)^n = { X in cal(S)^n : X succ.curly.eq 0 } $

这里 $X succ.curly.eq 0$ 表示矩阵 $X$ 是半正定的, 即对于任意非零向量
$z in bb(R)^n$, 有 $z^T X z gt.eq 0$. 

我们一般称 $cal(S)_(+)^n$ 为 #strong[半正定锥 (Positive Semidefinite Cone)];, 它是一个凸锥.
#showybox(
  title: "对称矩阵的半正定序",
  frame: frameSettings,
  // footer: "Information extracted from a well-known public encyclopedia"
)[
  对称矩阵 $X \, Y in cal(S)^n$ 的 *半正定序 (Semidefinite Ordering)* 定义为
  $ X succ.curly.eq Y quad <==> quad X - Y "is positive semidefinite" $
  可以证明这是一个偏序 (Partial Order), 即对于任意 $X \, Y \, Z in cal(S)^n$, 有
  - $X succ.curly.eq X$ (自反性)
  - 如果 $X succ.curly.eq Y$ 且 $Y succ.curly.eq X$, 则 $X = Y$ (反对称性)
  - 如果 $X succ.curly.eq Y$ 且 $Y succ.curly.eq Z$, 则 $X succ.curly.eq Z$ (传递性)
]


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

*例子*:
1. 线性矩阵不等式的解集
$
  {x | x_1A_1 + x_2A_2 + dots.h.c + x_m A_m prec.curly.eq B}
$
当 $A_i \, B in cal(S)^m$ 时, 是凸集. 这可以直接由仿射变换的保凸性得到.

2. 双曲锥
$
  {x | x^T P x lt.eq (c^T x)^2 , c^T x gt.eq 0}
$
当 $P in cal(S)_(+)^n$ 时, 是凸锥. 这是因为双曲锥可以转化为二阶锥
$
  {x | norm(A x)_2 lt.eq c^T x , c^T x gt.eq 0, A^T A = P}
$
而二阶锥又可以通过二次锥 ${(x, t) | norm(x)_2 lt.eq t , t gt.eq 0}$ 通过仿射变换得到.

=== 透视变换和分式线性变换的保凸性
- *透视变换* $P : bb(R)^(n + 1) -> bb(R)^(n)$ 定义为:
$
  P \( z \) = P \( \( x \, t \) \) = frac(x, t) , quad "dom" P = { \( x \, t \) : t gt.eq 0 }
$
这里 $"dom" P$ 表示 $P$ 的定义域. 透视变换下凸集的像和原像都是凸集.

- *分式线性变换* $f : bb(R)^n -> bb(R)^m$ 定义为:
$
  f \( x \) = frac(A x + b, c^T x + d) , quad "dom" f = { x : c^T x + d gt.eq 0 }
$
分式线性变换下凸集的像和原像都是凸集.

== 广义不等式与对偶锥
=== 适当锥
<proper-cone>
我们知道锥是凸集, 一个凸锥 $K subset RR^n$ 是适当锥, 当其还满足
1. $K$ 是闭集
2. $K$ 是实心的, 即 $"int" K eq.not emptyset$
3. $K$ 是尖的, 即内部不包含直线, 即如果 $x in K$ 且 $- x in K$, 则 $x = 0$.


#showybox(
  title: "闭集和内部",
  frame: frameSettings,
)[
  - 集合 $cal(C)$ 是 *闭集*, 如果对于任意收敛到 $x$ 的点列 ${ x_k }$,
    $ forall k, x_k in cal(C) ==> x in cal(C). $
  - 集合 $cal(C)$ 的 *内部* 定义为
    $ "int" cal(C) = { x in cal(C) : quad exists r gt 0 , B \( x \, r \) subset.eq cal(C) } $
    这里 $B \( x \, r \) = { y in bb(R)^n : norm(y - x) < r }$.
]

适当锥的例子有:
1. 非负卦限 $bb(R)_+^n = { x in bb(R)^n : x_i gt.eq 0 \, i = 1 \, 2 \, dots.h \, n }$
2. 半正定锥 $K in cal(S)_(+)^n$
3. $[0, 1]$ 上的有限非负多项式
$
  { p \( t \) = sum_(i = 0)^n p_i t^i |  p \( t \) gt.eq 0 , quad forall t in \[ 0 \, 1 \] }
$

=== 广义不等式
<generalized-inequality>
广义不等式是一种偏序 (不必要保证所有对象都具有可比较性), 可以使用适当锥诱导. 对于适当锥 $K subset RR^n$, 定义广义不等式
$ 
x lt.eq_K y quad <==> quad y - x in K 
$
严格广义不等式定义为
$
x lt._K y quad <==> quad y - x in "int" K
$

*例子* 坐标分量不等式: $ x lt.eq_(RR_+^n) y quad <==> quad x_i lt.eq y_i \, i = 1 \, 2 \, dots.h \, n $

*性质*
1. 自反性: $x lt.eq_K x$
2. 反对称性: 如果 $x lt.eq_K y$ 且 $y lt.eq_K x$, 则 $x = y$
3. 传递性: 如果 $x lt.eq_K y$ 且 $y lt.eq_K z$, 则 $x lt.eq_K z$
4. 保持加法: 如果 $x lt.eq_K y$, 则 $x + z lt.eq_K y + z$
5. 保持非负数乘法: 如果 $x lt.eq_K y$ 且 $alpha gt.eq 0$, 则 $alpha x lt.eq_K alpha y$

=== 对偶锥
<dual-cone>
令锥 $K subset Omega$, 则 $K$ 的对偶锥定义为
$
K^* = { y in Omega : angle.l x, y angle.r gt.eq 0 , quad forall x in K }
$

对偶锥是相对于锥 $K$ 定义的, 我们把对偶锥为自身的锥称为 *自对偶锥 (Self-dual Cone)*.

*例子*
1. 非负卦限 $bb(R)_+^n$ 是自对偶锥. 这是显然的.
2. 半正定锥 $cal(S)_(+)^n$ 是自对偶锥.

#showybox(
  title: "证明: 半正定锥是自对偶锥",
  frame: frameSettings,
  footer: [注: 对于 $X in cal(S)_(+)^n$, 可分解为 $X = Q Lambda Q^T$, 其中 $Lambda = "diag"(lambda_1, ..., lambda_n)$. 由此我们可以定义 $X^(1/2) = Q Lambda^(1/2) Q^T in cal(S)_(+)^n$]
)[
  第一步, 证明 $cal(S)_(+)^n subset.eq (cal(S)_(+)^n)^*$. 对任意 $X in cal(S)_(+)^n$ 和 $Y in cal(S)_(+)^n$, 有 $angle.l X, Y angle.r = tr \( X Y \) = tr \( Y^(1 \/ 2) X Y^(1 \/ 2) \) gt.eq 0$. (利用迹的循环不变性);

  第二步, 证明 $(cal(S)_(+)^n)^* subset.eq cal(S)_(+)^n$. 设 $Z in (cal(S)_(+)^n)^*$, 则对于任意 $Y in cal(S)_(+)^n$, 有 $angle.l Z, Y angle.r = tr \( Z Y \) gt.eq 0$. 假设 $Z in.not cal(S)_(+)^n$, 则存在 $u in bb(R)^n$ 使得 $u^T Z u lt 0$. 令 $Y = u u^T$, 则 $Y in cal(S)_(+)^n$, 但 $angle.l Z, Y angle.r = tr \( Z u u^T \) = u^T Z u lt 0$, 矛盾. 因此, $Z in cal(S)_(+)^n$.
]

3. 锥 $K = {(x, t) | norm(x)_p lt.eq t , t gt.eq 0, p >= 1}$ 的对偶锥为 $ K^* = {(y, s) | norm(y)_q lt.eq s , s gt.eq 0, (p, q) "are dual"}. $ 因此二次锥 ($p = 2$) 是自对偶锥.


#showybox(
  title: "对偶范数",
  frame: frameSettings,
)[
  设 $norm(dot.op)$ 是 $bb(R)^n$ 上的某种范数, 则其 *对偶范数* 定义为
  $
  norm(y)_(*) = sup_(norm(x) lt.eq 1) angle.l x, y angle.r = sup_(norm(x) lt.eq 1) x^T y
  $
 这里的 $y$ 定义在原范数的对偶空间中, 对于 $bb(R)^n$ 来说, 对偶空间仍然是 $bb(R)^n$.

 *Hölder 不等式* 给出了范数与其对偶范数之间的关系:
  $ 
  angle.l x, y angle.r lt.eq norm(x) norm(y)_(*)
  $

 特别地, 对于 $ell_p$ 范数, 其对偶范数为 $ell_q$ 范数, 其中 $frac(1, p) + frac(1, q) = 1$. 这是 Hölder 不等式的一个推论
 $
  angle.l x, y angle.r lt.eq norm(x)_p norm(y)_q, quad frac(1, p) + frac(1, q) = 1
 $
]

=== 对偶锥的性质
设 $K$ 是一个锥, $K^*$ 是其对偶锥, 则
1. $K^*$ 是锥
2. $K^*$ 是闭集, 且是凸集
3. 若 $"int" K^* eq.not emptyset$, 则 $K^*$ 是尖的, 即内部不含有直线
4. 若 $K$ 的闭包是尖的, 则 $K^*$ 是实心的, 即 $"int" K^* eq.not emptyset$
5. 若 $K$ 是适当锥, 则 $K^*$ 也是适当锥
6. $K^(**)$ 是 $K$ 的凸包. 特别地, 若 $K$ 是凸且闭的, 则 $K^(**) = K$.

=== 对偶锥诱导的广义不等式
既然适当锥的对偶锥仍是适当锥, 则可以使用对偶锥诱导广义不等式. 设 $K$ 是适当锥, 则 $K^*$ 诱导的广义不等式定义为
$ 
x lt.eq_(K^*) y quad <==> quad y - x in K^*
$
使用对偶广义不等式的好处是, 对偶锥始终是闭且凸的, 并可将一个偏序问题转换为满足一个偏序条件的全序问题.

== 分离超平面定理
=== 定理陈述
超平面是空间中一类特殊的凸集, 可以证明 $RR^n$ 空间中的超平面恰好是 $n - 1$ 维的. 我们可以用超平面分离不相交的凸集:

如果 $cal(C)$ 和 $cal(D)$ 是不相交的凸集, 则存在超平面将它们分开 (*软划分*), 即存在一个线性函数 $f(x) = a^T x + b$ 使得
$
  f(x) cases(
    <= 0 & quad forall x in cal(C) \
    >= 0 & quad forall x in cal(D)
  )
$

如果有任何一个集合不是凸集, 我们无法使用超平面对其划分, 而必须使用更加复杂的平面. 这就给划分问题带来了巨大的挑战.
=== 严格分离定理
如果 $cal(C)$ 和 $cal(D)$ 是不相交的凸集, 且 $cal(C)$ 是闭集, $cal(D)$ 是紧集, 则存在超平面将它们严格分开 (*硬划分*), 即存在一个线性函数 $f(x) = a^T x + b$ 使得
$
  f(x) cases(
    < 0 & quad forall x in cal(C) \
    > 0 & quad forall x in cal(D)
  )
$
该定理的退化形式即 $cal(D)$ 退化为单点集 $x_0$, 则存在超平面将 $x_0$ 与闭凸集 $cal(C)$ 严格分开.

=== 支撑超平面
上述严格分离定理的退化形式要求 $x_0 in.not cal(C)$. 而当 $x_0$ 恰好落在 $cal(C)$ 的边界上时, 我们可以构造超平面:

给定集合 $cal(C)$ 以及其边界上的点 $x_0$, 如果 $a != 0$ 满足对 $forall x in cal(C)$, 有 $a^T x <= a^T x_0$, 那么称集合
$
  cal(H) = { x : a^T x = a^T x_0 }
$
为 $cal(C)$ 在点 $x_0$ 处的 *支撑超平面*. 

=== 支撑超平面定理
如果 $cal(C)$ 是凸集, 则对于 $cal(C)$ 边界上的任意点 $x_0$, 都存在支撑超平面.

== 凸函数的数学准备
=== 梯度
给定函数 $f: RR^n -> RR$, 且 $f$ 在 $x$ 的一个邻域内有意义, 若存在向量 $g in RR^n$ 满足
$
  lim_(p -> 0) (f(x + p) - f(x) - g^T p)/(norm(p)) = 0
$
其中 $norm(dot.op)$ 是某种范数, 则称 $f$ 在点 $x$ 处是 *Fréchet 可微*, 向量 $g$ 称为 $f$ 在点 $x$ 处的 *梯度*, 记为 $nabla f(x)$.

特别地, 若我们把 $p$ 写成 $p = t bold(u)_i$, 其中 $t in RR$ 是标量, $bold(u)_i in RR^n$ 是单位向量, 则有
$
  nabla f(x)^T bold(u)_i = lim_(t -> 0) (f(x + t bold(u)_i) - f(x))/t = (partial f(x))/(partial x_i)
$
从而
$
  nabla f(x) = [(partial f(x))/(partial x_1) , (partial f(x))/(partial x_2) , dots.h.c , (partial f(x))/(partial x_n)]^T.
$

=== Hessian 矩阵
<hessian-matrix>
如果函数 $f(x): RR^n -> RR$ 在点 $x$ 处是 Fréchet 可微的, 且其梯度 $nabla f(x)$ 在点 $x$ 处也是 Fréchet 可微的, 则称 $f$ 在点 $x$ 处是 *二阶 Fréchet 可微*, 此时定义 $f$ 在点 $x$ 处的 *Hessian 矩阵* 为
$
nabla^2 f(x) =
mat(delim: "[", (diff^2 f(x))/(diff x_1^2), (diff^2 f(x))/(diff x_1 diff x_2), (diff^2 f(x))/(diff x_1 diff x_3), dots.c, (diff^2 f(x))/(diff x_1 diff x_n);
(diff^2 f(x))/(diff x_2 diff x_1), (diff^2 f(x))/(diff x_2^2), (diff^2 f(x))/(diff x_2 diff x_3), dots.c, (diff^2 f(x))/(diff x_2 diff x_n);
dots.v, dots.v, dots.v, dots.down, dots.v;
(diff^2 f(x))/(diff x_n diff x_1), (diff^2 f(x))/(diff x_n diff x_2), (diff^2 f(x))/(diff x_n diff x_3), dots.c, (diff^2 f(x))/(diff x_n^2)).
$
若 $nabla^2 f(x)$ 在 $D$ 的每一点都存在, 则称 $f$ 在 $D$ 上是二阶 Fréchet 可微的. 如果 $nabla^2 f(x)$ 还在 $D$ 上连续, 则称 $f$ 在 $D$ 上是二阶连续 Fréchet 可微的, 此时可以证明 Hessian 矩阵是对称的, 即 $nabla^2 f(x) = (nabla^2 f(x))^T$.

=== 矩阵变量函数的导数
多元函数梯度的定义可以推广到变量是矩阵的情形, 对于 函数 $f: RR^(m times n) -> RR$, 若存在矩阵 $G in RR^(m times n)$ 满足
$
  lim_(norm(V) -> 0) (f(X + P) - f(X) - angle.l G, V angle.r )/(norm(V)) = 0,
$
其中 $norm(dot.op)$ 是某种矩阵范数, $angle.l A, B angle.r = tr(A^T B)$, 则称 $f$ 在点 $X$ 处是 *Fréchet 可微*, 矩阵 $G$ 称为 $f$ 在点 $X$ 处的 *梯度*, 记为 $nabla f(X)$. 令 $x_(i j)$ 为矩阵 $X$ 的第 $i$ 行第 $j$ 列元素, 则
$
  (nabla f(X))_(i j) = (partial f(X))/(partial x_(i j)).
$

在实际应用中, 矩阵 Fréchet 可微的概念并不常用, 我们需要介绍另一种定义, 即 Gâteaux 可微. 对于函数 $f: RR^(m times n) -> RR$, 若存在矩阵 $G in RR^(m times n)$ 满足
$
  lim_(t -> 0) (f(X + t V) - f(X))/t = angle.l G, V angle.r , quad forall V in RR^(m times n)
$
则称 $f$ 在点 $X$ 处是 *Gâteaux 可微*, 矩阵 $G$ 称为 $f$ 在点 $X$ 处的 *梯度*, 记为 $nabla f(X)$. 这里 $V$ 可以被看做是 $X$ 的一个 *方向*.

可以证明, 如果 $f$ 在点 $X$ 处是 Fréchet 可微的, 则 $f$ 在点 $X$ 处也是 Gâteaux 可微的, 且两者的梯度相同. 反之, 如果 $f$ 在点 $X$ 处是 Gâteaux 可微的, 且 $nabla f(X)$ 在 $X$ 的某个邻域内连续, 则 $f$ 在点 $X$ 处也是 Fréchet 可微的, 且两者的梯度相同.

*矩阵变量函数的导数的例子*
1. 对于线性函数 $f(X) = tr(A X^T B)$, 其中 $A in RR^(p times m)$, $B in RR^(n times q)$, 有
$
  lim_(t -> 0) (f(X + t V) - f(X))/t = tr(A V^T B) = angle.l B A, V angle.r , quad forall V in RR^(m times n)
$
因此 $nabla f(X) = B A^T$.

2. 对于二次函数 $f(X) = 1/2 norm(X - A)_F^2 = 1/2 tr((X - A)(X - A)^T)$, 其中 $A in RR^(m times n)$. 取任意方向 $V$ 以及充分小的 $t in RR$, 有
$
  f(X + t V) - f(X) &= 1/2 tr((X + t V - A)(X + t V - A)^T) - 1/2 tr((X - A)(X - A)^T) \
  &= 1/2 tr(t^2 V V^T + t (X - A) V^T + t V (X - A)^T) \
  &= t tr((X - A) V^T) + cal(O)(t^2) \
  &= t angle.l X - A, V angle.r + cal(O)(t^2)
$
所以有 $nabla f(X) = X - A$.

=== 广义实值函数与适当函数
<proper-function>
令 $macron(RR) = RR union {plus.minus oo}$ 为广义实数空间, 则映射 $f: RR^n -> macron(RR)$ 称为 *广义实值函数*. 

给定广义实值函数 $f$ 和非空集合 $cal(X)$, 如果存在 $x in cal(X)$ 使得 $f(x) < + oo$, 并且对任意的 $x in cal(X)$, 都有 $f(x) > - oo$, 则称 $f$ 在 $cal(X)$ 上是 *适当的 (Proper)*.
概括来说, 适当函数 $f$ 的特点是 "至少有一处取值不为正无穷" 且 "处处取值不为负无穷".

=== 下水平集与上方图
对于广义实值函数 $f: RR^n -> macron(RR)$, 定义其 $alpha$-*下水平集 (Lower Level Set)* 为
$
  cal(C)_alpha = { x in RR^n : f(x) lt.eq alpha } 
$

对于广义实值函数 $f: RR^n -> macron(RR)$, 定义其 *上方图 (Epigraph)* 为
$
  "epi" f = { (x, t) in RR^(n + 1) : f(x) lt.eq t }
$

=== 闭函数
对于广义实值函数 $f: RR^n -> macron(RR)$, 如果其上方图是闭集, 则称 $f$ 在 $RR^n$ 上是 *闭函数 (Closed Function)*.

=== 下半连续函数
设广义实值函数 $f: RR^n -> macron(RR)$, 如果对于任意点 $x in RR$, 
$
  liminf_(y -> x) f(y) >= f(x)
$
则称 $f$ 在 $RR^n$ 上是 *下半连续 (Lower Semicontinuous)* 的. 这里 $liminf$ 表示下极限, 即
$  liminf_(y -> x) f(y) = lim_(epsilon -> 0^+) (inf_(norm(y - x) lt.eq epsilon) f(y)) $

设广义实值函数 $f: RR^n -> macron(RR)$, 则下列命题等价:
1. $f(x)$ 的任意 $alpha$-下水平集 $cal(C)_alpha$ 都是闭集
2. $f(x)$ 是下半连续的
3. $f(x)$ 是闭函数

== 凸函数的定义与性质
=== 凸函数的定义
设 $f: RR^n -> RR$ 为适当函数, 如果 $"dom" f$ 是凸集, 且
$
  f(theta x + (1 - theta) y) lt.eq theta f(x) + (1 - theta) f(y), quad forall x, y in "dom" f, quad forall theta in \[ 0 \, 1 \]
$
则称 $f$ 为 *凸函数 (Convex Function)*. 如果上述不等式中的 "$lt.eq$" 替换为 "$<$", 则称 $f$ 为 *严格凸函数 (Strictly Convex Function)*. 如果上述不等式中的 "$lt.eq$" 替换为 "$gt.eq$", 则称 $f$ 为 *凹函数 (Concave Function)*.

=== 一元凸函数的例子
- 仿射函数 $f(x) = a x + b$, 其中 $a, b in RR$.
- 指数函数 $f(x) = e^(a x)$, 其中 $a in RR$.
- 幂函数 $f(x) = x^a$, 其中 $a >= 1$ 或 $a <= 0$, 定义域为 $RR_+$.
- 绝对值的幂函数 $f(x) = |x|^a$, 其中 $a >= 1$ 或 $a <= 0$, 定义域为 $RR$.
- 负熵函数 $f(x) = x log x$, 定义域为 $RR_+$, 其中 $0 log 0 = 0$.

=== 多元凸函数的例子
欧式空间 $RR^n$ 中的例子:
- 仿射函数 $f(x) = a^T x + b$, 其中 $a in RR^n$, $b in RR$.
- $p$-范数函数 $f(x) = norm(x)_p$, 其中 $p >= 1$. 特别地, $p -> oo$ 时, $f(x) = max_i |x_i|$.

矩阵空间 $RR^(m times n)$ 中的例子:
- 仿射函数 $f(X) = tr(A X^T) + b = sum_(i = 1)^m sum_(j = 1)^n a_(i j) x_(i j) + b$, 其中 $A in RR^(m times n)$, $b in RR$.
- 谱范数函数 $f(X) = norm(X)_2 = sigma_max (X) = (lambda_max (X^T X))^(1/2)$, 其中 $sigma_max (X)$ 表示矩阵 $X$ 的最大奇异值, $lambda_max (X)$ 表示矩阵 $X$ 的最大特征值.

=== 强凸函数
<strongly-convex-function>
若存在常数 $m > 0$, 使得对于任意 $x, y in "dom" f$ 以及 $theta in \[ 0 \, 1 \]$, 有
$  f(theta x + (1 - theta) y) lt.eq theta f(x) + (1 - theta) f(y) - m / 2 theta (1 - theta) norm(x - y)^2 $
则称 $f$ 为 *强凸函数 (Strongly Convex Function)*, 其中 $norm(dot.op)$ 是某种范数.

也可以用另一个等价的定义: 若存在常数 $m > 0$, 使得 $f(x) - m / 2 norm(x)^2$ 是凸函数, 则称 $f$ 为强凸函数.

如果 $f$ 是强凸函数, 且存在最小值, 则该最小值唯一.

=== 凸函数判定定理
*降维法则*: $f: RR^n -> RR$ 是凸函数, 当且仅当对每个 $x in "dom" f$, $v in RR^n$, 函数
$
  g(t) = f(x + t v), quad "dom" g = { t : x + t v in "dom" f }
$
是关于 $t$ 的凸函数.

这个定理说明, 函数 $f$ 是凸函数, 当且仅当其在任意方向上的单变量函数都是凸函数.

*一阶条件*: 对于定义在凸集 $cal(C) subset RR^n$ 上的可微函数 $f: cal(C) -> RR$, $f$ 是凸函数, 当且仅当对于任意 $x, y in cal(C)$, 有
$
  f(y) >= f(x) + nabla f(x)^T (y - x)
$

这里的 $nabla f(x)$ 是 $f$ 在点 $x$ 处的梯度. 该条件说明, 函数 $f$ 在任意点处的切平面都在函数图像的下方.

*梯度单调性* : 对于定义在凸集 $cal(C) subset RR^n$ 上的可微函数 $f: cal(C) -> RR$, $f$ 是凸函数, 当且仅当对于任意 $x, y in cal(C)$, 有
$
  (nabla f(x) - nabla f(y))^T (x - y) gt.eq 0
$

即梯度是单调映射.

*上方图法则*: $f: RR^n -> RR$ 是凸函数, 当且仅当其上方图
$  "epi" f = { (x, t) in RR^(n + 1) : f(x) lt.eq t } $
是凸集.

*二阶条件*: 对于定义在开凸集 $cal(C) subset RR^n$ 上的二阶连续 Fréchet 可微函数 $f: cal(C) -> RR$, $f$ 是凸函数, 当且仅当对于任意 $x in cal(C)$, 其 Hessian 矩阵 $nabla^2 f(x)$ 是半正定的, 即
$
  nabla^2 f(x) succ.curly.eq 0
$
如果 $nabla^2 f(x)$ 是正定的, 即 $nabla^2 f(x) succ 0$, 则 $f$ 是严格凸函数. 从几何上看, 该条件说明函数 $f$ 的图像在任意点处都是 "向上弯曲" 的.

=== Jenson 不等式
设 $f: RR^n -> RR$ 是凸函数, 则对于任意 $x_1, x_2, dots.h.c, x_m in "dom" f$, 以及任意非负数 $theta_1, theta_2, dots.h.c, theta_m$ 满足 $sum_(i = 1)^m theta_i = 1$, 有
$  
  f(sum_(i = 1)^m theta_i x_i) lt.eq sum_(i = 1)^m theta_i f(x_i)
$
写成概率的形式, 即对于随机变量 $X$ 满足 $P(X = x_i) = theta_i$, 有
$
  f(bb(E)[X]) lt.eq bb(E)[f(X)]
$

== 保凸的运算
=== 非负加权和与仿射函数的复合
*非负加权*
设 $f_1, f_2, dots.h.c, f_m: RR^n -> RR$ 是凸函数, $theta_1, theta_2, dots.h.c, theta_m$ 是非负数, 则函数
$
  f(x) = sum_(i = 1)^m theta_i f_i (x)
$
是凸函数. 如果至少有一个 $f_i$ 是严格凸函数, 且对应的 $theta_i > 0$, 则 $f$ 是严格凸函数.

*仿射函数的复合*
设 $f: RR^m -> RR$ 是凸函数, $g: RR^n -> RR^m$ 是仿射函数, 即 $g(x) = A x + b$, 其中 $A in RR^(m times n)$, $b in RR^m$, 则函数
$
  h(x) = f(g(x)) = f(A x + b)
$
是凸函数. 

=== 逐点取最大值
设 $f_1, f_2, dots.h.c, f_m: RR^n -> RR$ 是凸函数, 则函数
$
  f(x) = max_(i = 1, dots.h.c, m) f_i (x)
$
是凸函数. 例如, $x in RR^n$ 的前 $k$ 大分量和函数
$
  f(x) = sum_(i = 1)^k x_( [i] ), quad x_( [1] ) >= x_( [2] ) >= dots.h.c >= x_( [n] )
$
是凸函数, 这是因为 $f(x)$ 可以写成 $f(x) = max_(S subset {1, dots.h.c, n}, |S| = k) sum_(i in S) x_i$ 的形式, 而 $sum_(i in S) x_i$ 是仿射函数.

=== 逐点取上界
若对于每个 $x in RR^n$, 函数族 ${ f(x, y) | y in cal(A) }$ 的上界存在, 且对于每个 $y in cal(A)$, $f(dot.c, y): RR^n -> RR$ 是凸函数, 则函数
$
  g(x) = sup_(y in cal(A)) f(x, y)
$
例如
- 集合 $cal(C)$ 到指定点 $x_0$ 的最远距离 $f(x) = sup_(y in cal(C)) norm(x - y)_2$ 是凸函数.
- 对称矩阵 $X in cal(S)^n$ 的最大特征值函数 $f(X) = lambda_max (X) = sup_(norm(v)_2 = 1) v^T X v$ 是凸函数.

#showybox(
  title: "矩阵最大特征值函数的推导",
  frame: frameSettings,
  // footer: "Information extracted from a well-known public encyclopedia"
)[
  设 $X in cal(S)^n$ 的特征值分解为 $X = Q Lambda Q^T$, 其中 $Lambda = "diag"(lambda_1, ..., lambda_n)$, $lambda_1 >= lambda_2 >= ... >= lambda_n$, 且根据谱定理, $Q$ 是正交矩阵. 令 $v = Q u$, 由于 $Q$ 是正交的 (i.e., $Q^T Q = I$), 则当 $norm(v)_2 = 1$ 时, 有 $norm(u)_2 = 1$. 因此
  $
    v^T X v = (Q u)^T (Q Lambda Q^T) (Q u) = u^T Lambda u = sum_(i = 1)^n lambda_i u_i^2
  $
  由于 $sum_(i = 1)^n u_i^2 = norm(u)_2^2 = 1$, 所以 $v^T X v$ 是 $lambda_i$ 的一个凸组合, 因此
  $
    v^T X v = sum_(i = 1)^n lambda_i u_i^2 lt.eq lambda_1 sum_(i = 1)^n u_i^2 = lambda_1 = lambda_max (X)
  $
  特别地, 当 $u = (1, 0, dots.h, 0)^T$, 即 $v$ 是 $X$ 的最大特征值对应的单位特征向量时, 上式取等号. 因此, $lambda_max (X) = sup_(norm(v)_2 = 1) v^T X v$.
]

=== 与标量函数的复合
给定函数 $g: RR^n -> R$ 和 $h: RR -> RR$, 则函数 $f: RR^n -> RR$ 定义为
$
  f(x) = h(g(x))
$
- 如果 $g$ 是凸函数, 且 $h$ 是凸且非减函数, 则 $f$ 是凸函数.
- 如果 $g$ 是凹函数, 且 $h$ 是凸且非增函数, 则 $f$ 是凸函数.

*推论*
- 如果 $g$ 是凸函数, 则 $f(x) = exp(g(x))$ 是凸函数.
- 如果 $g$ 是正值凸函数, 则 $f(x) = 1 / g(x)$ 是凸函数.

=== 与向量函数的复合
给定函数 $g: RR^n -> RR^m$ 和 $h: RR^m -> RR$, 则函数 $f: RR^n -> RR$ 定义为
$
  f(x) = h(g(x))
$
- 如果 $g_i (x)$ 是凸函数, $i = 1, dots.h, m$, 且 $h$ 是凸且非减函数, 则 $f$ 是凸函数.
- 如果 $g_i (x)$ 是凹函数, $i = 1, dots.h, m$, 且 $h$ 是凸且非增函数, 则 $f$ 是凸函数.

=== 取下确界
设 $cal(A)$ 是非空集合, 且对于每个 $y in cal(A)$, 函数 $f(x, y): RR^n -> RR$ 是凸函数, 则函数
$
  g(x) = inf_(y in cal(A)) f(x, y)
$
是凸函数.

例如
- $x in RR^n$ 到集合 $cal(C)$ 的距离函数 $f(x) = inf_(y in cal(C)) norm(x - y)_2$ 是凸函数.

=== 透视函数
定义 $f: RR^n -> RR$, 则其 *透视函数 (Perspective Function)* 定义为
$
  g(x, t) = t f(x / t), quad "dom" g = { (x, t) : t > 0, x / t in "dom" f }
$
如果 $f$ 是凸函数, 则 $g$ 是凸函数. 

例如, $f(x) = norm(x)_2^2$ 是凸函数, 则其透视函数
$
  g(x, t) = t (norm(x / t)_2^2) = (norm(x)_2^2) / t, quad "dom" g = { (x, t) : t > 0 }
$

另外, 考虑到 $f(x) = -log x$ 是凸函数, 则其透视函数
$
  g(x, t) = t (-log (x / t)) = t log t - t log x, quad "dom" g = { (x, t) : x > 0, t > 0 }
$
也就是 *相对熵函数 (Relative Entropy Function)* 是凸函数.
=== 共轭函数
<fenchel-conjugate>
适当函数 $f: RR^n -> macron(RR)$ 的 *Fenchel 共轭函数 (Fenchel Conjugate Function)* 定义为
$
  f^*(y) = sup_(x in RR^n) (y^T x - f(x))
$
无论 $f$ 是否是凸函数, 其共轭函数 $f^*$ 总是凸函数. 这是因为 $y^T x - f(x)$ 对于每一个固定的 $x$ 都是关于 $y$ 的仿射函数, 而 $f^*(y)$ 是这些仿射函数的上确界.

== 凸函数的推广
=== 拟凸函数
<quasi-convex-function>
设 $f: RR^n -> RR$, 如果 $"dom" f$ 是凸集, 且下水平集 $S_alpha = { x in RR^n : f(x) lt.eq alpha }$ 对于 任意 $alpha in RR$ 都是凸集, 则称 $f$ 为 *拟凸函数 (Quasi-Convex Function)*. 

若 $f$ 是拟凸函数, 则称 $-f$ 为 *拟凹函数 (Quasi-Concave Function)*. 如果 $f$ 既是拟凸函数, 又是拟凹函数, 则称 $f$ 为 *拟线性 (Quasi-Affine)* 的.

=== 拟凸函数的例子
*拟凸函数*
- $f(x) = sqrt(abs(x))$ 是 $RR$ 上的拟凸函数, 但不是凸函数.
- 距离比值函数 $f(x) = (norm(x - a)_2) / (norm(x - b)_2)$, $"dom" f = { x : norm(x - a)_2 <= norm(x - b)_2 }$ 是拟凸函数.

*拟凹函数*
- $f(x_1, x_2) = x_1 x_2$, $"dom" f = RR^2_+$ 是拟凹函数

*拟线性函数*
- $f(x) = ceil(x)$ 是 $RR$ 上的拟线性函数
- $f(x) = log(x)$ 是 $RR_+$ 上的拟线性函数
- 分式线性函数 $f(x) = (a^T x + b) / (c^T x + d)$, $"dom" f = { x : c^T x + d > 0 }$ 是拟线性函数

=== 拟凸函数的性质
*类 Jenson 不等式*: 设 $f: RR^n -> RR$ 是拟凸函数, 则对于任意 $x_1, x_2, dots.h.c, x_m in "dom" f$, 以及任意非负数 $theta_1, theta_2, dots.h.c, theta_m$ 满足 $sum_(i = 1)^m theta_i = 1$, 有
$
  f(sum_(i = 1)^m theta_i x_i) lt.eq max_(i = 1, dots.h.c, m) f(x_i)
$

*一阶条件*: 对于定义在凸集 $cal(C) subset RR^n$ 上的可微函数 $f: cal(C) -> RR$, $f$ 是拟凸函数, 当且仅当对于任意 $x, y in cal(C)$, 有
$
  f(y) <= f(x) quad arrow.double.r quad nabla f(x)^T (y - x) <= 0
$

=== 对数凸函数
如果正值函数 $f: RR^n -> RR_+$ 满足 $log f(x)$ 是凸函数, 则称 $f$ 为 *对数凸函数 (Log-Convex Function)*. 反之, 如果 $log f(x)$ 是凹函数, 则称 $f$ 为 *对数凹函数 (Log-Concave Function)*.

- 幂函数 $f(x) = x^a$, 其中 $x in RR_+$, 当 $a < 0$ 或 $a >= 1$ 时, $f$ 是对数凸函数; 当 $0 < a <= 1$ 时, $f$ 是对数凹函数.
- Gaussian 分布的概率密度函数 $f(x) = (1 / sqrt(2 pi sigma^2)) exp(-(x - mu)^2 / (2 sigma^2))$, 其中 $x in RR$, $mu in RR$, $sigma > 0$ 是对数凹函数.
=== 对数凸函数的性质
定义在凸集上的二阶可微函数 $f: cal(C) -> RR_+$ 是对数凸函数, 当且仅当对于任意 $x in cal(C)$, 有
$
  f(x) nabla^2 f(x) - (nabla f(x))(nabla f(x))^T succ.curly.eq 0
$

对数凹函数的乘积是对数凹函数, 即如果 $f_1, f_2, dots.h.c, f_m: RR^n -> RR_+$ 是对数凹函数, 则函数
$  
  f(x) = product_(i = 1)^m f_i (x)
$
是对数凹函数.

=== 广义不等式意义下的凸函数
$f:RR^n -> RR^m$ 称为 $cal(K)$-凸函数, 如果 $cal(K) subset RR^m$ 是凸集, 且对于任意 $x, y in "dom" f$, 以及 $theta in \[ 0 \, 1 \]$, 有
$
  f(theta x + (1 - theta) y) prec.curly.eq_(cal(K)) theta f(x) + (1 - theta) f(y)
$

= 第三章: 典型优化问题
== 凸优化
=== 凸优化问题
标准形式的凸优化问题定义为
$
  min &quad f_0(x) \
  "s.t." &quad f_i (x) lt.eq 0, quad i = 1, dots.h, m \
  &quad a_i^T x = b_i, quad i = 1, dots.h, p
$
其中 $f_0, f_1, dots, f_m$ 是凸函数. 

*拟凸问题*
标准形式的拟凸优化问题定义为
$
  min &quad f_0(x) \
  "s.t." &quad f_i (x) lt.eq 0, quad i = 1, dots.h, m \
  &quad a_i^T x = b_i, quad i = 1, dots.h, p
$
其中 $f_0$ 是拟凸函数, $f_1, dots, f_m$ 是凸函数.

凸优化问题的一个重要性质为其可行集为凸集, 因为可行集是由凸不等式约束和仿射等式约束所定义的.
=== 局部和全局极小
*定理*: 如果 $x^*$ 是凸优化问题的局部极小点, 则 $x^*$ 也是全局极小点.
#showybox(
  title: "凸优化中的局部极小即全局极小",
  frame: frameSettings,
  // footer: "Information extracted from a well-known public encyclopedia"
)[
  设凸优化问题为
  $
    min &quad f_0(x) \
    "s.t." &quad f_i (x) lt.eq 0, quad i = 1, dots.h, m \
    &quad a_i^T x = b_i, quad i = 1, dots.h, p
  $
  假设 $x^*$ 是该问题的局部极小点, 则存在 $epsilon > 0$, 使得对于任意满足 $norm(x - x^*) lt.eq epsilon$ 的可行点 $x$, 有 $f_0(x) gt.eq f_0(x^*)$.

  现在取任意可行点 $y$, 并定义
  $
    z = theta y + (1 - theta) x^*
  $
  其中 $theta in (0, 1)$ 是充分小的常数. 因为可行集是凸集, 所以 $z$ 是可行点. 同时, 当 $theta$ 足够小时, 有
  $
    norm(z - x^*) = theta norm(y - x^*) lt.eq epsilon
  $
  因此根据局部极小点的定义, 有 $f_0(z) gt.eq f_0(x^*)$. 又因为 $f_0$ 是凸函数, 所以
  $
    f_0(z) lt.eq theta f_0(y) + (1 - theta) f_0(x^*)
  $
  将上面两个不等式结合起来, 可得
  $
    theta f_0(y) + (1 - theta) f_0(x^*) gt.eq f_0(x^*) ==> f_0(y) - f_0(x^*) gt.eq 0
  $
  因为 $y$ 是任意可行点, 所以 $x^*$ 是全局极小点.
]
=== 可微凸优化问题的最优性条件
$x$ 是凸优化问题 $min_(x in X) f_0(x)$ 的最优解当且仅当对于任意 $y in X$, 有
$
  nabla f_0(x)^T (y - x) gt.eq 0
$
直观来说, 该条件说明在可行集 $X$ 内, 函数 $f_0$ 在点 $x$ 处的任意可行方向上的方向导数都是非负的, 即没有一个可行方向能够使得 $f_0$ 下降. 
== 线性规划
=== 线性规划问题的定义
线性规划问题的一般形式如下:
$
  min &quad c^T x \
  "s.t." &quad A x lt.eq b \
  &quad G x = e
$
其中 $c in RR^n$, $A in RR^(m times n)$, $b in RR^m$, $G in RR^(p times n)$, $e in RR^p$. 
=== 基追踪问题
基追踪问题是压缩感知中的一个基本问题, 其数学模型为
$
  min &quad norm(x)_1 \
  "s.t." &quad A x = b
$
对于每一个 $|x_i|$ 引入一个非负变量 $z_i$, 并添加约束 $-z_i lt.eq x_i lt.eq z_i$, 则基追踪问题可以转化为以下线性规划问题:
$
  min &quad sum_(i = 1)^n z_i \
  "s.t." &quad A x = b \
  &quad -z_i lt.eq x_i lt.eq z_i, quad i = 1, dots.h, n
$

=== 数据拟合
在数据拟合中, 除了常用的最小二乘模型外, 还有最小 $ell_1$ 范数模型, 其数学模型为
$
  min &quad norm(A x - b)_1
$
和最小 $ell_oo$ 范数模型, 其数学模型为
$
  min &quad norm(A x - b)_oo
$
这两个模型都可以转化为线性规划问题. 例如, 最小 $ell_1$ 范数模型可以转化为
$
  min &quad sum_(i = 1)^m z_i \
  "s.t." &quad A x - b lt.eq z \
  &quad - (A x - b) lt.eq z
$
其中 $z in RR^m$ 是引入的辅助变量. 对于最小 $ell_oo$ 范数模型, 可以引入一个辅助变量 $t in RR$, 并转化为
$
  min &quad t \
  "s.t." &quad A x - b lt.eq t bold(1) \
  &quad - (A x - b) lt.eq t bold(1)
$

=== 多面体的切比雪夫中心
对于多面体 $cal(P) = { x in RR^n : A x lt.eq b }$, 其 *切比雪夫中心 (Chebyshev Center)* 定义为包含在 $cal(P)$ 内的最大欧氏球的中心. 设该球的中心为 $x_c in RR^n$, 半径为 $r in RR_+$, 则该球可以表示为
$
  cal(B) = { x in RR^n : norm(x - x_c)_2 lt.eq r }
$

为了使得 $cal(B) subset cal(P)$, 需要满足对于每个 $i = 1, dots.h, m$, 有
$
  a_i^T x_c + r norm(a_i)_2 lt.eq b_i
$

这样, 切比雪夫中心问题可以转化为以下线性规划问题:
$
  max &quad r \
  "s.t." &quad a_i^T x_c + r norm(a_i)_2 lt.eq b_i, quad i = 1, dots.h, m \
  &quad r gt.eq 0
$
== 二次锥规划
=== 二次规划问题的定义
标准形式的二次锥规划问题 (QP) 定义为
$
  min &quad 1/2 x^T P x + q^T x + r \
  "s.t." &quad G x <= h \
  &quad A x = b
$
=== 最小二乘问题
最小二乘问题的数学模型为
$
  min &quad 1/2 norm(A x - b)_2^2
$
其中 $A in RR^(m times n)$, $b in RR^m$.  因为 $1/2 norm(A x - b)_2^2 = 1/2 (A x - b)^T (A x - b) = 1/2 x^T (A^T A) x - b^T A x + 1/2 b^T b$, 所以最小二乘问题是二次规划问题的一个特例.

=== 二次*锥*规划问题的定义
标准形式的二次锥规划问题 (SOCP) 定义为
$
  min &quad f^T x \
  "s.t." &quad norm(A_i x + b_i)_2 lt.eq c_i^T x + d_i, quad i = 1, dots.h, m \
  &quad F x = g
$

优化问题中的不等式 $norm(A_i x + b_i)_2 lt.eq c_i^T x + d_i$ 使得 $x$ 必须在一个特定的锥体内.
== 半定规划
=== 半定规划问题的定义
标准形式的半定规划问题 (SDP) 定义为
$
  min &quad c^T x \
  "s.t." &quad x_1 A_1 + x_2 A_2 + dots.h.c + x_n A_n + B prec.curly.eq 0 \
  &quad G x = h
$
半定规划 (SDP) 是线性规划在矩阵空间中的一种推广, 的目标函数和等式约束均为关于矩阵的线性函数，而它与线性规划不同的地方是其自变量取值于半正定矩阵空间.

= 第四章: 最优性理论
== 最优化问题解的存在性
考虑优化问题
$
  min &quad f(x) \
  "s.t." &quad x in cal(X)
$
首先要考虑的是最优解的存在性. 在数学分析课程中, 我们学习过 *Weierstrass 定理*: 如果函数 $f$ 在紧集 $cal(X)$ 上连续, 则 $f$ 在 $cal(X)$ 上必有最小值.

#showybox(
  title: "紧集",
  frame: frameSettings,
)[
  在欧氏空间 $RR^n$ 中, 集合 $cal(X) subset RR^n$ 称为 *紧集 (Compact Set)*, 如果 $cal(X)$ 是闭集且有界的. 
  - 闭集 (Closed Set): 集合 $cal(X)$ 包含其所有的极限点, 即 $ { x_k } subset.eq cal(X), lim_(k -> oo) x_k = x ==> x in cal(X) $.
  - 有界集 (Bounded Set): 存在常数 $M > 0$, 使得对于任意 $x in cal(X)$, 有 $norm(x) lt.eq M$.

  在拓扑空间中, $K$ 是紧集, 如果从 $K$ 的任意开覆盖中都能选出有限子覆盖.
]

#showybox(
  title: "Weierstrass 定理",
  frame: frameSettings,
)[
  设 $f: cal(X) -> RR$ 在紧集 $cal(X) subset RR^n$ 上连续, 则存在 $x^* in cal(X)$, 使得对于任意 $x in cal(X)$, 有
  $
    f(x^*) <= f(x)
  $
  即 $f$ 在 $cal(X)$ 上取得最小值.
]

现在我们提出 *推广的 Weierstrass 定理*:

如果函数 $f: cal(X) -> (-oo, +oo]$ 适当 (@proper-function) 且闭, 且以下条件中任意一条成立
1. $"dom" f = { x in cal(X) : f(x) < +oo }$ 是非空且有界的;
2. 存在常数 $bar(gamma) in RR$, 使得集合 $C_(macron(gamma)) = { x in cal(X) : f(x) lt.eq macron(gamma) }$ 非空且有界;
3. $f$ 是 *强制* 的, 即对于任意实数序列 ${ x_k }$ 满足 $norm(x_k) -> +oo$, 有 $f(x_k) -> +oo$;
则函数 $f$ 的最小值点集 ${x in cal(X) : f(x) <= f(y), forall y in cal(X) }$ 非空且紧.

这三个条件在本质上都是在确保 $f(x)$ 的最小值不会出现在无穷远处. 定理仅要求 $f$ 是闭函数, 而不要求 $f$ 在其定义域上连续, 因此比数学分析中的 Weierstrass 定理更为一般.

== 解的存在唯一性
=== 强拟凸函数
之前我们已经定义了强凸函数 (@strongly-convex-function) 和拟凸函数 (@quasi-convex-function). 现在我们定义 *强拟凸函数 (Strongly Quasi-Convex Function)*:

给定凸集 $cal(X)$ 和函数 $f: cal(x) -> (-oo, +oo]$, 若取任意 $x != y$ 和 $lambda in (0, 1)$, 有
$
  f(lambda x + (1 - lambda) y) < max { f(x), f(y) } 
$
则称 $f$ 为强拟凸函数. 强拟凸函数不一定是凸函数,  但其任意一个下水平集都是凸集 (因为下水平集中的任意两点的连线上的函数值都小于等于这两个点的函数值的最大值). 

任意强凸函数均为强拟凸的, 但是凸函数并不一定是强拟凸的

=== 唯一性定理
设 $cal(X)$ 是 $RR^n$ 的一个非空, 紧且凸的子集, 如果 $f: cal(X) -> (-oo, +oo]$ 是适当, 闭, 且强拟凸, 则优化问题
$
  min &quad f(x) \
  "s.t." &quad x in cal(X)
$
存在唯一的最优解.

== 无约束可微问题的最优性理论
无约束可微优化问题通常表示为如下形式:
$
  min &quad f(x)
$
其中 $f: RR^n -> RR$ 是可微函数. 给定一个点 $macron(x)$, 我们想要知道这个点是否是函数 $f$ 的一个局部极小解或者全局极小解. 如果从定义出发, 需要对其邻域内的所有点进行判断, 这不可行. 因此, 我们需要一些更简洁的条件来判定 $macron(x)$ 是否为极小解.

=== 一阶必要条件: 下降方向
对于可微函数 $f$ 和点 $x in RR^n$, 如果存在向量 $d in RR^n$, 使得
$
  nabla f(x)^T d < 0
$
则称 $d$ 为 $f$ 在点 $x$ 处的一个 *下降方向 (Descent Direction)*. 直观来说, 如果沿着方向 $d$ 移动, 则函数值会减小.

*定理*: 如果 $macron(x)$ 是无约束优化问题的一个局部极小点, 则对于任意向量 $d in RR^n$, 有
$
  nabla f(macron(x)) = 0
$

=== 二阶最优性条件
在没有额外假设时, 如果一阶必要条件满足, 我们仍然不能确定当前点是否是一个局部极小点. 

*必要条件*: 如果 $macron(x)$ 是无约束优化问题的一个局部极小点, 则 $nabla f(macron(x)) = 0$, 且 $nabla^2 f(macron(x)) succ.curly.eq 0$. 其中 $nabla^2 f(macron(x))$ 是 $f$ 在点 $macron(x)$ 处的 Hessian 矩阵 (@hessian-matrix).

*充分条件*: 如果 $nabla f(macron(x)) = 0$, 且 $nabla^2 f(macron(x)) succ 0$, 则 $macron(x)$ 是无约束优化问题的一个局部极小点.

== 对偶理论
=== 一般的约束优化问题
$
  min_(x in RR) &quad f_0(x) \
  "s.t." &quad c_i (x) <=0, quad i in cal(I) \
  &quad c_i (x) = 0, quad i in cal(E)
$
这里 $cal(I)$ 和 $cal(E)$ 分别是表示不等式约束和等式约束的索引集. 这个问题的可行域定义为
$
  cal(X) = { x in RR^n : c_i (x) <= 0, quad i in cal(I); quad c_i (x) = 0, quad i in cal(E) }
$
通过将 $cal(X)$ 的示性函数
$
  I_(cal(X)) (x) = cases(
    0\, &quad x in cal(X),
    +oo\, &quad "otherwise" 
  )
$
加到目标函数中可以得到无约束优化问题. 但是转化后问题的目标函数是不连续, 不可微的以及不是有限的, 这导致我们难以分析其理论性质以及设计有效的算法.

=== Lagrange 函数
对于约束优化问题, 我们定义其 *Lagrange 函数 (Lagrangian Function)* 为
$
  L(x, lambda, nu) = f_0(x) + sum_(i in cal(I)) lambda_i c_i (x) + sum_(i in cal(E)) nu_i c_i (x)
$
其中 $lambda_i$ 和 $nu_i$ 分别是与不等式约束和等式约束对应的拉格朗日乘子 (Lagrange Multipliers).

=== Lagrange 对偶函数
我们定义 *Lagrange 对偶函数 (Lagrangian Dual Function)* 为
$
  g(lambda, nu) &= inf_(x in RR^n) L(x, lambda, nu) \
  &= inf_(x in RR^n) [ f_0(x) + sum_(i in cal(I)) lambda_i c_i (x) + sum_(i in cal(E)) nu_i c_i (x) ]
$

*弱对偶定理*: 对于任意 $lambda >= 0$ 和任意 $nu in RR^{|cal(E)|}$, 有
$  
  g(lambda, nu) <= p^*
$
其中 $p^*$ 是原始问题的最优值.

=== Lagrange 对偶问题
$
  max_(lambda, nu) &quad g(lambda, nu) \
  "s.t." &quad lambda >= 0
$
称为 *Lagrange 对偶问题 (Lagrangian Dual Problem)*. 其最优值记为 $q^*$. 根据弱对偶定理, 有 $q^* <= p^*$. 我们称 $p^* - q^*$ 为 *对偶间隙 (Duality Gap)*. Lagrange 对偶问题是一个凸优化问题.

#showybox(
  title: "理解 Lagrange 对偶理论",
  frame: frameSettings
)[
  原始问题 $p^*$ 是在寻找一个最低成本的状态 $x$, 这个状态 $x$ 必须满足一系列的严格的规则 (约束). 示性函数 $I_(cal(X)) (x)$ 可以看作是对这些规则的惩罚, 即如果 $x$ 不满足规则, 则惩罚为无穷大. 但是这种惩罚方式过于严厉, 导致我们无法有效地分析和求解问题.

  Lagrange 对偶理论通过引入拉格朗日乘子 $lambda$ 和 $nu$, 将这些严格的规则转化为一种软约束. 具体来说, 我们允许 $x$ 违反某些规则, 但是会根据违反的程度给予一定的惩罚, 这个惩罚的力度由拉格朗日乘子决定. 通过调整这些乘子, 我们可以在成本和规则之间找到一个平衡点.

  $g(lambda, nu)$ 中的 "$inf$" 操作实际上是在寻找在给定惩罚力度下的最低成本状态. 通过最大化 $g(lambda, nu)$, 我们实际上是在寻找一组最优的惩罚力度, 使得即使在考虑惩罚的情况下, 我们仍然能够找到一个尽可能低成本的状态 (实际上就是一个 *Min-Max 问题*, 我们在最小化成本, 而规则的建立者在最大化惩罚)

  因此, 弱对偶定理 $g(lambda, nu) <= p^*$ 的直觉就是:
  - $p^*$ 是在严格遵守规则下的最低成本
  - $g(lambda, nu)$ 是在某套惩罚规则下的最低成本
  显然, 即使在考虑惩罚的情况下, 我们也一定比严格遵守规则的更有优势. 这就是为什么 $g(lambda, nu)$ 总是小于等于 $p^*$.

  对偶间隙 $p^* - q^*$ 衡量了惩罚机制的不完美程度, 在某些 "好" 的情况下 (比如说凸优化), 对偶间隙为零, 即我们可以通过适当的惩罚机制完全恢复原始问题的最优解; 但是大部分情况下, 对偶间隙大于零, 这意味着通过惩罚机制得到的解可能无法完全达到原始问题的最优水平.
]

=== 实例: 线性方程组具有最小模的解
$
  min &quad x^T x \
  "s.t." &quad A x = b
$
其 Lagrange 函数为
$
  L(x, nu) = x^T x + nu^T (A x - b)
$
先求 $L$ 关于 $x$ 的极小值:
$
  nabla_x L(x, nu) = 2x + A^T nu = 0 ==> x = -1/2 A^T nu
$
所以有
$
  g(nu) &= L(-1/2 A^T nu, nu) \
  &= (-1/2 A^T nu)^T (-1/2 A^T nu) + nu^T (A (-1/2 A^T nu) - b) \
  &= -1/4 nu^T A A^T nu - nu^T b
$
因此, 对偶问题为
$
  max_(nu) &quad -1/4 nu^T A A^T nu - nu^T b
$

#showybox(
  title: "Fenchel 共轭和对偶问题",
  frame: frameSettings
)[
  Lagrange 对偶函数 $g(lambda, nu)$ 可以通过 Fenchel 共轭函数来表示. 设
  $
    f(x) = f_0(x) + sum_(i in cal(I)) lambda_i c_i (x) + sum_(i in cal(E)) nu_i c_i (x),
  $
  则
  $
    g(lambda, nu) = inf_(x in RR^n) f(x) = -f^*(0).
  $
  这里 $f^*(y)$ 是函数 $f(x)$ 的 Fenchel 共轭函数 (见 @fenchel-conjugate).

  我们成功地将一个在 $x$ 空间中带约束的最小化问题 (原问题 $p^*$), 转化为一个在 $(lambda, nu)$ 空间中不带约束的最大化问题 (对偶问题 $q^*$). 这个转化的桥梁就是 Fenchel 共轭函数, 它将原问题的复杂性封装在了对偶函数 $g(lambda, nu)$ 中.
]

=== 弱对偶性和强对偶性
弱对偶性 $g(lambda, nu) <= p^*$ 总是成立的, 它可以导出复杂问题的非平凡下界, 但是不能给出最优解. 在某些 "好" 的情况下, 我们可以得到强对偶性, 即存在一组 $(lambda^*, nu^*)$, 使得
$
  g(lambda^*, nu^*) = p^*
$
它 "通常" 对凸优化问题成立.

=== 隐式约束
考虑带边界约束的线性规划问题, 其原问题
$
  min &quad c^T x \
  "s.t." &quad A x = b \
  &quad -bold(1) <= x <= bold(1)
$
其 Lagrange 函数为
$
  L(x, nu, lambda_1, lambda_2) = c^T x + nu^T (A x - b) + lambda_1^T (x - bold(1)) + lambda_2^T (-x - bold(1))
$
其中 $lambda_1, lambda_2 >= 0$. 先求 $L$ 关于 $x$ 的极小值:
$
  nabla_x L(x, nu, lambda_1, lambda_2) = c + A^T nu + lambda_1 - lambda_2 = 0
$
利用这个关系可以把 $x$ 消去, 得到对偶函数
$
  g(nu, lambda_1, lambda_2) &= L(x, nu, lambda_1, lambda_2) \
  &= c^T x + nu^T (A x - b) + lambda_1^T (x - bold(1)) + lambda_2^T (-x - bold(1)) \
  &= - nu^T b - lambda_1^T bold(1) - lambda_2^T bold(1)
$
我们的对偶问题就是
$
  max_(nu, lambda_1, lambda_2) &quad - nu^T b - lambda_1^T bold(1) - lambda_2^T bold(1) \
  "s.t." &quad c + A^T nu + lambda_1 - lambda_2 = 0 \
  &quad lambda_1, lambda_2 >= 0
$
我们发现在这种情况下, 对偶变量反而变多了. 为了避免这个问题, 我们可以把边界约束 *隐式* 地包含在目标函数中, 即引入示性函数
$
  min &quad f_0(x) = cases(
    c^T x\, &quad -bold(1) <= x <= bold(1), 
    +oo\, &quad "otherwise"
  ) \
  "s.t." &quad A x = b
$
这时候对偶函数变为
$
  g(nu) &= inf_(x in RR^n) [ f_0(x) + nu^T (A x - b) ] \
  &= inf_(-bold(1) <= x <= bold(1)) [ c^T x + nu^T (A x - b) ] \
  &= inf_(-bold(1) <= x <= bold(1)) [ (c + A^T nu)^T x - nu^T b ] \
  &= - nu^T b + inf_(-bold(1) <= x <= bold(1)) (c + A^T nu)^T x \
  &= - nu^T b - norm(c + A^T nu)_1
$
因此, 对偶问题为
$
  max_(nu) &quad - nu^T b - norm(c + A^T nu)_1
$
=== 带广义不等式约束优化问题
回顾一下适当锥 (@proper-cone) 的定义: 设 $cal(K) subset RR^n$ 是一个锥, 如果 $cal(K)$ 是闭的, 有非空的内部, 且不包含任何直线, 则称 $cal(K)$ 为 *适当锥 (Proper Cone)*. 适当锥可以诱导出 *广义不等式 (@generalized-inequality)*, 它定义了全空间上的偏序关系
$
  x prec.curly.eq_(cal(K)) y <==> y - x in cal(K)
$
特别地, $cal(K) = RR^n_+$ 诱导出逐元素不等式, $cal(K) = cal(S)_+^n$ 诱导出矩阵半正定序.

通过广义不等式, 我们定义了 *对偶锥 (@dual-cone)*:
$
  cal(K)^* = { y in Omega : angle.l x, y angle.r >= 0, forall x in cal(K) }
$
对于 $cal(K) = RR^n_+$ 和 $cal(K) = cal(S)_+^n$ 诱导出的对偶锥分别等于其本身, 这类锥被称为 *自对偶锥*.

对偶锥可以帮忙构造广义不等式约束的拉格朗日函数. 考虑如下优化问题:
$
  min &quad f_0(x) \
  "s.t." &quad c_i (x) prec.curly.eq_(cal(K)_i) 0, quad i in cal(I) \
  &quad c_i (x) = 0, quad i in cal(E)
$
其 Lagrange 函数为
$
  L(x, lambda, nu) = f_0(x) + sum_(i in cal(I)) angle.l lambda_i, c_i (x) angle.r + sum_(i in cal(E)) nu_i c_i (x)
$
其中 $lambda_i in cal(K)_i^*$ 是与广义不等式约束对应的拉格朗日乘子. 其 Lagrange 对偶函数为
$
  g(lambda, nu) &= inf_(x in RR^n) L(x, lambda, nu), quad lambda_i in cal(K)_i^*, nu_i in RR \
$

== 带约束凸优化问题
=== 一般形式
$
  min_(x in cal(D)) &quad f_0(x) \
  "s.t." &quad c_i (x) lt.eq 0, quad i = 1, dots.h, m \
  &quad A x = b
$ 其中 $f_0$ 是适当的凸函数, $cal(D)$ 是 $x$ 的自然域, $c_i$ 是凸函数, $A in RR^(p times n)$, $b in RR^p$.
=== Slater 约束品性与强对偶原理
*相对内点*: 给定集合 $cal(D)$, 其相对内点定义为
$
  "relint" cal(D) = { x in cal(D) : exists epsilon > 0, "s.t." B(x, epsilon) inter "affine" cal(D) subset.eq cal(D) }
$
其中 $"affine" cal(D)$ 是包含 $cal(D)$ 的最小仿射集 (仿射包):
$
  "affine" cal(D) = {x | x = sum_(i = 1)^k theta_i x_i, quad x_i in cal(D), space sum_(i = 1)^k theta_i = 1 }
$

比如说, 在 $RR^2$ 中, 一条线段是没有内点的, 因为它没有宽度, 线段上的点的开球必然包含线段外的点. 但是如果我们从它的仿射包 (即包含该线段的整条直线) 来看, 线段上的点就有相对内点, 因为在直线上, 线段上的点的开球与直线的交集仍然包含在线段内. 

*Slater 约束品性*: 如果存在 $x in "relint" cal(D)$, 使得对于任意 $i = 1, dots.h, m$, 有 $c_i (x) < 0$, 且 $A x = b$, 则称该优化问题满足 *Slater 约束品性 (Slater's Condition)*.

*若凸优化问题满足 Slater 约束品性, 则强对偶性成立*.

#showybox(
  title: "Slater 约束品性: 可行域内部有 \"喘息空间\"",
  frame: frameSettings,
  breakable: true
)[
  想象在一个被不等式约束围起来的区域 (可行域) 里找最小值, 并假设这个区域 "很窄" (比如所有可行点都恰好在某个约束等于 0 的边界上, 或者是紧贴这个边界).

  我们之前提到, Lagrange 对偶函数通过给违反约束 ($c_i (x) > 0$) 的点施加惩罚 (通过 $lambda_i > 0$ 控制) 来帮助我们找到最优解. 如果存在一个严格可行点 (即满足 $c_i (x) < 0$ 的点), 那么对于某些 $lambda$, Lagrange 函数可以在该点取到一个合理的值, 而让对偶函数接近原始问题的最优值.

  但是如果所有可行点都满足某些 $c_i (x) = 0$, Lagrange 函数可能被迫在这些边界点取值, 这限制了我们通过调整 $lambda$ 来优化对偶函数的能力. 这就像是在一个狭窄的走廊里寻找最优解, 你没有足够的空间来 "呼吸" 和调整你的策略.

  举一个经典的例子, 考虑优化问题
  $
    min_x &quad exp(-x) \
    "s.t." &quad x^2/y <= 0, \
    &quad y > 0.
  $

  该问题的可行域实际上是 $x = 0, y > 0$ 的集合, 因为只有在 $x = 0$ 时, $x^2/y <= 0$ 才成立, 所以原问题的最优值为 $p^* = 1$. 现在我们考虑其 Lagrange 函数:
  $
    L(x, y, lambda) = exp(-x) + lambda (x^2/y), quad lambda >= 0, y > 0.
  $
  对偶函数为
  $
    g(lambda, y) &= inf_(x in RR) L(x, y, lambda) \
    &= inf_(x in RR) [ exp(-x) + lambda (x^2/y) ] \
  $
  这里包含了两项, 其中 $exp(-x)$ 的下确界是 $0$; 而 $lambda (x^2/y)$ 的下确界也是 $0$. 我们取 $x > 0$ 和 $y = x^3$, 则当 $x -> +oo$ 时, 这两项可以同时趋近于 $0$. 因此我们恒有 $g(lambda, y) = 0$ 对任意 $lambda >= 0$ 和 $y > 0$. 这就导致对偶问题 $max g(lambda, y)$ 的最优值为 $q^* = 0$, 从而产生了对偶间隙 $p^* - q^* = 1$.

  在这个例子中, 可行域是一条没有 "喘息空间" 的线 (所有点都在边界上), 而我们在优化对偶函数时无法利用任何严格可行点来调整 Lagrange 乘子, 导致对偶间隙的产生. 这正是 Slater 约束品性所要避免的情况. 
]

== 次梯度
=== 引子
对于一个可微的凸函数 $f: RR^n -> RR$, 我们知道其在任意点 $x$ 处的梯度 $nabla f(x)$ 满足
$
  f(y) >= f(x) + nabla f(x)^T (y - x), quad forall y in RR^n
$
这个就是一阶凸性条件, 表示函数图像总在切平面之上. 但是如果 $f$ 在某些点不可微, 梯度不存在, 但上述不等式仍可能对某些向量成立. 这些向量就构成了函数在该点的 *次梯度* 集合.

=== 次梯度的定义
设 $f: RR^n -> RR$ 是一个凸函数, 如果存在向量 $g in RR^n$, 使得对于任意 $y in RR^n$, 有
$  
  f(y) >= f(x) + g^T (y - x)
$
则称 $g$ 为函数 $f$ 在点 $x$ 处的一个 *次梯度 (Subgradient)*. 函数 $f$ 在点 $x$ 处的所有次梯度构成的集合称为 *次微分 (Subdifferential)*, 记为 $partial f(x)$:

=== 一阶充要条件