
#import "@preview/showybox:2.0.4": showybox
#import "@preview/equate:0.3.2": equate
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
  title: [理论计算机科学作业 L1.10 - L1.12],
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

#showybox(
  title: "T1",
  frame: frameSettings,
)[
*1)* 用分配律化简如下正则表达式, 得到两个不同但更简单的等价表达式
$
(0 + 1)^*1(0 + 1)(0 + 1) + (0 + 1)^*1(0 + 1) 
$

*2)* 证明
$
  (L + M)^* = (L^* M^*)^*
$
]

*1)* 第一个等价表达式, 我们直接提取公因式
$
&(0 + 1)^*1(0 + 1)(0 + 1) + (0 + 1)^*1(0 + 1) \
&quad = (0 + 1)^*1^*(0 + 1)(epsilon + 0 + 1)
$ <eq:1>
第二个等价表达式, 我们直接利用分配律展开 @eq:1, 得到
$
& (0 + 1)^*1^*(0 + 1)(epsilon + 0 + 1) \
&quad = (0 + 1)^*1^*[(0 + 1)(0 + 1) + (0 + 1)]
$

*2)* 
根据定义
$
  (L + M)^* = union.big_(n >= 0) (L + M)^n,\
  L^* = union.big_(n >= 0) L^n, quad M^* = union.big_(n >= 0) M^n
$
从而
$
  L^* M^* = (union.big_(i >= 0) L^i)(union.big_(j >= 0) M^j) = union.big_(i, j >= 0) L^i M^j \
  ==> (L^* M^*)^* = union.big_(k >= 0) (L^* M^*)^k = union.big_(k >= 0) (union.big_(i, j >= 0) L^i M^j)^k
$
特别地, 在里面那个 "$union.big$" 中取 $(i, j) in {(1, 0), (0, 1)}$, 则有
$
  (L+M)^* = union.big_(n >= 0) (L^1M^0 + L^0M^1)^n subset.eq union.big_(k >= 0) (union.big_(i, j >= 0) L^i M^j)^k = (L^* M^*)^*
$
另一方面,
$
  (L^* M^*)^* = union.big_(k >= 0) (union.big_(i, j >= 0) L^i M^j)^k \
  = union.big_(k >=0) [union.big_((i_1, j_1, ..., i_k, j_k) >= 0) L^(i_1) M^(j_1) ... L^(i_k) M^(j_k)]
$
由于对于任意 $i,j >= 0$, 有 $L^i subset.eq (L + M)^*$ 以及 $M^j subset.eq (L + M)^*$, 因此
$
  L^(i_1) M^(j_1) ... L^(i_k) M^(j_k) subset.eq (L + M)^* (L + M)^* ... (L + M)^* = (L + M)^*
$
从而
$
  (L^* M^*)^* subset.eq union.big_(k >= 0) (L + M)^* = (L + M)^*
$
综上所述, 我们得出
$
  (L + M)^* = (L^* M^*)^*
$

#showybox(
  title: "T2",
  frame: frameSettings,
)[
  利用 Arden 引理将如下有穷自动机转换为正则表达式

  *1)*
  #align(center)[
    #automaton(
      (
        q1: (q1: "a", q2: "a"),
        q2: (q1: "b", q2: "b", q3: "a"),
        q3: (q2: "b")
      ),
      initial: "q1",
      final: ("q3",),
      layout: finite.layout.custom.with(positions:(
        q1: (0, 0),
        q2: (3, 0),
        q3: (6, 0),
      ))
    )
  ]

  *2)*
  #align(center)[
    #automaton(
      (
        q1: (q1: "a", q2: "b"),
        q2: (q1: "a", q2: "b", q3: "a"),
        q3: (q2: "a")
      ),
      initial: "q1",
      final: ("q3",),
      layout: finite.layout.custom.with(positions:(
        q1: (0, 0),
        q2: (3, 0),
        q3: (6, 0),
      ))
    )
  ]
]

*1)* 设 $q_1 -> q_1, q_2, q_3$ 分别对应正则表达式 $R_1, R_2, R_3$, 则根据自动机的转移关系, 我们有如下方程组
$
  R_1 &= R_1 a + R_2 b + epsilon, \
  R_2 &= R_1 a + R_2 b + R_3 b, \
  R_3 &= R_2 a 
$ 
代入第三个方程到第二个方程, 结合 Arden 引理, 得到
$
  R_2 &= R_1 a + R_2 b + (R_2 a) b = R_1 a + R_2 (b + a b) \
  ==> R_2 &= R_1 a (b + a b)^*
$
将此代入第一个方程, 同样结合 Arden 引理, 得到
$
  R_1 &= R_1 a + (R_1 a (b + a b)^*) b + epsilon \
  &= R_1 a + R_1 a (b + a b)^* b + epsilon \
  ==> R_1 &= epsilon (a + a (b + a b)^* b)^* \
  &= (a + a (b + a b)^* b)^*
$
于是就有
$
  L(M) = R_3 = R_2 a = R_1 a (b + a b)^* a \
  = (a + a (b + a b)^* b)^* a (b + a b)^* a
$

*2)* 同理, 设 $q_1 -> q_1, q_2, q_3$ 分别对应正则表达式 $R_1, R_2, R_3$, 则根据自动机的转移关系, 我们有如下方程组
$
  R_1 &= R_1 a + R_2 a + epsilon, \
  R_2 &= R_1 b + R_2 b + R_3 a, \
  R_3 &= R_2 a 
$
代入第三个方程到第二个方程, 结合 Arden 引理, 得到
$
  R_2 &= R_1 b + R_2 b + (R_2 a) a = R_1 b + R_2 (b + a a) \
  ==> R_2 &= R_1 b (b + a a)^*
$
再代入此到第一个方程, 同样结合 Arden 引理, 得到
$
  R_1 &= R_1 a + (R_1 b (b + a a)^*) a + epsilon \
  &= R_1 a + R_1 b (b + a a)^* a + epsilon \
  ==> R_1 &= epsilon (a + b (b + a a)^* a)^* \
  &= (a + b (b + a a)^* a)^*
$
所以
$
  L(M) = R_3 = R_2 a = R_1 b (b + a a)^* a \
  = (a + b (b + a a)^* a)^* b (b + a a)^* a
$