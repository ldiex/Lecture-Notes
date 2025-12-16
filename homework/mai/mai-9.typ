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
  title: [人工智能数学原理 作业9],
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

#let prob(title, body) = showybox(
  title: title,
  frame: frameSettings, 
  body
)

#prob(
  "T1"
)[  
  使用步长为 $1$ 的经典牛顿算法求解优化问题:
  $
    min_(x in (t_1, t_2)) f(x) = t_1^4 + t_1^2 + t_2^2
  $
  选取初始点 $x^0 = (epsilon, epsilon)^T$, 其中 $epsilon > 0$ 充分小. 计算下一步迭代, 并证明 $norm(x^1)_2 = O(epsilon^3)$.
]
我们先计算 $f(t_1, t_2)$ 的梯度:
$
  nabla f(t_1, t_2) = mat(
    delim: "[",
    4 t_1^3 + 2 t_1;
    2 t_2
  )
$
于是有
$
  nabla f(x^0) = mat(
    delim: "[",
    4 epsilon^3 + 2 epsilon;
    2 epsilon
  )
$
进一步计算 Hessian 矩阵:
$
  H(t_1, t_2) = mat(
    delim: "[",
    12 t_1^2 + 2, 0;
    0, 2
  )
$
从而
$
  H(x^0) = mat(
    delim: "[",
    12 epsilon^2 + 2, 0;
    0, 2
  )
$
由此可以计算 Newton 方向:
$
  d^0 = - (H(x^0))^(-1) nabla f(x^0) = mat(
    delim: "[",
    - (2 epsilon^3 + 1 epsilon) / (6 epsilon^2 + 1);
    - epsilon
  )
$
由此可以计算下一步的迭代点 $x^1$:
$
  x^1 = x^0 + d^0 = mat(
    delim: "[",
    epsilon - (2 epsilon^3 + 1 epsilon) / (6 epsilon^2 + 1);
    0
  ) = mat(
    delim: "[",
    (4 epsilon^3) / (6 epsilon^2 + 1);
    0
  )
$
下面证明 $norm(x^1)_2 = O(epsilon^3)$, 首先
$
  norm(x^1)_2 = abs((4 epsilon^3) / (6 epsilon^2 + 1)) = (4 epsilon^3) / (6 epsilon^2 + 1) <= 4 epsilon^3, quad forall epsilon > 0
$
所以 $norm(x^1)_2 = O(epsilon^3)$ 得证.


#prob(
  "T2"
)[
  使用拟牛顿法结合精确线搜索求解优化问题:
  $
    min f(x) = x_1^2 + 2 x_2^2
  $
  选取初始点 $x^0 = (1, 1)^T$ 和初始 Hessian 近似矩阵 $B_0 = I$. 分别用 BFGS 和 DFP 更新公式计算 $B_1$ 和 $B_2$.
]

首先计算目标函数的梯度 $nabla f(x) = (2 x_1, 4 x_2)^T$ 及精确 Hessian 矩阵 $H = "diag"(2, 4)$.

对于初始点 $x^0 = (1, 1)^T$ 和 $B_0 = I$:
$
  g_0 = nabla f(x^0) = mat(delim: "[", 2; 4), quad d^0 = -B_0^(-1) g_0 = mat(delim: "[", -2; -4)
$
进行精确线搜索 $min_(alpha) f(x^0 + alpha d^0)$, 解得步长 $alpha_0 = 5/18$.
由此计算 $x^1$ 以及差量向量 $s_0, y_0$:
$
  x^1 &= x^0 + alpha_0 d^0 = mat(delim: "[", 4/9; -1/9) \
  s_0 &= x^1 - x^0 = mat(delim: "[", -5/9; -10/9), quad
  y_0 &= nabla f(x^1) - g_0 = mat(delim: "[", -10/9; -40/9)
$
此时有关键标量 $y_0^T s_0 = 50/9$.

*1. BFGS 更新*

根据 BFGS 更新公式 $B_(k+1) = B_k + (y_k y_k^T)/(y_k^T s_k) - (B_k s_k s_k^T B_k)/(s_k^T B_k s_k)$, 代入上述向量计算得:
$
  B_1 = 1/45 mat(
    delim: "[",
    46, 22;
    22, 169
  )
$
由于目标函数是二次函数且采用精确线搜索, 拟牛顿法具有二次终止性, 经过 $n=2$ 步迭代后 $B_n$ 将收敛于精确 Hessian 矩阵:
$
  B_2 = H = mat(
    delim: "[",
    2, 0;
    0, 4
  )
