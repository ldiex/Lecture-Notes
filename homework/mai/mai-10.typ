#import "@preview/showybox:2.0.4": showybox

#import "@preview/ilm:1.4.1": *
#import "@preview/finite:0.5.0": automaton
#import "@preview/finite:0.5.0"

#set text(font: ("Libertinus Serif", "Source Han Serif SC"))

#show heading.where(level: 1): set text(navy.lighten(0%))
#show heading.where(level: 2): set text(navy.lighten(20%))
#show heading.where(level: 3): set text(navy.lighten(40%))

#show ref: it => {
  text(purple, it)
}

#show: ilm.with(
  title: [人工智能数学原理 作业10],
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
  根据不同的集合 $C$, 求解投影算子 $P_C$.

  $
    P_C (x) = arg min_(y in C) norm(x - y)_2^2
  $

  1. $C = {x | a^T x = b}, quad a != 0$
  2. $C = {x | a^T x <= b}, quad a != 0$
  3. $C = {x | A x = b}$, 其中 $A$ 行满秩
  4. $C = {x | norm(x)_1 <= 1}$
  5. $C = {x | norm(x)_2 <= 1}$
]

1. 显然, $x$ 在平面 $a^T x = b$ 上的投影在 $x + t a$ 这一条直线上. 代入平面方程, 就有
$
  a^T (x + t a) = b ==> t = (b - a^T x) / (a^T a)
$
因此
$
  P_C (x) = x + t a = x + (b - a^T x) / (a^T a) a
$

2. 这里需要分类讨论, 如果 $a^T x > b$, 那么 $y$ 在这个半空间的边界, 答案和 1. 中的一样
$
  P_C (x) = x + (b - a^T x) / (a^T a) a
$
如果 $a^T x <= b$, 那么 $y$ 在这个半空间的内部, 答案是 $P_C (x) = x$

3. 这等价于一个约束优化问题
$
  min_y norm(x - y)_2^2 quad "s.t." A y = b
$
我们构造 Lagrangian
$
  L(y, lambda) & = norm(x - y)_2^2 + lambda^T (A y - b) \
               & = (x - y)^T (x - y) + lambda^T (A y - b)
$
求梯度, 则有
$
  nabla_y L(y, lambda) = -2 (x - y) + A^T lambda
$
令其为 $0$, 则有
$
  y = x - 1/2 A^T lambda
$
代入约束条件 $A y = b$, 则有
$
  A (x - 1/2 A^T lambda) = b ==> lambda = 2 (A A^T)^(-1) (A x - b)
$
所以
$
  P_C (x) = x - A^T (A A^T)^(-1) (A x - b)
$

4. 这里是要求到 $ell_1$ 球的投影. 如果 $x$ 在 $ell_1$ 球的内部, 那么 $y = x$ 就是答案.

如果 $x$ 在 $ell_1$ 球的外部, 那么 $y$ 在 $ell_1$ 球的边界上. 这个时候, 我们需要求以 $x$ 为中心的, 最大半径的 $ell_2$ 球和单位 $ell_1$ 球的交点.

首先, 我们断言, 对于每一个分量, 我们有 $"sign"(x_i) = "sign"(y_i)$. 因为如果不然, 我们可以给 $y_i$ 取相反数, 这样 $ell_1$ 范数不变, 但是 $norm(y - x)_2$ 肯定变小了.

那我们就可以假设 $x$ 的每一个分量都大于 $0$ (因为 $x$ 在单位 $ell_1$ 球的外部). 现在我们可以写出 Lagrangian
$
  L(w, lambda, beta) = 1/2 sum_i (x_i - w_i)^2 + lambda (sum_i w_i - 1) - sum_i beta_i w_i, quad beta >= 0
$
于是有
$
  (partial) / (partial w_i) L(w, lambda, beta) = x_i - w_i + lambda - beta_i = 0 ==> w_i = x_i + lambda - beta_i
$
代入约束 $sum_i w_i = 1$, 则有
$
  sum_i (x_i + lambda - beta_i) = 1 ==> n lambda = 1 - sum_i x_i + sum_i beta_i
$
考虑对偶条件, 有 $beta_i w_i = 0$, 代入 $w_i = x_i + lambda - beta_i$, 则有 $beta_i (x_i + lambda - beta_i) = 0$. 由于 $beta_i >= 0$, 所以 $beta_i = 0$ 或 $x_i + lambda - beta_i = 0$.

