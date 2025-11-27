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
  title: [人工智能数学原理 作业7],
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

#showybox(
  title: "T1",
  frame: frameSettings,
)[
  设 $f(x)$ 是连续可微函数, $d^k$ 是一个下降方向, 且 $f(x)$ 在射线 ${x^k + alpha d^k | alpha > 0}$ 上有下界. 求证: 当 $0 < c_1 < c_2 < 1$ 时, 总是存在满足 Wolfe 准则的点. 并举一个反例说明当 $0 < c_2 < c_1 < 1$ 时, 满足 Wolfe 准则的点不一定存在.
]

令 $phi(alpha) = f(x^k + alpha d^k)$, 则 $phi(0) = f(x^k)$, 且由于 $d^k$ 是下降方向, 有 $phi'(0) = nabla f(x^k)^T d^k < 0$. 则我们需要证明, 当 $0 < c_1 < c_2 < 1$ 时, 存在 $alpha > 0$ 使得
$
   phi(alpha) & <= phi(0) + c_1 alpha phi'(0), \
  phi'(alpha) & >= c_2 phi'(0).
$
按照题意, 我们 $phi(alpha)$ 在 $alpha > 0$ 上有一个下界, 我们设其为 $M$. 又因为 $alpha > 0$ 且 $phi'(0) < 0$, 所以 $phi(0) + c_1 alpha phi'(0)$ 随着 $alpha$ 的增大而单调减小, 并且当 $alpha$ 足够大时, 有 $phi(0) + c_1 alpha phi'(0) < M$. 因此, 根据介值定理, 存在最小的 $alpha_1 > 0$ 使得
$
  phi(alpha_1) = phi(0) + c_1 alpha_1 phi'(0).
$
且我们在 $alpha in [0, alpha_1]$ 时满足 Wolfe 条件的第一个不等式.

我们再在 $(0, alpha_1)$ 上使用 Lagrange 中值定理, 则存在 $alpha_2 in (0, alpha_1)$ 使得
$
  phi'(alpha_2) = (phi(alpha_1) - phi(0)) / alpha_1 = c_1 phi'(0).
$
由于 $c_1 < c_2$ 且 $phi'(0) < 0$, 所以 $phi'(alpha_2) = c_1 phi'(0) > c_2 phi'(0)$, 因此我们找到了一个满足 Wolfe 条件的点 $alpha_2$.

另一方面, 如果 $0 < c_2 < c_1 < 1$, 考虑二次凸函数
$
  phi(alpha) = 1/2 alpha^2 - 2alpha ==> phi'(alpha) = alpha - 2.
$
则有 $phi(0) = 0$, $phi'(0) = -2$. 若存在 $alpha > 0$ 满足 Wolfe 条件, 则有
$
  1/2 alpha^2 - 2alpha & <= -2 c_1 alpha \
             alpha - 2 & >= -2 c_2
$
令 $c_1 = 0.75, c_2 = 0.25$, 则上式化简为
$
  alpha^2 - 0.5 alpha & <= 0 \
                alpha & >= 1.5
$
显然上式无解, 因此不存在满足 Wolfe 条件的点.


#showybox(
  title: "T2",
  frame: frameSettings,
)[
  $f$ 为正定二次函数 $f(x) = 1/2 x^T A x + b^T x$, $d^k$ 为下降方向, $x^k$ 为当前迭代点. 试求出精确线搜索步长
  $
    a_k = arg min_(alpha > 0) f(x^k + alpha d^k)
  $
  并且由此推出最速下降时的步长满足
  $
    alpha_k = norm(nabla f(x^k))^2 / (nabla f(x^k)^T A nabla f(x^k))
  $
]

设
$
  g(alpha) = f(x^k + alpha d^k) = 1/2 (x^k + alpha d^k)^T A (x^k + alpha d^k) + b^T (x^k + alpha d^k)
$
则求梯度有
$
  nabla_alpha g(alpha) = (x^k + alpha d^k)^T A d^k + b^T d^k
$
令 $nabla_alpha g(alpha) = 0$, 则有
$
  alpha (d^k)^T A d^k + (x^k)^T A d^k + b^T d^k = 0
