#import "@preview/showybox:2.0.4": showybox

#import "@preview/ilm:1.4.1": *
#import "@preview/finite:0.5.0": automaton
#import "@preview/finite:0.5.0"
#import "@preview/physica:0.9.7": dd, dv, pdv

#set text(font: ("Libertinus Serif", "Source Han Serif SC"))

#show heading.where(level: 1): set text(navy.lighten(0%))
#show heading.where(level: 2): set text(navy.lighten(20%))
#show heading.where(level: 3): set text(navy.lighten(40%))

#show ref: it => {
  text(purple, it)
}

#show: ilm.with(
  title: [人工智能数学原理 作业11],
  date: datetime.today(),
  author: "潘天麟 2023K8009908023",
  table-of-contents: none,
)

#set heading(numbering: "1.1.1")
#set page(numbering: "1")
#set text(14pt)
#show raw: set text(font: "Maple Mono NF", size: 12pt)

#let frameSettings = (
  border-color: navy,
  title-color: navy.lighten(30%),
  body-color: navy.lighten(95%),
  footer-color: navy.lighten(80%),
)


#let colMath(x, color) = text(fill: color)[$#x$]
#let argmin(x) = $limits(op("argmin"))_#x$

#let prob(title, body) = showybox(
  title: title,
  frame: frameSettings,
  body,
)

#prob(
  "T1",
)[
  使用 ADMM 求解问题
  $
       min quad & (x-1)^2 + (y - 2)^2 \
    "s.t." quad & 2x + 3y = 5
  $
  要求做一次迭代, 取二次罚项系数 $rho = 0.5$, 步长 $tau = 1$.
]

首先构造增广 Lagrangian:
$
  L_rho (x, y, lambda) = (x-1)^2 + (y-2)^2 + lambda (2x + 3y - 5) + rho / 2 (2x + 3y - 5)^2
$
设置初始点 $x_0 = 0, y_0 = 0, lambda_0 = 0$.

我们先更新 $x$, 固定 $y = y_0, lambda = lambda_0$, 对 $x$ 求导并令导数为零:
$
  pdv(L, x) = 2 (x - 1) + 2 lambda + 2 rho (2x + 3y - 5) = 0 \
  ==> 4x = 7 ==> x_1 = 7 / 4
$

现在, 固定 $x = x_1, lambda = lambda_0$, 对 $y$ 求导并令导数为零:
$
  pdv(L, y) = 2 (y - 2) + 3 lambda + 3 rho (2x + 3y - 5) = 0 \
  ==> 13 / 2 y = 25 / 4 ==> y_1 = 25 / 26
$

最后, 更新 $lambda$:
$
  lambda_1 & = lambda_0 + tau rho (2 x_1 + 3 y_1 - 5) \
           & = 0 + 1/2 (2 times 7/4 + 3 times 25/26 - 5) \
           & = 9 / 13
$
综上, 第一次迭代后得到的新点为
$
  (x_1, y_1, lambda_1) = (7/4, 25/26, 9/13)
$

#prob(
  "T2",
)[
  考虑约束优化问题
  $
       min quad & max {exp(-x) + y, med y^2} \
    "s.t." quad & y >= 2
  $
  其中 $x, y in RR$ 为自变量.

  (a) 通过引入松弛变量 $z$, 试说明该问题等价于
  $
       min quad & max {exp(-x) + y, med y^2) + I_(RR^+) (z) \
    "s.t." quad & y - z = 2
  $
  (b) 推导 (a) 中问题的对偶问题, 并求出原始问题的最优解. \
  (c) 对 (a) 中的问题形式, 使用 ADMM 求解时可能会遇到什么问题?
]

(a). 因为条件 $y >= 2$ 等价于存在 $z in RR^+$ 使得 $y - z = 2$. 改写后的优化目标中的 $I_(RR^+) (z)$ 保证了 $z$ 只能取非负值, 因此两个问题等价.

(b). 构造 Lagrangian:
$
  L(x, y, z, lambda) = max {exp(-x) + y, med y^2} + I_(RR^+) (z) + lambda (y - z - 2)
$
把 $(x, y)$ 和 $z$ 以及常数项分开:
$
  L(x, y, z, lambda) = [max {exp(-x) + y, med y^2} + lambda y] + [I_(RR^+) (z) - lambda z] - 2 lambda
$
对于 $z$ 部分, 如果 $lambda > 0$, 则当 $z -> oo$, 则没有下界; 如果 $lambda <= 0$, 则取 $z = 0$ 可得下界 $0$. 所以我们令 $lambda <= 0$, 此时有
$
  L(x, y, z, lambda) >= max {exp(-x) + y, med y^2} + lambda y - 2 lambda
$
考虑到 $x$ 也是自由的, 当 $x -> oo$, $exp(-x) -> 0$, 因此
$
  L(x, y, z, lambda) > max {y, med y^2} + lambda y - 2 lambda
$
忽略常数项, 我们实际上要分析
$
  max {(1 + lambda) y, med y^2 + lambda y}
$
前面我们得到的结论是 $lambda <= 0$. 那么二次函数 $y^2 + lambda y = y (y + lambda)$ 通过零点和 $(-lambda, 0)$ 两个点, 在 $(0, -lambda)$ 上取负值, 在其他区间取正值. 但是直线 $(1 + lambda) y$ 的斜率正负未定.

如果 $lambda < -1$, 则直线斜率为负. 考虑到二次函数在原点上的斜率为 $lambda$, 则二次函数在原点处的斜率小于直线斜率. 因此在 $(0, y_0)$ 上始终有 $y^2 + lambda y < (1 + lambda) y < 0$, 这里 $y_0$ 是两者的交点.
$
  (1 + lambda) y = y^2 + lambda y \
  ==> y^2 - y = 0 \
  ==> y = 1
