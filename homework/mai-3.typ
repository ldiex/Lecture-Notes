#import "@preview/showybox:2.0.4": showybox

#set text(15pt, font:("Libertinus Serif", "Source Han Serif SC"))

#show heading.where(level: 1): set text(blue)
#show heading.where(level: 2): set text(green)
#show heading.where(level: 3): set text(purple)
#show ref: it => {
  text(green, it)
}


#showybox(
  title: [
    *T1* 
  ],
  frame: (
    border-color: blue,
    title-color: blue.lighten(30%),
    body-color: blue.lighten(95%),
    footer-color: blue.lighten(80%)
  ),
)[
已知 $X in RR^(n times n)$, $a, b in RR^n$, 计算下列偏导数
$
(partial a^T X b)/(partial X), quad (partial a^T X^T b)/(partial X)
$
]

由于
$
  a^T X b = angle.l a, X b angle.r = sum_(i = 1)^n a_i (X b)_i = sum_(i = 1)^n a_i sum_(j = 1)^n X_(i j) b_j = sum_(i = 1)^n sum_(j = 1)^n a_i b_j X_(i j)
$

所以
$
  (partial a^T X b)/(partial X) = (a_i b_j)_(i, j) = a b^T
$

同理,
$
  a^T X^T b = angle.l a, X^T b angle.r = sum_(i = 1)^n a_i (X^T b)_i = sum_(i = 1)^n a_i sum_(j = 1)^n X_(j i) b_j = sum_(i = 1)^n sum_(j = 1)^n a_j b_i X_(i j)
$
所以
$
  (partial a^T X^T b)/(partial X) = (a_j b_i)_(i, j) = b a^T
$.


#showybox(
  title: [
    *T2* 
  ],
  frame: (
    border-color: blue,
    title-color: blue.lighten(30%),
    body-color: blue.lighten(95%),
    footer-color: blue.lighten(80%)
  ),
)[
  设 $K$ 是一个锥, $K^*$ 是其对偶锥 (i.e. $K^* = { y : angle.l x, y angle.r >= 0, forall x in K }$), 证明: $K^*$ 也是一个锥 (即使 $K$ 不是锥也成立).
]
设 $y_1, y_2 in K^*$, $alpha, beta >= 0$, 则对于任意 $x in K$, 有
$
  angle.l x, alpha y_1 + beta y_2 angle.r = alpha angle.l x, y_1 angle.r + beta angle.l x, y_2 angle.r >= 0
$
所以 $alpha y_1 + beta y_2 in K^*$, 因此 $K^*$ 是一个锥. 

#showybox(
  title: [
    *T2* 
  ],
  frame: (
    border-color: blue,
    title-color: blue.lighten(30%),
    body-color: blue.lighten(95%),
    footer-color: blue.lighten(80%)
  ),
)[
  利用凸函数的二阶条件证明: log-sum-exp 函数 $f(x) = log(sum_(k=1)^n e^(x_k))$ 是凸函数.
]
计算 $f(x)$ 的 Hessian 矩阵:
$
  (nabla^2 f(x))_(i j) &= (partial^2 f(x))/(partial x_i partial x_j) \
  &= (partial)/(partial x_j) (e^(x_i) / (sum_(k=1)^n e^(x_k))) \
  &= (delta_(i j) e^(x_i) (sum_(k=1)^n e^(x_k)) - e^(x_i) e^(x_j)) / (sum_(k=1)^n e^(x_k))^2 \
  &= (delta_(i j) (sum_(k=1)^n e^(x_k)) - e^(x_j)) / (sum_(k=1)^n e^(x_k))^2 e^(x_i)
$
设 $S = sum_(i = 1)^n e^(x_i)$, 则对于任意 $z in RR^n$, 有
$
  angle.l z, nabla^2 f(x) z angle.r &= sum_(i = 1)^n sum_(j = 1)^n z_i z_j (nabla^2 f(x))_(i j) \
  &= sum_(i = 1)^n sum_(j = 1)^n z_i z_j (delta_(i j) S - e^(x_j)) / S^2 e^(x_i) \
  &= 1/(S^2) sum_(i = 1)^n z_i e^(x_i) [z_i S - sum_(j = 1)^n z_j e^(x_j)] \
  &= 1/(S^2) [S sum_(i = 1)^n z_i^2 e^(x_i) - (sum_(i = 1)^n z_i e^(x_i))^2] \
$
要证明 $angle.l z, nabla^2 f(x) z angle.r >= 0$, 只需证明
$
  S sum_(i = 1)^n z_i^2 e^(x_i) >= (sum_(i = 1)^n z_i e^(x_i))^2
$
利用 Cauchy 不等式, 有
$
  (sum_(i = 1)^n z_i e^(x_i))^2 = (sum_(i = 1)^n z_i sqrt(e^(x_i)) sqrt(e^(x_i)))^2 \ 
  <= (sum_(i = 1)^n z_i^2 e^(x_i)) (sum_(i = 1)^n e^(x_i)) = S sum_(i = 1)^n z_i^2 e^(x_i)
$
因此 $nabla^2 f(x)$ 是半正定的, 所以 $f(x)$ 是凸函数.