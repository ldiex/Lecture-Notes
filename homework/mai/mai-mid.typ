#import "@preview/showybox:2.0.4": showybox

#import "@preview/ilm:1.4.1": *
#import "@preview/finite:0.5.0": automaton
#import "@preview/finite:0.5.0"

#set text(font:("Libertinus Serif", "Source Han Serif SC"))

#show heading.where(level: 1): set text(navy.lighten(0%))
#show heading.where(level: 2): set text(navy.lighten(20%))
#show heading.where(level: 3): set text(navy.lighten(40%))

#show ref: it => {
  text(purple, it)
}

#show: ilm.with(
  title: [Midterm Review for _Mathematiccal Foundations of AI_],
  date: datetime.today(),
  author: "潘天麟 2023K8009908023",
  table-of-contents: none,
)

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

#let colMath(x, color) = text(fill: color)[$#x$]
= 基础知识
== SVD 分解
SVD 告诉我们任何复杂的线性变换 $A$ 都可以被拆分成三步:
1. 一次旋转 (由 $V^T$ 描述),
2. 一次沿着坐标轴的缩放 (由 $Sigma$ 描述, 缩放因子为奇异值),
3. 再一次旋转 (由 $U$ 描述).

即
$
A = U Sigma V^T
$

其中
- $U$ 和 $V$ 是正交矩阵, 即 $U^T U = I$ 且 $V^T V = I$.
- $Sigma$ 是一个对角矩阵, 其对角线上的元素为 $A$ 的奇异值, 其他元素为零.

计算方法:
1. 计算 $A^T A$ 和 $A A^T$ 的特征值和特征向量.
2. 设 $A^T A$ 的特征值为 $lambda_i$, 则奇异值 $sigma_i = sqrt(lambda_i)$.
3. 构造 $U$ 和 $V$ 的列向量分别为 $A A^T$ 和 $A^T A$ 的归一化特征向量.

*注意*: 这里的特征值和特征向量都按照特征值 *从大到小* 排序.

== 范数的定义
若实值函数 $norm(dot.op) : bb(R)^n arrow.r bb(R)$
满足下列条件: 
1. 正定性: $norm(bold(x)) gt.eq 0$, $forall bold(x) in bb(R)^n$. $norm(x) = 0 arrow.l.r.double bold(x) = bold(0)$. 
2. 齐次性: $norm(alpha bold(x)) = lr(|alpha|) norm(bold(x))$, $forall a in bb(R)$, $bold(x) in bb(R)^n$. 
3. 三角不等式: $norm(bold(x) + bold(y)) lt.eq norm(bold(x)) + norm(bold(y))$, $forall bold(x) \, bold(y) in bb(R)^n$. 

则 $norm(dot.op)$ 为向量范数


=== 一些常见的矩阵范数
- Frobenius 范数:
  $ norm(A)_F = [sum_(i = 1)^m sum_(j = 1)^n a_(i j)^2]^(1 \/ 2) $

- 核范数 (Nuclear norm):
  $ norm(A)_(*) = sum_(i = 1)^r sigma_i $ 其中
  $sigma_i$ 为 $A$ 的奇异值, $r = min { m \, n }$. 或者我们也可以定义
  $sigma_i$ 为 $A$ 的非零奇异值, $r = upright("rank") \( A \)$.

- 谱范数 (Spectral norm):
  $ norm(A)_2 = sigma_1 = max_(bold(x) eq.not 0) frac(norm(A bold(x))_2, norm(bold(x))_2) $
  其中 $sigma_1$ 为 $A$ 的最大奇异值.
  

谱范数是核范数的 *对偶范数*, 即
$
norm(A)_2 = max_(norm(B)_(* ) <= 1) tr(A^T B)
$
所以我们有 Hölder 不等式:
$
tr(A^T B) lt.eq norm(A)_2 norm(B)_(* )
$

== 矩阵的迹
- 矩阵的迹 (Trace) 定义为方阵对角线元素之和
- $tr(A)$ 在相似变换下不变, 即 $tr(A) = tr(P^(-1) A P)$, 特别地, $tr(A)$ 在正交变换下不变 $tr(A) = tr(Q^T A Q)$.


== 矩阵迹, 特征值和行列式
- $tr(A) = sum_(i = 1)^n lambda_i$
- $det(A) = product_(i = 1)^n lambda_i$