$

*2. DFP 更新*

根据 DFP 更新公式 $B_(k+1) = (I - (y_k s_k^T)/(y_k^T s_k)) B_k (I - (s_k y_k^T)/(y_k^T s_k)) + (y_k y_k^T)/(y_k^T s_k)$, 计算得:
$
  B_1 = 1/81 mat(
    delim: "[",
    86, 38;
    38, 305
  )
$
同理, 由二次终止性直接可知:
$
  B_2 = H = mat(
    delim: "[",
    2, 0;
    0, 4
  )
$

#prob(
  "T3"
)[
  仿照 BFGS 公式的推导过程, 利用待定系数法推导
  $
    H^(k+1) = H^k - (H^k y^k (H^k y^k)^T) / ((y^k)^T H^k y^k) + (s^k (s^k)^T) / ((y^k)^T s^k)
  $
]

我们假设 $H^(k+1)$ 是在 $H_k$ 的基础上加上两个秩为一的修正项:
$
  H_(k + 1) = H_k + alpha u u^T + beta v v^T
$
其中 $u, v$ 是待定向量, $alpha, beta$ 是待定系数. 根据拟牛顿条件 $H_(k+1) y^k = s^k$, 为了凑出 $s_k$ 并且消去 $H_k y_k$, 我们令 $u = s_k$ 且 $v = H_k y_k$. 则有
$
  H_(k + 1) y^k = H_k y^k + alpha s^k (s^k)^T y^k + beta H_k y^k (y^k)^T H_k y^k = s_k
$
按照包含 $s_k$ 和 $H_k y_k$ 的项整理, 得到
$
(a (s_k^T y_k) - 1) s_k + (b (y_k^T H_k y_k) + 1) H_k y_k = 0
$
令系数分别为零, 可解得
$
  alpha = 1 / (y_k^T s_k), quad beta = -1 / (y_k^T H_k y_k)
$
代回 $H_(k + 1)$ 的表达式, 即得到所需的更新公式:
$
  H^(k+1) = H^k - (H^k y^k (H^k y^k)^T) / ((y^k)^T H^k y^k) + (s^k (s^k)^T) / ((y^k)^T s^k)
$

#prob(
  "T4"
)[
  用二次罚函数法求解问题
  $
    min quad (x_1 - 3)^2 + (x_2 -2)^2, quad "s.t." 4 - x_1 - x_2 >= 0
  $
]
我们构造罚函数为
$
  F(x, M_k) = (x_1 - 3)^2 + (x_2 -2)^2 + M_k / 2 [max(0, x_1 + x_2 - 4)]^2
$
假设约束被违反, 那么
$
  F(x, M_k) = (x_1 - 3)^2 + (x_2 -2)^2 + M_k / 2 (x_1 + x_2 - 4)^2
$
计算偏导数
$
  (partial F) / (partial x_1) = 2 (x_1 - 3) + M_k (x_1 + x_2 - 4), \  (partial F) / (partial x_2) = 2 (x_2 - 2) + M_k (x_1 + x_2 - 4)
$
可以解得
$
  x_1 = (5 M_k + 6) / (2 (M_k + 1)), quad x_2 = (3 M_k + 4) / (2 (M_k + 1))
$
当 $M_k -> oo$, 有
$
  lim_(M_k -> oo) x_1 = 5/2, quad lim_(M_k -> oo) x_2 = 3/2
$
检查 $x_1, x_2$ 此时都满足约束条件, 因此问题的最优解为
$
  (x_1^*, x_2^*) = (5/2, 3/2)
$

#prob(
  "T5"
)[
  用对数罚函数内点发求解问题
  $
    min quad 1/2 (x_1 + 1)^2 + x_2, quad "s.t." x_1 >= 1, thin x_2 >= 0.
  $
]
构造罚函数为
$
  B(x, mu) = 1/2 (x_1 + 1)^2 + x_2 - mu (ln(x_1 - 1) + ln x_2)
$
分别对 $x_1, x_2$ 求偏导数:
$
  (partial B) / (partial x_1) = x_1 + 1 - mu / (x_1 - 1), \  (partial B) / (partial x_2) = 1 - mu / x_2
$
令偏导数为零, 可解得
$
  x_1 = sqrt(1 + mu), quad x_2 = mu
$
令 $mu -> 0$, 则有
$
  lim_(mu -> 0) x_1 = 1, quad lim_(mu -> 0) x_2 = 0
$
验证 此时 $x_1, x_2$ 满足约束条件, 因此问题的最优解为
$
  (x_1^*, x_2^*) = (1, 0)
