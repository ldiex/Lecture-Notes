
#import "@preview/showybox:2.0.4": showybox
#import "@preview/equate:0.3.2": equate
#import "@preview/ilm:1.4.1": *
#import "@preview/finite:0.5.0": automaton
#import "@preview/finite:0.5.0"
#import "@preview/tdtr:0.3.0" : *

#set text(font:("Libertinus Serif", "Source Han Serif SC"))

#show heading.where(level: 1): set text(navy.lighten(0%))
#show heading.where(level: 2): set text(navy.lighten(20%))
#show heading.where(level: 3): set text(navy.lighten(40%))

#show ref: it => {
  text(purple, it)
}

#show: ilm.with(
  title: [理论计算机科学作业 L2.14 - L3.2],
  date: datetime.today(),
  author: "潘天麟 2023K8009908023",
  table-of-contents: none,
)

#show: equate.with(breakable: true, sub-numbering: true)
#set math.equation(numbering: "(1.1)")

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

#let prob(title, body) = showybox(
  title: title,
  frame: frameSettings, 
  body
)

#prob(
  "T1"
)[
    证明如下语言不是 CFL:
    1. $L = {a^n b^j | n = j^2}$
    2. $L = {a^n | n "is prime"}$
    3. $L = {w w^R w | w in {a, b}^*}$ 这里 $w^R$ 是 $w$ 的反转.
]

*1.* 假设 $L$ 是 CFL, 则存在泵长度 $p$, 我们取字符串 $z = a^(p^2) b^p$, 则存在一种拆分 $z = u v w x y$ 满足 $|v w x| <= p, |v x| >= 1$ 使得 $u v^i w x^i y in L$.

现在我们假设在字符串 $v x$ 中存在 $alpha$ 个 $a$ 和 $beta$ 个 $b$. 那么 $u v^i w x^i y$ 中就有 $p^2 + alpha (i - 1)$ 个 $a$ 和 $p + beta (i - 1)$ 个 $b$. 那么根据泵引理的条件, 我们有
$
p^2 + alpha (i - 1) = (p + beta (i - 1))^2
$
化简有
$
  alpha (i - 1) = beta^2 (i - 1)^2 + 2 p beta (i - 1)
$
由于 $i$ 是任取的, 我们令 $i >= 2$, 则有
$
  alpha = beta^2 (i - 1) + 2 p beta
$
由于 $|v w x| <= p$, 则 $0 <= alpha, beta <= p$. 如果 $beta = 0$, 那么 $alpha = 0$, 这个就和 $|v x| >= 1$ 矛盾; 那么 $beta >= 1$. 这时候, 由于 $i$ 可以任取, 那么 $alpha$ 会随着 $i$ 的增大而无限增大, 这和 $alpha <= p$ 矛盾. 因此 $L$ 不是 CFL.

*2.* 假设 $L$ 是 CFL, 则存在泵长度 $p$, 我们取字符串 $z = a^n$, 其中 $n$ 是大于 $p$ 的任意素数. 则存在一种拆分 $z = u v w x y$ 满足 $|v w x| <= p, |v x| >= 1$ 使得 $u v^i w x^i y in L$. 令 $k = |v x|$, 这就意味着
$
[n + (i - 1) k] "is prime"
$
然而, 当我们取 $i = n + 1$, 则有$n + (i - 1) k = n + n k = n (k + 1)$, 这显然不是素数, 矛盾. 因此 $L$ 不是 CFL.

*3.* 假设 $L$ 是 CFL, 则存在泵长度 $p$, 我们取字符串 $z = a^p b^p b^p a^p a^p b^p$, 则存在一种拆分 $z = u v w x y$ 满足 $|v w x| <= p, |v x| >= 1$ 使得 $u v^i w x^i y in L$. 由于 $|v w x| <= p$, 那么 $v w x$ 不可能跨越三个部分, 有以下两种情况:
- 如果 $v w x$ 在一个 $w$ 的内部, 那么泵出来的字符串显然不在 $L$ 中.
- 如果 $v w x$ 跨越了 $w$ 和 $w^R$ 的边界, 那么泵出来的字符串的中间部分就不可能是一个回文, 因此不在 $L$ 中.
因此 $L$ 不是 CFL.

