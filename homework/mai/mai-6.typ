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
  title: [人工智能数学原理 作业6],
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
    min_(x in RR^2) &quad x_1, \
    "s.t." &quad 16 - (x_1 - 4)^2 - x_2^2 >= 0, \
    &quad x_1^2 + (x_2 - 2)^2 - 4 = 0.
  $
  求出该优化问题的 KKT 点, 并判断它们是否是局部极小点, 鞍点以及全局极小点.
]

第一个约束是一个以 $(4, 0)$ 为圆心, 半径为 $4$ 的闭圆盘; 第二个约束是一个以 $(0, 2)$ 为圆心, 半径为 $2$ 的圆的边界. 它们的交集是一个圆弧, 显然这不是一个凸集.

现在考虑 KKT 条件, 设 Lagrange 函数为
$
  g(x, lambda, mu) = x_1 + lambda (x_1^2 + (x_2 - 2)^2 - 4) + mu (16 - (x_1 - 4)^2 - x_2^2)
$
则 *(1) 梯度条件* 给出
$
  nabla_x g(x, lambda, mu) = vec(1 + 2 lambda x_1 - 2 mu (x_1 - 4), 2 lambda (x_2 - 2) - 2 mu x_2) = 0
$
这意味着
$
  x_1 = (8mu - 1) / (2lambda - 2mu), quad x_2 = (2 lambda) / (lambda - mu)
$
*(2) 原始可行性条件* 给出 $x$ 需要在那个可行的圆弧上;

*(3) 对偶可行性条件* 给出 $mu <= 0$, 因为在不符合约束的时候 $16 - (x_1 - 4)^2 - x_2^2 < 0$

*(4) 驻点互补条件* 给出
$
  mu (16 - (x_1 - 4)^2 - x_2^2) = 0
$

考虑驻点互补条件. 如果 $mu = 0$, 则可行点不在约束边界上, 此时 $x_2 = 2$; 代入第一个约束可得 $x_1 = 0$ 或 $x_1 = 8$. 这两个点都不满足梯度条件, 因此不可能.

另一方面, 如果 $(16 - (x_1 - 4)^2 - x_2^2) = 0$, 则可行点在边界上, 即 $x = (0, 0)$ 或 $x = (8/5, 16/5)$. 这两个点都满足梯度条件. 从图像上可以直观看出 $x = (0, 0)$ 时 $x_1$ 取得极小值 $0$, 所以这两个 KKT 点都是局部极小值点, 但只有 $x = (0, 0)$ 是全局极小点; 它们都不是鞍点.

#showybox(
  title: "T2",
  frame: frameSettings,
)[
  考虑对称矩阵的特征值问题
  $
    min_(x in RR^n) quad x^T A x, quad "s.t." quad norm(x)_2 = 1
  $
  其中 $A in cal(S)^n$. 试分析其所有的局部极小值点, 鞍点以及全局极小点.
]

写出 Lagrange 函数为
$
  g(x, lambda) = x^T A x + lambda (x^T x - 1)
$
则 *(1) 梯度条件* 给出
$
  nabla_x g(x, lambda) = 2 A x + 2 lambda x = 0 ==> A x = - lambda x
$
这意味着 $x$ 是 $A$ 的一个特征向量, 对应的特征值为 $- lambda$;

*(2) 原始可行性条件* 给出 $norm(x)_2 = 1$;

所以我们一共有 $n$ 个 KKT 点, 分别对应 $A$ 的 $n$ 个单位特征向量 $v_1, v_2, ..., v_n$, 它们对应的特征值为 $-lambda_1, -lambda_2, ..., -lambda_n$. 

又因为 Hessian 矩阵为 $A + lambda I = A - lambda_i I$. 因此 $A$ 半正定当且仅当 $A$ 的所有特征值都大于等于 $lambda_i$, 即 $i$ 对应的特征值是所有特征值中的最小值时, 其他情况下, KKT 点 $v_i$ 是鞍点. 

同时因为这个问题是一个约束凸优化问题, 所以所有的局部极小点也是全局极小点. 因此, 结论为: 对应最小特征值的单位特征向量是唯一的全局极小点, 其他单位特征向量都是鞍点.


#showybox(
  title: "T3",
  frame: frameSettings,
)[
  考虑等式约束的最小二乘问题
  $
    min_(x in RR^n) quad norm(A x - b)_2^2, quad "s.t." quad G x = h,
  $
  其中 $A in RR^(m times n)$ 且 $"rank"(A) = n$; $G in RR^(p times n)$ 且 $"rank"(G) = p$.

  (a). 写出该问题的对偶问题; \
  (b). 给出原始问题和对偶问题的最优解的显式表达式.
]

