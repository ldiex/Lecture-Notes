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
  title: [人工智能数学原理 作业8],
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
  "T1",
)[
  在次梯度方法中, 要从迭代点的次微分中选取一个次梯度作为迭代方向. 请回答以下问题: \
  *(1)* 考虑函数 $f: RR^n -> RR$ 具有表达式 $f(x) = norm(x)_1$. 证明 $partial f(0) = [-1, 1]^n$. \
  *(2)* 考虑非空集合 $S subset RR^n$ 的指示函数 $f(x) = delta_S (x)$, 求其在任意一点 $z in S$ 上的次微分集 $partial f(z)$. \
  *(3)* 考虑任意一个恰当函数 $f: RR^n -> RR$, 证明对任意的 $x in RR^n$, 次微分 $partial f(x)$ 都是闭且凸的.
]

*(1)* 根据次微分的定义, 对于 $forall g in partial f(0)$, 需要满足
$
  f(y) >= f(0) + g^T (y - 0), quad forall y in RR^n.
$
也就是
$
  sum_(i = 1)^n |y_i| >= sum_(i = 1)^n g_i y_i, quad forall y in RR^n.
$
显然任意 $g in [-1, 1]^n$ 都满足上述不等式. 反过来, 若存在某个 $g in.not [-1, 1]^n$, 则存在某个分量 $g_j$ 满足 $|g_j| > 1$. 不失一般性, 设 $g_1 > 1$, 则取 $y$ 使得 $y_1 -> +oo$ 且其他分量为零, 则条件变成
$
  |y_1| >= g_1 y_1 <==> y_1 >= g_1 y_1 <==> 1 >= g_1
$
这与 $g_1 > 1$ 矛盾. 因此 $partial f(0) = [-1, 1]^n$.

*(2)* 回顾指示函数的定义,
$
  delta_S (x) = cases(
    0 \, quad x in S,
    +oo \, quad x in.not S.
  )
$
由于 $z in S$, 所以 $f(z) = 0$. 根据次微分的定义, 对于 $forall g in partial f(z)$, 需要满足
$
  delta_S (y) >= g^T (y - z), quad forall y in RR^n.
$
当 $y in S$ 时, 这要求
$
  0 >= g^T (y - z), quad forall y in S.
$
当 $y in.not S$ 时, 该不等式总是成立. 因此, 我们有
$
  partial f(z) = { g in RR^n | g^T (y - z) <= 0, quad forall y in S }.
$

*(3)* 先证明凸性. 设 $g_1, g_2 in partial f(x)$, 则对任意 $y in RR^n$, 有
$
  f(y) >= f(x) + g_1^T (y - x), \
  f(y) >= f(x) + g_2^T (y - x).
$
那么对任意 $theta in [0, 1]$, 把第一个不等式乘以 $theta$, 第二个不等式乘以 $1 - theta$ 并相加, 可得
$
  f(y) >= f(x) + [theta g_1 + (1 - theta) g_2]^T (y - x),
$
因此 $theta g_1 + (1 - theta) g_2 in partial f(x)$, 说明 $partial f(x)$ 是凸的.

再证明闭性. 设 ${g_k}$ 是 $partial f(x)$ 中的一个收敛序列, 且 $g_k -> g$. 则对任意 $y in RR^n$, 有
$
  f(y) >= f(x) + g_k^T (y - x).
$
两边去极限, 因为内积是连续的, 可得
$
  f(y) >= f(x) + g^T (y - x).
$
所以 $g in partial f(x)$, 说明 $partial f(x)$ 是闭的.

#prob(
  "T2",
)[
  不可微函数无法保证点点梯度存在, 梯度法不适合于不可微优化问题. 次梯度法作为求解不可微优化问题的方法, 我们对其的一个基本要求自然是, 它应当在每个(可能的)迭代点上都能取到次梯度, 即次微分不是空集. 请回答以下问题:

  *(1)* 在分析次梯度法收敛性时, 要求了目标函数的凸性, 这个假设是否太强? 从上述基本要求出发, 某种程度上可说明该假设的必要性. 考虑恰当函数 $f: RR^n -> (-oo, oo]$ 且 $"dom" (f)$ 是凸集. 若对于任意 $x in "dom" (f)$, 次微分 $partial f(x)$ 非空, 证明 $f$ 是凸函数. (提示: 在合适的点上利用次梯度的定义不等式, 从所关心的点出发, 恰当地构造所谓合适的点.)

  *(2)* 以上结论说明在上述基本要求下, 目标的凸性在某种程度上是必要的, 但反之, 仅要求凸性是否可以满足基本要求呢? 考虑恰当凸函数 $f: RR^n -> (-oo, oo]$, 其表达式为
  $
    f(x) = cases(
      -sqrt(x) \, quad x >= 0,
      +oo, \, quad x < 0.
    )
  $
  证明 $partial f(0) = emptyset$.

  *(3)* 将投影次梯度法应用于优化问题 $min {f(x), x in C}$ 时, 需要作若干个假设. 其中不仅假设 $f$ 的凸性, 也假设 $C subset "int"("dom" f)$. 该假设是为了保证上述基本要求的成立. 在基本要求得到保证的前提下, 这个假设是否可以去掉? 请说明你回答的理由.
]

*(1)* 设任意 $x, y in "dom" (f)$, $theta in [0, 1]$, 令 $z = theta x + (1 - theta) y$. 我们需要证明:
$
  f(z) <= theta f(x) + (1 - theta) f(y).