$
因此
$
  alpha = - ((x^k)^T A d^k + b^T d^k) / ((d^k)^T A d^k)
$
又因为 $nabla f(x^k) = A x^k + b$, 且在最速下降时 $d^k = - nabla f(x^k)$, 所以
$
  norm(nabla f(x^k))^2 = (A x^k + b)^T (A x^k + b) = - (A x^k + b)^T d_k \
  nabla f(x^k)^T A nabla f(x^k) = (A x^k + b)^T A (A x^k + b) = (d^k)^T A d_k
$
因此我们就有 $alpha_k = norm(nabla f(x^k))^2 / (nabla f(x^k)^T A nabla f(x^k))$.

#showybox(
  title: "T3",
  frame: frameSettings,
)[
  假设算法 $cal(A)$ 产生了迭代点序列 ${x^1, x^2, dots, x^T, dots}$, (不严格地) 称 $cal(A)$ 具有 last-iterate convergence 性质, 当在 $T$ 次迭代后可以对 $x_T$ 证明其收敛性 (如点列收敛性或者函数值收敛性, etc.) 对于光滑凸函数, 梯度下降法具有 last-iterate convergence 性质, 这依赖于不等式 $f(x^(k + 1)) <= f(x^k) - alpha/2 norm(nabla f(x^k))^2$ 表明 $f(x^(k + 1)) <= f(x^k)$, 从而方法是单调的. 但即使对非单调方法 (比如随机梯度类方法), 也可以在期望的意义下证明 $sum_(t = 1)^T {f(x^t) - f^*} <= C$, 其中 $C$ 可能依赖于 $x_0, x^*, L$ 等量. 请回答以下问题:

  1. 在上述不等式的基础下, 对非单调方法, 不依赖与其他知识, 可以方便地得到 $x_T$ 的收敛性吗?
  2. 假设额外存储了当且所有迭代点 ${x^1, x^2, ..., x^T}$ 和它们的函数值 ${f(x^1), f(x^2), ..., f(x^T)}$ 的信息, 请根据此知识构造输出点 $x_"output"$, 使得基于上述不等式可以推出 $f(x_"output") - f^* <= C / T$.
  3. 考虑目标函数具有有限和形式 $f(x) = sum_(i = 1)^n f_i (x)$, 其中 $f_i (x)$ 是光滑凸函数. 此时计算一个点的函数值需要计算 $n$ 个分量函数的函数值, 带来很大的计算负担. 在上述目标函数设定下, 假设只额外存储了当前所有迭代点信息 ${x^1, x^2, ..., x^T}$, 请根据此知识构造输出点 $x_"output"$, 使得基于上述不等式可以推出 $f(x_"output") - f^* <= C / T$.
  4. 出于不同的原因, last-iterate convergence在许多问题中相较于其他类型的收敛性更受欢迎, 根据上述几个问题和你的直觉, 谈谈它的(可能的)优点.
]

1. 不能. 不等式 $sum_(t = 1)^T {f(x^t) - f^*} <= C$ 只控制了所有迭代点函数值的平均误差, 类似于控制了一个序列的 $L_1$ 范数, 在这个约束下 $f(x^t) - f^*$ 必须在整体趋势上衰减, 但它并不禁止序列在尾部出现剧烈的震荡.

2. 直接选函数值最小的那一个点, 令 $x_"output" = arg min_(t = 1)^T {f(x^t)}$, 则显然有
$
  f(x_"output") - f^* = min_t {f(x^t) - f^*} <= 1/T sum_(t = 1)^T {f(x^t) - f^*} <= C / T
$

3. 选择历史 $T$ 个点的平均值, 令 $x_"output" = 1/T sum_(t = 1)^T {x^t}$, 则利用 Jenson 不等式, 有
$
  f(x_"output") - f^* <= 1/T sum_(t = 1)^T {f(x^t) - f^*} <= C / T
$

4. 因为 last-iterate 的存储空间开销小, 历史最优点需要保存所有历史迭代点, 在大规模问题中不现实; 而 last-iterate 只需要保存当前状态. 且平均点在图像生成任务中容易收敛到一个模糊的结果.