$
对应的最小值为 $1 + lambda$. 如果这个交点在抛物线对称轴的右边, 那么之后二次函数的值总是大于直线的值, $1 + lambda$ 也就是全局下界. 但是如果交点在抛物线对称轴的左边, 那么二次函数在交点之后会先下降再上升, 因此我们需要计算抛物线的顶点处的值. 抛物线对称轴为 $y = -lambda / 2$, 因此交点在对称轴左边等价于 $1 < -lambda / 2$, 即 $lambda < -2$. 抛物线顶点处的值为
$
  (-lambda / 2)^2 + lambda (-lambda / 2) = -lambda^2 / 4
$
所以若 $lambda <= -2$, 则我们要求的下界为 $-lambda^2 / 4$; 若 $-2 < lambda < -1$, 则我们要求的下界为 $1 + lambda$.

如果 $-1 <= lambda <= 0$, 则直线斜率非负, 则在 $y >= 0$ 范围内, 二次函数的值总是大于等于直线的值. 因此我们要求的下界就是在原点处的值, 即 $0$.

综合起来, 对于任意 $lambda <= 0$, 我们有
$
  inf L(x, y, z, lambda) = cases(
    -lambda^2 / 4 - 2lambda\, & lambda < -2,
    1 - lambda\, & -2 <= lambda < -1,
    -2 lambda\, & -1 <= lambda <= 0
  )
$
因此对偶问题为
$
     max quad & inf L(x, y, z, lambda) \
  "s.t." quad & lambda <= 0
$
容易得当 $lambda = -4$ 时取得最大值 $4$. 此时原问题的最优解为 $x -> oo, y = 2$.

*Tips*: 实际上考虑约束 $y >= 2$, 我们一开始就可以知道 $max {y, y^2} = y^2$, 所以可以不用考虑其他分支的情况.

(c). 由于目标函数中包含 $max$ 运算, 导致在 ADMM 的迭代过程中, 出现了不可微算子中两个变量耦合的情况, 这会使得每次迭代中变量的更新变得复杂, 可能无法通过简单的封闭形式表达式来计算更新值, 从而增加了计算的难度和复杂性.

#prob(
  "T3",
)[
  考虑线性规划的对偶问题
  $
       max quad & b^T y \
    "s.t." quad & A^T y + s = c \
                & s >= 0
  $
  写出对于线性规划对偶问题运用 ADMM 的迭代格式
]

先将原问题改写成极小化形式, 并引入指示函数 $I_(RR^n_+)$ 来处理约束 $s >= 0$:
$
  min_(y, s) quad & -b^T y + I_(RR^n_+) (s) \
      "s.t." quad & A^T y + s = c
$
构造增广 Lagrangian:
$
  L_rho (y, s, lambda) = -b^T y + I_(RR^n_+) (s) + lambda^T (A^T y + s - c) \ + rho / 2 norm(A^T y + s - c)_2^2
$
考虑第 $k + 1$ 次迭代. 先固定 $s = s^k, lambda = lambda^k$, 更新 $y$. 对 $y$ 求导并令导数为零:
$
  pdv(L, y) = -b + A lambda^k + rho A (A^T y + s - c) = 0 \
  ==> rho A A^T y^(k + 1) = b - A lambda^k - rho A (s^k - c)
$
如果 $A A^T$ 可逆, 则
$
  y^(k + 1) = (rho A A^T)^(-1) [b - A lambda^k - rho A (s^k - c)]
$
固定 $y^(k + 1)$ 和 $lambda^k$, 更新 $s$. 忽略 $I_(RR^n_+) (s)$ 项, 对 $s$ 求导并令导数为零:
$
  pdv(L, s) = lambda^k + rho (A^T y^(k + 1) + s - c) = 0 \
  ==> s^(k + 1) = c - A^T y^(k + 1) - 1 / rho lambda^k
$
但是考虑到 $s$ 需要满足非负约束, 因此我们需要对上式进行投影:
$
  s^(k + 1) = max {0, c - A^T y^(k + 1) - 1 / rho lambda^k}
$
最后更新 $lambda$:
$
  lambda^(k + 1) = lambda^k + rho (A^T y^(k + 1) + s^(k + 1) - c)
$

#prob(
  "T4",
)[
  考虑模型:
  $
    min_x {f(x) + g(A x)}
  $
  其中 $f, g$ 都是proper, closed functions. 将上述模型改写成能被 ADMM 处理的形式, 并写出 ADMM 的迭代格式.
]

引入辅助变量 $z = A x$, 则问题等价于
$
  min_(x, z) quad & f(x) + g(z) \
      "s.t." quad & A x - z = 0
$
对应的增广 Lagrangian 为
$
  L_rho (x, z, lambda) = f(x) + g(z) + lambda^T (A x - z) + rho / 2 norm(A x - z)_2^2
$
先更新 $x$, 固定 $z = z^k, lambda = lambda^k$:
$
  x^(k + 1) = arg min_x [f(x) + (lambda^k)^T A x + rho / 2 norm(A x - z^k)_2^2]
$
固定 $x = x^(k + 1), lambda = lambda^k$, 更新 $z$:
$
  z^(k + 1) = arg min_z [g(z) - (lambda^k)^T z + rho / 2 norm(A x^(k + 1) - z)_2^2]
$
最后更新 $lambda$:
$
  lambda^(k + 1) = lambda^k + rho (A x^(k + 1) - z^(k + 1))
$