假设 $beta_i = 0$, 那么
$
  w_i = x_i + lambda = x_i + 1/n (1 - sum_j x_j)
$
如果 $x_i + lambda - beta_i = 0$, 那么
$
  w_i = 0
$
所以可以把解写成
$
  w_i = max (x_i + 1/n (1 - sum_j x_j), 0)
$
把 $x_i$ 的符号再考虑进去, 我们就有最后的解为
$
  y_i = "sign"(x_i) max (|x_i| + 1/n (1 - sum_j |x_j|), 0)
$

5. 对 $ell_2$ 球的投影就是最简单的归一化
$
  P_C (x) = x / max(1, norm(x)_2)
$

#prob(
  "T2",
)[
  对于 LASSO 问题:
  $
    min_(x in RR^d) 1/2 norm(A x -b)_2^2 + mu norm(x)_1
  $
  写出该问题及其对偶问题的 ALM 算法.
]

由于原始 LASSO 问题中的 $ell_1$ 范数不光滑, 所以我们采用分离变量法, 把不光滑项中的 $x$ 变成 $z$, 现在 LASSO 问题就变成约束优化问题:
$
  min_(x in RR^d, z in RR^d) 1/2 norm(A x -b)_2^2 + mu sum_i |z_i| quad "s.t." x = z
$
其对应的增广 Lagrangian 为
$
  L(x, z, lambda, rho) = 1/2 norm(A x -b)_2^2 + mu sum_i |z_i| + lambda^T (x - z) + rho/2 norm(x - z)_2^2
$
现在考虑原问题的对偶问题, 原问题可以被写成
$
  min_(x in RR^d, z in RR^d) 1/2 norm(A x -b)_2^2 + mu sum_i z_i quad "s.t." -z_i <= x_i <= z_i
$
对应的 Lagrangian 为
$
  L(x, z, mu, alpha, beta) = 1/2 norm(A x -b)_2^2 + mu sum_i z_i \ - sum_i alpha_i (x_i + z_i) + sum_i beta_i (x_i - z_i)
$
其中 $mu, lambda_i, alpha_i, beta_i > 0$, 我们写成向量的形式
$
  L(x, z, mu, alpha, beta) = 1/2 (A x - b)^T (A x - b) + mu dot.c bold(1)^T z \ - alpha^T (x + z) + beta^T (x - z)
$
求梯度, 有
$
  nabla_x L = A^T (A x - b) - alpha + beta \
  nabla_z L = mu bold(1) - alpha - beta
$
这里我们设 $w = alpha - beta$, 根据 KKT 条件, 我们有
$
  A^T (A x - b) = w, quad -mu bold(1) <= w <= mu bold(1)
$
把 $nabla_z L = 0$ 代回 $L$, 则有
$
  L(x, z, mu, alpha, beta) & = 1/2 (A x - b)^T (A x - b) + (alpha + beta)^T z \
                           & quad quad - alpha^T (x + z) + beta^T (x - z) \
                           & = 1/2 (A x - b)^T (A x - b) + (beta - alpha)^T x \
$
展开为 $x$ 的二次函数
$
  L(x, z, mu, alpha, beta) & = 1/2 x^T A^T A x - b^T A x + 1/2 b^T b - w^T x \
                           & = 1/2 x^T A^T A x - (w^T + b^T A) x + 1/2 b^T b \
$
假设 $A^T A$ 可逆, 则 $x$ 的最优解为
$
  x = (A^T A)^(-1) (w + A^T b)
$
代入 Lagrangian, 则得到对偶问题为
$
  max_w quad -1/2 (A^T b + w)^T (A^T A)^(-1) (A^T b + w), quad "s.t." norm(w)_oo <= mu
$
其对应的 ALM 就是
$
  L(w, lambda, rho) = -1/2 (A^T b + w)^T (A^T A)^(-1) (A^T b + w) \ + lambda (mu - norm(w)_oo) + rho/2 norm(w)_oo^2
$


#prob(
  "T3",
)[
  对于一个凸函数 $h$, 其邻近算子定义为
  $
    "prox"_h (x) = argmin(u in "dom" h) {
      h(u) + 1/2 norm(u - x)_2^2
    }
  $
  求下列函数的邻近算子:
  1. $h(x) = norm(x)_1$
  2. $h(x) = norm(x)_2$
  3. $h(x) = 1/2 x^T A x + b^T x + c$, 其中 $A$ 是正定对称方阵.
]