(a). 写出 Lagrange 函数
$
  g(x, lambda) = (A x - b)^T (A x - b) + lambda^T (G x - h), quad lambda in RR^p
$
则 *(1) 梯度条件* 给出
$
  nabla_x g(x, lambda) = 2 A^T A x - 2 A^T b + G^T lambda = 0
$
因为 $A$ 列满秩, 所以 $A^T A$ 可逆, 因此
$
  x = (A^T A)^(-1) (A^T b - 1/2 G^T lambda)
$
如果直接代入 Lagrange 函数, 式子会比较丑陋. 所以我们令原 Lagrange 函数中的 $lambda -> 2 lambda$, 则新的对偶函数为
$
  h(lambda) = g ( (A^T A)^(-1) (A^T b - G^T lambda), lambda ) \
  = - lambda^T G (A^T A)^(-1) G^T lambda + 2( b^T A (A^T A)^(-1) G^T - h^T) lambda \
  + b^T b - b^T A (A^T A)^(-1) A^T b
$
我们把这里面和 $lambda$ 无关的常数项省略掉, 则对偶问题为
$
  max_(lambda in RR^p) quad - lambda^T G (A^T A)^(-1) G^T lambda + 2( b^T A (A^T A)^(-1) G^T - h^T) lambda
$

(b).
考虑原始问题的 KKT 条件, *(1) 梯度条件* 给出 (采用 $2 lambda$ 版本)
$
  x = (A^T A)^(-1) (A^T b -  G^T lambda)
$

*(2) 原始可行性条件* 给出 $G x = h$.

结合这两个条件就有
$
  G x = G (A^T A)^(-1) (A^T b -  G^T lambda) = h \
  lambda = (G (A^T A)^(-1) G^T)^(-1) (G (A^T A)^(-1) A^T b - h)
$
所以对应的 KKT 点为
$
  x^* = (A^T A)^(-1) [A^T b -  G^T [G (A^T A)^(-1) G^T]^(-1) [G (A^T A)^(-1) A^T b - h]]
$

再考虑对偶问题, 这是一个无约束的优化问题, 所以对偶问题的 KKT 条件只有 *(1) 梯度条件*:
$
  nabla_lambda h(lambda) = - 2 G (A^T A)^(-1) G^T lambda + 2( b^T A (A^T A)^(-1) G^T - h^T)^T = 0 \
  ==> lambda^* = (G (A^T A)^(-1) G^T)^(-1) (G (A^T A)^(-1) A^T b - h)
$

#showybox(
  title: "T4",
  frame: frameSettings,
)[
  考虑优化问题
  $
    min_(x in RR, y>0) quad exp(-x), quad "s.t." (x^2)/(y) <= 0.
  $
  (a). 证明这是一个凸优化问题, 求出最小值并判断 Slater 条件是否成立; \
  (b). 写出该问题的对偶问题, 求出对偶问题的最优解以及对偶间隙.
]
(a). 考虑到
$
  x^2 / y <= 0 <==> y < 0 "or" (y > 0 "and" x = 0)
$
考虑到 $y > 0$, 所以可行域为 $x = 0, y> 0$. 这是一个凸集. 同时目标函数 $exp(-x)$ 是一个凸函数, 因此这是一个凸优化问题. 其最小值显然为 $1$, 取到最小值的点为 $(0, y), y > 0$.

但是原问题不满足 Slater 条件, 可行域 $x = 0, y > 0$ 的仿射包为 $x = 0$, 在 $x = 0$ 这条直线上不存在一个点能严格满足约束条件 $x^2/y < 0$.

(b). 写出 Lagrange 函数
$
  g(x, y, lambda) = exp(-x) + lambda  (x^2 / y), quad lambda >= 0
$
则有
$
  h(lambda) &= inf_(x in RR, y > 0) g(x, y, lambda) \
  &= inf_(x in RR) [ exp(-x) + lambda x^2 inf_(y > 0) (1/y) ] \
$
这里有两项, 第一项 $inf_(x in RR) exp(-x)$ 在 $x -> +oo$ 时取得 $0$; 第二项 $lambda x^2 inf_(y > 0) (1/y)$ 在 $y -> +oo$ 时取得 $0$. 所以 $h(lambda) >= 0$. 我们考虑令 $y = x^3$, 则当 $x -> +oo$ 时, 有
$
  h(lambda) = 0 + inf_(x -> oo) lambda x^2 /x^3 = 0.
$
所以对偶问题的最优值为 $0$. 因此对偶间隙为 $1 - 0 = 1$.
