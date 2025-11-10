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
  title: [人工智能数学原理 作业5],
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

#showybox(
  title: "T1",
  frame: frameSettings,
)[
  考虑优化问题
  $
    min_(x in RR^n)  quad x^T A x + 2 b^T x
  $
  其中 $A in cal(S)^n, b in RR^n$. 为了保证该问题最优解存在, $A, b$ 需要满足什么性质?
]

首先 $A$ 起码是半正定的, 否则当 $x$ 趋向于某个方向的无穷远处时, $x^T A x$ 会趋向于负无穷, 导致目标函数无下界. 在 $A$ 为半正定的前提下, 我们对 $x$ 求导有
$
 dif f =  x^T A dif x + dif x^T A x + 2b^T dif x = 2 dif x^T A x + 2 dif x^T b \
 ==> nabla f = 2 A x + 2 b
$
如果该问题有最优解, 那么方程 $dif f = 0$ 即 $A x + b = 0$ 必须有解, 否则 $b^T x$ 项可以使目标函数趋向于负无穷. 因此 $-b$ 必须在 $A$ 的像空间内, 即 $b in "Im" A$. 

综上, 为了保证该问题最优解存在, $A$ 需要是半正定的, 且 $b in "Im" A$.

#showybox(
  title: "T2",
  frame: frameSettings,
)[
  考虑函数 $f(x) = 2x_1^2 + x_2^2 - 2x_1 x_2 + 2x_1^3 + x_1^4$. 求出其所有一阶稳定点, 并判断它们是否为局部最优点 (极小或极大), 鞍点或全局最优点?
]

先求一阶偏导数
- $(partial f)/(partial x_1) = 4 x_1 - 2x_2 + 6 x_1^2 + 4 x_1^3 = 0$
- $(partial f)/(partial x_2) = 2 x_2 - 2 x_1 = 0$

联立, 有
$
  2 x_1 + 6 x_1^2 + 4 x_1^3 = 0 ==> x_1 = 0, -1, -1/2
$
所以一阶稳定点为 $P_1 = (0, 0), P_2 = (-1, -1), P_3 = (-1/2, -1/2)$.

我们再求 Hessian 矩阵
$
  mat(delim: "[",
    (partial^2 f)/(partial x_1^2), (partial^2 f)/(partial x_1 partial x_2);
    (partial^2 f)/(partial x_2 partial x_1), (partial^2 f)/(partial x_2^2)
  ) = mat(delim: "[",
    4 + 12 x_1 + 12 x_1^2, -2;
    -2, 2
  )
$

1. 在 $P_1$ 处, Hessian 矩阵为 $mat(delim: "[",
    4, -2;
    -2, 2
  )$, 其特征方程为 $det(H - lambda I) = 0 ==> lambda^2 - 6 lambda + 4 = 0$, 可以解得 $lambda = (6 plus.minus sqrt(36 - 16))/2 = 3 plus.minus sqrt(5) > 0$. 因此 $H$ 正定, $P_1$ 是局部极小点.

2. 在 $P_2$ 处, Hessian 矩阵为 $mat(delim: "[",
    4 - 12 + 12, -2;
    -2, 2
  ) = mat(delim: "[",
    4, -2;
    -2, 2
  )$, 与 $P_1$ 处的 Hessian 矩阵相同, 因此 $P_2$ 也是局部极小点.

3. 在 $P_3$ 处, Hessian 矩阵为 $mat(delim: "[",
    4 - 6 + 3, -2;
    -2, 2
  ) = mat(delim: "[",
    1, -2;
    -2, 2
  )$, 其特征方程为 $det(H - lambda I) = 0 ==> lambda^2 - 3 lambda - 2 = 0$, 可以解得 $lambda = (3 plus.minus sqrt(9 + 8))/2 = (3 plus.minus sqrt(17))/2$. 因为 $sqrt(17) > 4$, 所以有一个特征值为正, 一个特征值为负, 因此 $H$ 为不定矩阵, $P_3$ 是鞍点.

现在我们考虑全局最优点. 因为代入 $P_1$ 和 $P_2$ 都得到 $f(P_1) = f(P_2) = 0$, 而代入 $P_3$ 得到 $f(P_3) = 2(-1/2)^4 + (-1/2)^2 - 2(-1/2)(-1/2) + 2(-1/2)^3 + 2(-1/2)^4 = 1/8 + 1/4 - 1/2 + 1/4 + 1/8 = 1/4$. 所以 $P_1$ 和 $P_2$ 都是全局最小点, 而 $P_3$ 只是鞍点.

#showybox(
  title: "T3",
  frame: frameSettings,
)[
  计算下列优化问题的对偶问题.

  (a) $min_(x in RR^n) norm(x)_1, quad "s.t." A x = b$

  (b) $min_(x in RR^n) norm(A x - b)_1$

  (c) $min_(x in RR^n) norm(A x - b)_oo$
]

*(a)*. 原问题可以改写为
$
  min_(x in RR^n, t in RR^m) sum_(i = 1)^m t_i, quad "s.t." A x = b, -t_i <= x_i <= t_i, i = 1, 2, ..., m
$