$
考虑到 $"dom" (f)$ 是凸集, 所以 $z in "dom" (f)$, 因此 $partial f(z)$ 非空. 取 $g in partial f(z)$, 则根据次梯度的定义, 对于 $forall v in "dom" (f)$, 有
$
  f(v) >= f(z) + g^T (v - z).
$
我们分别代入 $x, y$, 可得
$
  f(x) >= f(z) + g^T (x - z), \
  f(y) >= f(z) + g^T (y - z).
$
将上面两个不等式分别乘以 $theta, (1 - theta)$ 并相加, 可得
$
  theta f(x) + (1 - theta) f(y) >= f(z) + g^T [theta (x - z) + (1 - theta) (y - z)] = f(z),
$
因此 $f(z) <= theta f(x) + (1 - theta) f(y)$, 说明 $f$ 是凸函数.

*(2)* 根据次微分的定义, 对于 $forall g in partial f(0)$, 需要满足
$
  f(y) >= f(0) + g (y - 0), quad forall y in RR.
$
限制 $y >= 0$, 则有
$
  -sqrt(y) >= 0 + g y, quad forall y >= 0.
$
取 $y -> 0^+$, 可得
$
  g <= lim_(y -> 0^+) (-sqrt(y) / y) = -oo.
$
实数域中不存在这样的 $g$, 因此 $partial f(0) = emptyset$.

*(3)* 这个假设不能去掉. 因为 (2) 中的例子说明, 即使目标函数是凸的, 它定义域的边界上的点也可能不存在次梯度. 若迭代点落在定义域的边界上, 则无法选取次梯度作为迭代方向, 次梯度法无法进行下去.

#prob(
  "T3",
)[
  之前的作业中我们考虑了次梯度法的执行和分析假设方面的一些问题, 有了上述准备, 次梯度法是良定义且可切实执行的, 它具有一些不同于梯度法的性质. 比如, 次梯度方向未必是下降方向. 考虑 $f: RR times RR -> RR$, 其表达式为
  $
    f(x_1, x_2) = abs(x_1) + 2 abs(x_2).
  $
  证明 $partial f(1, 0) = {(1, x) | x in [-2, 2]}$, 并从中找到一个次梯度 $g$, 使得对于任意的 $alpha > 0$, 都有
  $
    f((1, 0) - alpha g) > f(1, 0).
  $
]
注意到 $f(x_1, x_2)$ 可以分离变量:
$
  f(x_1, x_2) = f_1(x_1) + f_2(x_2), quad f_1(t) = abs(t), quad f_2(t) = 2 abs(t).
$
考虑 $x_1 = 1$, 这时 $f_1(t)$ 在 $t = 1$ 处可微, 所以
$
  partial f_1(1) = partial_t t = {1}.
$
考虑 $x_2 = 0$, 这时根据 (1) 的结论, 有
$
  partial f_2(0) = partial_t 2 abs(t) = 2 partial_t abs(t) = 2 [-1, 1] = [-2, 2].
$
所以 $f$ 在 $(1, 0)$ 处的次微分就是这两者的笛卡尔积:
$
  partial f(1, 0) = {1} times [-2, 2] = {(1, x) | x in [-2, 2]}.
$
命题得证.

对于反例, 我们取 $g = (1, 2)$. 和方向 $-g$ 进行移动, 则对于任意 $alpha > 0$, 目标点为
$
  (1, 0) - alpha g = (1 - alpha, -2 alpha).
$
所以
$
  f((1, 0) - alpha g) = abs(1 - alpha) + 2 abs(-2 alpha)  = abs(1 - alpha) + 4 alpha.
$
当 $0 < alpha < 1$ 时, 有
$
  f((1, 0) - alpha g) = 1 - alpha + 4 alpha = 1 + 3 alpha > 1 = f(1, 0).
$
当 $alpha >= 1$ 时, 有
$
  f((1, 0) - alpha g) = alpha - 1 + 4 alpha = 5 alpha - 1 >= 4 > 1 = f(1, 0).
$
因此对于任意的 $alpha > 0$, 都有
$
    f((1, 0) - alpha g) > f(1, 0).    
$

#prob(
  "T4",
)[
  补全经典牛顿法的收敛性证明.
]
根据 Banach 引理, 对于可逆矩阵 $A$ 和差值矩阵 $E$, 若 $norm(A^{-1} E) < 1$, 则 $B = A + E$ 也是可逆的, 且
$
  norm(B^(-1)) <= norm(A^(-1)) / (1 - norm(A^(-1) E)).
$
为了得到课件中的结论, 我们只需要控制
$
  norm(A^(-1) E) <= 1/2
$
考虑到范数的性质, 我们可以加强为
$
  norm(A^(-1) E) <= norm(A^(-1)) norm(E) < 1/2.
$
也就是
$
  norm(nabla^2 f(x) - nabla^2 f(x^*)) < 1 / (2 norm(nabla^2 f(x^*)^(-1))).
$
因为 Hessian 矩阵是连续的, 所以存在某个 $delta > 0$, 当 $norm(x - x^*) < delta$ 时, 上述不等式成立. 由此可得 $nabla^2 f(x)$ 在该邻域内均为可逆矩阵, 且
$
  norm(nabla^2 f(x)^(-1)) <= 2 norm(nabla^2 f(x^*)^(-1)).
$