$

#prob(
  "T6"
)[
  考虑等式约束优化问题:
  $
    min quad -x_1 x_2 x_3, quad "s.t." x_1 + 2 x_2 + 3 x_3 = 60.
  $
  使用二次罚函数求解该问题, 当固定罚因子 $sigma_k$ 时, 写出二次罚函数的最优解 $x_(k + 1)$. 当 $sigma_k -> oo$ 时, 写出该优化问题的解并求出约束的 Lagrange 乘子.
]
构造罚函数为
$
  P(x, sigma_k) = -x_1 x_2 x_3 + sigma_k / 2 (x_1 + 2 x_2 + 3 x_3 - 60)^2
$
分别对 $x_1, x_2, x_3$ 求偏导数:
$
  (partial P) / (partial x_1) = -x_2 x_3 + sigma_k (x_1 + 2 x_2 + 3 x_3 - 60), \
  (partial P) / (partial x_2) = -x_1 x_3 + 2 sigma_k (x_1 + 2 x_2 + 3 x_3 - 60), \
  (partial P) / (partial x_3) = -x_1 x_2 + 3 sigma_k (x_1 + 2 x_2 + 3 x_3 - 60)
$
设
$
  R = sigma_k (x_1 + 2 x_2 + 3 x_3 - 60)
$
则我们需要解方程组
$
  -x_2 x_3 + R = 0, \
  -x_1 x_3 + 2 R = 0, \
  -x_1 x_2 + 3 R = 0
$
假设 $x_1 != 0$, 那么就有 $x_2 = 1/2 x_1$, $x_3 = 1/3 x_1$. 代入约束条件得
$
  R = sigma_k (3x_1 - 60) 
$
从而由 $R = x_2 x_3$ 得到
$
  x_1^2/6 = sigma_k (3x_1 - 60) => x_1^2 - 18 sigma_k x_1 + 360 sigma_k = 0
$
它的两个解分别为
$
  x_1 = 9 sigma_k plus.minus 3 sqrt(3 sigma_k (3 sigma_k - 40))
$
显然取 "$+$" 在 $sigma_k -> oo$ 时不收敛, 因此我们取 "$-$" 解. 于是有
$
  x_1 = 9 sigma_k - 3 sqrt(3 sigma_k (3 sigma_k - 40)), \
  x_2 = 1/2 x_1 = 9/2 sigma_k - 3/2 sqrt(3 sigma_k (3 sigma_k - 40)), \
  x_3 = 1/3 x_1 = 3 sigma_k - sqrt(3 sigma_k (3 sigma_k - 40))
$
当 $sigma_k -> oo$ 时, 有
$
  x_1 &= lim_(sigma_k -> oo) (9 sigma_k - 3 sqrt(3 sigma_k (3 sigma_k - 40))) \
  &= lim_(sigma_k -> oo) ((9 sigma_k)^2 - (81 sigma_k^2 - 360 sigma_k))/(9 sigma_k + sqrt(81 sigma_k^2 - 360 sigma_k)) \
  &= lim_(sigma_k -> oo) 360 sigma_k / (9 sigma_k + 9 sigma_k) = 20
$
从而得到最优解
$
  (x_1^*, x_2^*, x_3^*) = (20, 10, 20 / 3)
$
最后, 为了求解 约束的 Lagrange 乘子, 考虑 KKT 条件
$
  nabla f(x^*) + lambda^* nabla h(x^*) = 0
$
这里我们有
$
  nabla f(x) = mat(
    delim: "[",
    -x_2 x_3;
    -x_1 x_3;
    -x_1 x_2
  ), quad
  nabla h(x) = mat(
    delim: "[",
    1;
    2;
    3
  )
$
代入 $x^*$ 可得
$
  lambda^* = 200 / 3
$

#prob(
  "T7"
)[
  构造一个等式约束优化问题, 使得它存在一个局部极小值, 但对于任意的 $sigma > 0$, 它的二次罚函数是无界的.
]

考虑一个一维的优化问题
$
  min_(x in RR) quad f(x) = x^2 - x^4, quad "s.t." x = 0
$
这个问题肯定有一个局部极小值 $x^* = 0$, 因为它的可行域只有一个点. 但是它的二次罚函数为
$
  P(x, sigma) = x^2 - x^4 + sigma / 2 x^2 = (1 + sigma / 2) x^2 - x^4
$
对于 $forall sigma$, 当 $x -> plus.minus oo$, 有 $P(x, sigma) -> -oo$, 因此二次罚函数是无界的.