1. $ell_1$ 范数对应的表达式为
$
  argmin(u) {
    norm(u)_1 + 1/2 norm(u - x)_2^2
  }
$
它可以分离变量, 所以我们只考虑 $u_i$ 的情况:
$
  argmin(u_i) {
    abs(u_i) + 1/2 (u_i - x_i)^2
  } & = argmin(u_i) {
        1/2 u_i^2 + abs(u_i) - x_i u_i
      }
$
若 $u_i >= 0$, 则优化目标为 $1/2 u_i^2 + (1 - x_i) u_i$, 在 $u_i = x_i - 1$ 处取得最小值. 这时需要满足 $x_i >= 1$; 若 $u_i < 0$, 则优化目标为 $1/2 u_i^2 + (x_i + 1) u_i$, 在 $u_i = -x_i - 1$ 处取得最小值. 这时需要满足 $x_i <= -1$. 如果 $abs(x) < 1$, 那么最小值只能在边界处取到, 即 $u_i = 0$.

综上, 我们有
$
  "prox"_(ell_1) (x) = "sign"(x) dot.o max (abs(x) - 1, 0)
$

2. 现在我们的优化目标是
$
  f(u) = norm(u)_2 + 1/2 norm(u - x)_2^2
$
在 $u != 0$ 的时候, 这个函数是可微的, 其梯度为
$
  partial f(u) = u / norm(u)_2 + (u - x)
$
这个时候令 $partial f(u) =0$, 就有
$
  u^* = (1 - 1 / norm(x)_2) x
$
如果 $u = 0$, 那么 $norm(u)_2$ 项是不可微的. 考虑其次微分, 因为 $ell_2$ 的共轭范数也是 $ell_2$, 所以我们有
$
  partial f(u) = { g - x | norm(g)_2 <= 1 }, quad u = 0
$
那么 $partial f(u) = 0$ 要求 $norm(x)_2 <= 1$. 综上, 我们就有
$
  "prox"_(ell_2) (x) = cases(
    0 \, quad & norm(x)_2 <= 1,
    (1 - 1 / norm(x)_2) x \, quad & norm(x)_2 > 1
  )
$

3. 这时候目标函数为
$
  f(u) & = 1/2 u^T A u + b^T u + c + 1/2 norm(u - x)_2^2 \
       & = 1/2 u^T (A + I) u + (b - x)^T u
$
令其梯度为零
$
  nabla f(u) = (A + I) u + (b - x) = 0 ==> u^* = (A + I)^(-1) (x - b)
$
所以
$
  "prox"_(1/2 x^T A x + b^T x + c) (x) = (A + I)^(-1) (x - b)
$

#prob(
  "T4",
)[
  考虑线性规划问题
  $
    min_(x in RR^n) c^T x, quad "s.t." A x = b, x >= 0
  $
  1. 写出该问题及其对偶问题的 ALM
  2. 分析有限终止性
]
1. 原问题的 ALM 可以写成 (我们把 $x >= 0$ 的约束省略)
$
  L(x, lambda, rho) = c^T x + lambda^T (A x - b) + rho/2 (A x - b)^T (A x - b)
$
原问题的 Lagrangian 为
$
  L(x, lambda, mu) = c^T x + lambda^T (A x - b) - mu^T x
$
其关于 $x$ 的梯度为
$
  nabla_x L(x, lambda, mu) = c + A^T lambda - mu
$
令其等于 $0$, 则有
$
  c + A^T lambda = mu
$
代入 $L(x, lambda)$, 则有
$
  L(lambda) & = c^T x + mu^T x - c^T x - lambda^T b - mu^T x \
            & = -lambda^T b
$
所以我们的对偶问题为
$
  max_lambda quad - lambda^T b, quad c + A^T lambda >= 0
$
为了避免混淆, 我们这里令 $y = lambda$, 则得到对偶问题为
$
  max_y quad - y^T b, quad c + A^T y >= 0
$
为了得到对应的 ALM, 我们需要先改写不等式约束 $c + A^T y >= 0$ 为
$
  c + A^T y = s, quad s >= 0
$
所以有
$
  L(y, lambda, rho) = -y^T b + lambda^T s + rho/2 (c + A^T y - s)^T (c + A^T y - s)
$

2. ALM 在 LP 问题上是有限步终止的.