#prob(
  "T2"
)[
  用泵引理证明下述语言不是 CFL:
  1. $L = {0^n 1^n 0^n 1^n | n >= 0}$
  2. $L = {0^n \# 0^(2n) \# 0^(3n) | n >= 0}$, 其中 $\#$ 是分隔符.
  3. $L = {w \# t | w, t in {a, b}^*}$, 且 $w$ 是$t$ 的子串.
]

*1.* 假设 $L$ 是 CFL, 则存在泵长度 $p$, 我们取字符串 $z = 0^p 1^p 0^p 1^p$, 则存在一种拆分 $z = u v w x y$ 满足 $|v w x| <= p, |v x| >= 1$ 使得 $u v^i w x^i y in L$. 由于 $|v w x| <= p$, 那么 $v w x$ 不可能跨越三个部分, 有以下几种情况:
- 如果 $v w x$ 在 $0^p$ 或者 $1^p$ 的内部, 那么泵出来的字符串中 $0$ 和 $1$ 的数量就不再相等, 因此不在 $L$ 中.
- 如果 $v w x$ 跨越了 $0^p$ 和 $1^p$ 的边界, 那么它要么是 $0^p 1^p$ 的子串, 要么是 $1^p 0^p$ 的子串. 如果是 $0^p 1^p$ 的子串, 那么泵出来的字符串前后两个 $0^p 1^p$ 的 $0, 1$ 个数就不一致了; 如果是 $1^p 0^p$ 的子串, 那么泵出来的字符串就不符合左右两边 $0^n 1^n$ 的约束, 因此也不在 $L$ 中.
因此 $L$ 不是 CFL.

*2.* 假设 $L$ 是 CFL, 则存在泵长度 $p$, 我们取字符串 $z = 0^p \# 0^(2p) \# 0^(3p)$, 则存在一种拆分 $z = u v w x y$ 满足 $|v w x| <= p, |v x| >= 1$ 使得 $u v^i w x^i y in L$. 我们考虑
- 显然 $v x$ 不能包含分隔符 $\#$, 否则泵出来的字符串中 $\#$ 的个数就不是 $2$ 了.
- 如果 $u v x$ 只是 $0^p$ 或者 $0^(2p)$ 或者 $0^(3p)$ 的子串, 那么泵出来的字符串中这部分 $0$ 的个数就不再是原来的倍数关系了, 因此不在 $L$ 中.
- 如果 $u v x$ 跨越了两个部分 (它不可能跨越三个部分), 那么 $v = \#$. 而此时泵出来的字符串中跨越的两个部分中的 $0$ 的个数一定会增加, 这也会破坏原来的倍数关系, 因此不在 $L$ 中.
因此 $L$ 不是 CFL.

*3.* 假设 $L$ 是 CFL, 则存在泵长度 $p$, 我们取字符串 $z = a^p b^p \# a^p b^p$, 则存在一种拆分 $z = u v w x y$ 满足 $|v w x| <= p, |v x| >= 1$ 使得 $u v^i w x^i y in L$. 
- 如果 $v w x$ 完全在 $w$ 的部分, 那么泵出来的字符串中 $w$ 的长度增加了, 但是 $t$ 没有变化, 因此 $w$ 不可能是 $t$ 的子串, 矛盾.
- 如果 $v w x$ 跨越了 $w$ 和 $\#$ 的边界, 那么 $w = \#$. 因为 $|v| < p$, 所以泵出来的的字符串右边的 $b$ 不会增加, 但是左边的 $b$ 会增加, 因此左边的 $w$ 不可能是右边 $t$ 的子串, 矛盾.
- 如果 $v w x$ 完全在 $t$ 的部分, 那么取 $i = 0$, 则泵出来的字符串中 $t$ 的长度减少了, 因此左边的 $w$ 不可能是右边 $t$ 的子串, 矛盾.
因此 $L$ 不是 CFL.

#prob(
  "T3"
)[
  证明下述语言是 CFL:
  1. $L = {a^n b^n | n >= 0}$ 其中 $n$ 不能是 $5$ 的倍数.
  2. $L = {w in {a, b}^* | n_a (w) = n_b (w), w "does not have substring" a a b}$
]
*1.* 考虑到 $L$ 中的语言的 $n = 5 k + r$, 其中 $k in NN$ 且 $r in {1, 2, 3, 4}$. 所以我们可以如下构造一个 CFG 生成 $L$ 中的 $a^n$:
$
  A_4 -> a a a a | a a a | a a | a \
  A_5 -> a a a a a A_5 | epsilon \ 
  A -> A_5 A_4
$
有了这个基础, 我们可以类似地构造
$
  T_4 -> a a a a b b b b | a a a b b b | a a b b | a b \
  T_5 -> T_4 | a a a a a T_5 b b b b b \
  S -> T_5 
$
这就生成了 $L$ 中的所有字符串, 因此 $L$ 是 CFL.

*2.* 我们先构造一个 CFG 生成 $L' = {w in {a, b}^* | n_a (w) = n_b (w)}$:
$
  S -> a S b | b S a | S S | epsilon
$
然后, 由于 ${w in {a, b}^* | w "has a substring" a a b}$ 是一个正则语言, 所以它的补集也是正则语言. 那么这个补正则语言和 $L'$ 的交集就是仍然是 CFL. 所以 $L$ 是 CFL.

#prob(
  "T4"
)[
  证明存在算法, 可以判定一个 CFL 是否包含长度小于 $n$ 的串.
]
首先, 语言 ${w in Sigma^* | |w| < n}$ 是有限集合, 任何有限集合都是正则语言. 设 $L$ 是一个 CFL, 则 $L_1 = {w in Sigma^* | |w| < n} inter L$ 也是 CFL, 所以原问题转化为判定 $L_1$ 是否为空集. 由于 CFL 的空集判定问题是可判定的, 因此原问题是可判定的.

#prob(
  "T5"
)[
  设有 CFL $L_1$ 和正则语言 $L_2$, 证明存在算法可判定 $L_1$ 和 $L_2$ 是否包含相同的元素.
]
如果这里的 "包含相同的元素" 是指存在 $w in L_1$ 且 $w in L_2$, 那么我们可以构造 $L_3 = L_1 inter L_2$, 由于 $L_2$ 是正则语言, 所以 $L_3$ 是 CFL. 然后我们只需要判定 $L_3$ 是否为空集, 由于 CFL 的空集判定问题是可判定的, 因此原问题是可判定的.