== 矩阵求导
- $nabla_X tr(Y^T X) = Y$
- $nabla_X det(X) = det(X) (X^(-1))^T$

== 次梯度
设 $f: RR^n -> RR$ 是一个凸函数, 如果存在向量 $g in RR^n$, 使得对于任意 $y in RR^n$, 有
$  
  f(y) >= f(x) + g^T (y - x)
$
则称 $g$ 为函数 $f$ 在点 $x$ 处的一个 *次梯度 (Subgradient)*. 函数 $f$ 在点 $x$ 处的所有次梯度构成的集合称为 *次微分 (Subdifferential)*, 记为 $partial f(x)$:

*常见范数的次梯度* (只考虑不可微点):
- $ell_1$ 范数: ${g | norm(g)_oo <= 1}$
- $ell_2$ 范数: ${g | norm(g)_2 <= 1}$
- $ell_oo$ 范数: ${g | norm(g)_1 <= 1}$

这里也体现了 $ell_1$ 和 $ell_oo$ 范数的对偶性, 以及 $ell_2$ 范数是自对偶范数.
== 强凸函数
<strongly-convex-function>
若存在常数 $m > 0$, 使得对于任意 $x, y in "dom" f$ 以及 $theta in \[ 0 \, 1 \]$, 有
$  f(theta x + (1 - theta) y) lt.eq theta f(x) + (1 - theta) f(y) - m / 2 theta (1 - theta) norm(x - y)^2 $
则称 $f$ 为 *强凸函数 (Strongly Convex Function)*, 其中 $norm(dot.op)$ 是某种范数.

也可以用另一个等价的定义: 若存在常数 $m > 0$, 使得 $f(x) - m / 2 norm(x)^2$ 是凸函数, 则称 $f$ 为强凸函数.

如果 $f$ 是强凸函数, 且存在最小值, 则该最小值唯一.

== 内点
设 $C$ 是 $RR^n$ 的一个凸集. 点 $x in C$ 称为 $C$ 的一个 *内点 (Interior Point)*, 如果存在 $epsilon > 0$, 使得开球
$B(x \, epsilon) = { y in RR^n : norm(y - x) lt epsilon }$
包含在 $C$ 中.

== 手算 SVM
基本上给出的数据点中有很多支持向量. 找到两个边界
$
w^T x + b = 1, quad w^T x + b = -1
$
使得它们之间的间隔最大. 间隔为 $frac(2, norm(w))$. 通过支持向量可以列出方程组, 解出 $w$ 和 $b$.

== 转化为线性规划问题
遇到 $max {0, x}$ 可以使用恒等变换
$
  max {x, y} equiv (x + y + |x - y|) / 2
$
于是 $max {0, x} equiv (x + |x|) / 2$. 这就转化为了 $ell_1$ 范数的问题, 可以进一步转化为线性规划问题.

== 对偶范数
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

== 锥组合和凸锥
相比于凸组合和仿射组合, 锥组合不要求系数之和为 1. 形如
$ theta_1 x_1 + theta_2 x_2 + dots.h.c + theta_k x_k \, quad theta_i gt.eq 0 \, i = 1 \, 2 \, dots.h \, k $
的点称为点 $x_1 \, x_2 \, dots.h \, x_k$ 的 #strong[锥组合 (Conical
Combination)];.

若集合 $cal(S)$ 中的任意点的锥组合都包含在 $cal(S)$ 中, 则称集合
$cal(S)$ 是 #strong[凸锥 (Convex Cone)];.

== 对偶锥
令锥 $K subset Omega$, 则 $K$ 的对偶锥定义为
$
K^* = { y in Omega : angle.l x, y angle.r gt.eq 0 , quad forall x in K }
$

对偶锥是相对于锥 $K$ 定义的, 我们把对偶锥为自身的锥称为 *自对偶锥 (Self-dual Cone)*.

