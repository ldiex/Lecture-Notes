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
  title: [人工智能数学原理 作业4],
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
  将下面的问题转化为线性规划: 给定 $A in RR^(m times n)$, $b in RR^m$,

  (a). $min_(x in RR^n) ||A x - b||_1$, s.t. $||x||_oo <= 1$;

  (b). $min_(x in RR^n) ||x||_1$, s.t. $||A x - b||_oo <= 1$.
]

(a).
$
  min_(x in RR^n) &quad sum_(i=1)^m t_i \
  "s.t." &quad -t_i <= A_i x - b_i <= t_i, &quad i = 1, 2, dots, m; \
  &quad -1 <= x_j <= 1, &quad j = 1, 2, dots, n.
$
其中 $A_i$ 表示矩阵 $A$ 的第 $i$ 行, 下同.

(b).
$
  min_(x in RR^n) &quad sum_(j=1)^n s_j \
  "s.t." &quad -s_j <= x_j <= s_j, &quad j = 1, 2, dots, n; \
  &quad -1 <= A_i x - b_i <= 1, &quad i = 1, 2, dots, m.
$

#showybox(
  title: "T2",
  frame: frameSettings,
)[
  求解下面的线性规划问题: 给定向量 $c in RR^n$,

  (a). $min_(x in RR^n) c^T x$, s.t. $bold(0) <= x <= bold(1)$;

  (b). $min_(x in RR^n) c^T x$, s.t. $-bold(1) <= x <= bold(1)$.
]

(a).
首先显然有 $c^T x = sum_(i = 1)^n c_i x_i$. 因为 $0 <= x_i <= 1$, 所以当 $c_i >= 0$ 时, $x_i$ 取最小值 $0$; 当 $c_i < 0$ 时, $x_i$ 取最大值 $1$. 因此当
$
  x = cases(
    0\, c_i >= 0,
    1\, c_i < 0,
  )
$
时, $c^T x$ 取得最小值 $sum_(i = 1)^n min(0, c_i)$.

(b).
首先显然有 $c^T x = sum_(i = 1)^n c_i x_i$. 因为 $-1 <= x_i <= 1$, 所以当 $c_i >= 0$ 时, $x_i$ 取最小值 $-1$; 当 $c_i < 0$ 时, $x_i$ 取最大值 $1$. 因此当
$
  x = cases(
    -1\, c_i >= 0,
    1\, c_i < 0,
  )
$
时, $c^T x$ 取得最小值 $-sum_(i = 1)^n |c_i|$.


#showybox(
  title: "T3",
  frame: frameSettings,
)[
  给定矩阵 $A_i in cal(S)^m$, $i = 0, 1, ..., m$, 定义线性映射 $A(x) = A_0 + sum_(i=1)^n x_i A_i$. 令 $lambda_1(x) >= lambda_2(x) >= dots.h >= lambda_m (x)$ 为 $A(x)$ 的特征值. 将下面的优化问题转化为半定规划问题:

  (a). $min_(x in RR^n) lambda_1(x) - lambda_m (x)$;

  (b). $min_(x in RR^n) sum_(i = 1)^m abs(lambda_i (x))$. 
]

(a).
我们把 $A$ 正交对角化, 则有 $A = Q Lambda Q^T$, 其中 $Lambda = "diag"(lambda_1, lambda_2, dots, lambda_m)$. 考虑
$
  A - alpha I  = Q (Lambda - alpha I) Q^T,
$
那么在正交偏序下, $A - alpha I succ.curly.eq 0$ 要求 $Lambda - alpha I succ.curly.eq 0$, 也就是 $Lambda$ 中的每一个特征值都大于等于 $alpha$, 即 $lambda_m >= alpha$. 所以我们可以用下面的方式求出 $A$ 的最小特征值:
$
  lambda_m = max {alpha | A - alpha I succ.curly.eq 0};
$
同理, 我们可以求出 $A$ 的最大特征值:
$
  lambda_1 = min {beta | beta I - A succ.curly.eq 0}.
$
所以, 我们可以把原问题转化为下面的半定规划问题:
$
  min_(x in RR^n, alpha in RR, beta in RR) &quad beta - alpha \
  "s.t." &quad A(x) - alpha I succ.curly.eq 0; \
  &quad beta I - A(x) succ.curly.eq 0.
$

(b).
同样, 我们考虑 $A$ 的谱分解 $A = Q Lambda Q^T$. 这里我们要把 $Lambda$ 中的正特征值和负特征值分离开来, 我们定义
$
  Lambda_+ &= "diag"[max(0, lambda_1), max(0, lambda_2), dots, max(0, lambda_m)], \
  Lambda_- &= "diag"[min(0, lambda_1), min(0, lambda_2), dots, min(0, lambda_m)].
$
则我们就有
$
  A= Q Lambda_+ Q^T + Q Lambda_- Q^T = A_+ + A_-,
$
考虑到
$
  sum_(i=1)^m abs(lambda_i) = tr(Lambda_+) - tr(Lambda_-) = tr(A_+) - tr(A_-),
$
所以我们可以把原问题转化为下面的半定规划问题:
$
  min_(x in RR^n, A_+ in cal(S)^m, A_- in cal(S)^m) &quad tr(A_+) - tr(A_-) \
  "s.t." &quad A_0 + sum_(i=1)^n x_i A_i = A_+ + A_-; \
  &quad A_+ succ.curly.eq 0; A_- prec.curly.eq 0.
$


#showybox(
  title: "T4",
  frame: frameSettings,
)[
  考虑如下模型:
  $
    min_(X_1 in RR^(q times p), X_2 in RR^(q times q)) sum_(i=1)^m norm(X_2 X_1 a_i - b_i)_2^2,
  $
  其中 $a_i in RR^p$, $b_i in RR^q$, $i = 1, 2, ..., m$.

  (a). 试计算目标函数关于 $X_1$ 和 $X_2$ 的导数.

  (b). 给出该问题的最优解.
]

(a).
目标函数为:
$
  f(X_1, X_2) &= sum_(i=1)^m norm(X_2 X_1 a_i - b_i)_2^2 \
  &= sum_(i=1)^m (X_2 X_1 a_i - b_i)^T (X_2 X_1 a_i - b_i) 
$
设 $Y = X_2X_1$, 有
$
  (partial f) / (partial Y) = 2 sum_(i=1)^m (Y a_i - b_i) a_i^T 
$
于是 
$
  (partial f) / (partial X_1) &= 2 sum_(i=1)^m X_2^T (X_2 X_1 a_i - b_i) a_i^T, \
  (partial f) / (partial X_2) &= 2 sum_(i=1)^m (X_2 X_1 a_i - b_i) (X_1 a_i)^T.
$

(b).
令 $A = [a_1, a_2, dots, a_m] in RR^(p times m)$, $B = [b_1, b_2, dots, b_m] in RR^(q times m)$, $Z = X_2 X_1 in RR^(q times p)$, 则原问题可转化为
$
  min_(Z in RR^(q times p)) &quad ||Z A - B||_F^2.
$
这其实就是最小二乘问题, 它的最优解为
$
  Z^* = B A^dagger,
$
其中 $A^dagger$ 是 $A$ 的 Moore-Penrose 伪逆. 最优值为
$
  f^* = ||B (I - A A^dagger)||_F^2.
$