#showybox(
  title: "注意",
  frame: frameSettings
)[
  涉及对偶的定义中, 内积里新的变量一般放在后面, 如
  $
    K^* = { y in Omega : angle.l x, colMath(y, #blue) angle.r gt.eq 0 , quad forall x in K }  \
    f^* (t) = sup_(x in "dom" f) { angle.l x, colMath(t, #blue) angle.r - f(x) }
  $
]
= 无约束问题
== 一阶必要条件: 下降方向
对于可微函数 $f$ 和点 $x in RR^n$, 如果存在向量 $d in RR^n$, 使得
$
  nabla f(x)^T d < 0
$
则称 $d$ 为 $f$ 在点 $x$ 处的一个 *下降方向 (Descent Direction)*. 直观来说, 如果沿着方向 $d$ 移动, 则函数值会减小.

*定理*: 如果 $macron(x)$ 是无约束优化问题的一个局部极小点, 则对于任意向量 $d in RR^n$, 有
$
  nabla f(macron(x)) = 0
$

== 二阶最优性条件
在没有额外假设时, 如果一阶必要条件满足, 我们仍然不能确定当前点是否是一个局部极小点. 

*必要条件*: 如果 $macron(x)$ 是无约束优化问题的一个局部极小点, 则 $nabla f(macron(x)) = 0$, 且 $nabla^2 f(macron(x)) succ.curly.eq 0$. 其中 $nabla^2 f(macron(x))$ 是 $f$ 在点 $macron(x)$ 处的 Hessian 矩阵.

*充分条件*: 如果 $nabla f(macron(x)) = 0$, 且 $nabla^2 f(macron(x)) succ 0$, 则 $macron(x)$ 是无约束优化问题的一个局部极小点.

#showybox(
  title: "注意",
  frame: frameSettings
)[
  二阶充分条件要求 *正定*, 而二阶必要条件只要求 *半正定*. 
]

= 带约束的问题
== Lagrange 对偶
== Slater 条件

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

*若凸优化问题满足 Slater 约束品性, 则强对偶性成立, 且 KKT 条件是最优解的充分必要条件.*

== KKT 条件
对于凸优化问题, 用 $a_i$ 表示矩阵 $A^T$ 的第 $i$ 列, $partial f$, $partial c_i$ 分别表示函数 $f_0$ 和 $c_i$ 的次微分, *如果 Slater 条件成立*, 则点 $x^*$, $lambda^*$ 分别是原始和对偶问题的全局最优解当且仅当

1. *稳定性条件*:
$
  0 in partial f_0 (x^*) + sum_(i = cal(I))^m lambda_i^* partial c_i (x^*) + sum_(i in cal(E)) nu_i^* a_i \
  nabla f_0 (x^*) + sum_(i = cal(I))^m lambda_i^* nabla c_i (x^*) + sum_(i in cal(E)) nu_i^* nabla c_i (x^*) = 0
$

2. *原始可行性条件*:
$
  A x^* = b, quad forall i in cal(E) \ c_i (x^*) <= 0, forall i in cal(I)
$

3. *对偶可行性条件*:
$
  lambda^* >= 0, quad forall i in cal(I)
$

4. *互补松弛条件*:
$
  lambda_i^* c_i (x^*) = 0, quad forall i in cal(I)
$ 

#showybox(
  title: "KKT 条件的直观图像",
  frame: frameSettings
)[
  我们可以把 $x^*$ 想象成一个停在山谷 (目标函数 $f_0$) 中的小球, 这个山谷被几堵墙 (约束 $c_i$ 和 $A x = b$ 所限制. KKT 条件描述了小球在这个受限环境中达到最低点时的状态.

  1. *原始可行性条件* 确保小球确实停在允许的区域内, 即它没有穿过任何墙壁 ($c_i (x^*) <= 0$) 且必须待在 $A x = b$ 所定义的轨道上.

  2. *对偶可行性条件* 确保与每堵墙相关的拉格朗日乘子 ($lambda^*$) 是非负的, 这意味着墙壁只能对小球施加 "推力" (阻止它穿过墙壁), 而不能 "拉" 它进入墙壁.

  3. *互补松弛条件* 表示如果某个约束在最优点处是严格满足的 ($c_i (x^*) < 0$), 则对应的拉格朗日乘子必须为零 ($lambda_i^* = 0$). 这意味着只有当小球正好接触到墙壁时, 墙壁才会对小球施加力.

  4. *稳定性条件* 表示平衡法则. 小球自身受到 "重力" (目标函数的梯度 $nabla f_0 (x^*)$) 的作用, 同时也受到墙壁的反作用力 (由拉格朗日乘子和约束的梯度共同决定). 在最优点, 小球的受力平衡, 即所有作用力的合力为零 (这是第二个式子). 第一个式子处理的是次梯度的情况, 即使在不可微点, 也要求受力平衡.
]
