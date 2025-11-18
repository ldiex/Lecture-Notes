
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
  title: [理论计算机科学作业 L2.1 - L2.3],
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

#showybox(
  title: "T1",
  frame: frameSettings,
)[
  设文法 $G$ 的产生式集如下, 试给出句子 $"id" + "id" * "id"$ 的两个不同的推导和两个不同的归约
  $
    E -> "id" | c | + E | -E | E + E | E - E | E * E | \ E \/ E | E ** E |"Fun" (E)
  $
]

*推导1*: 
$
  E &-> E + E \
    &-> "id" + E \
    &-> "id" + E * E \
    &-> "id" + "id" * E \
    &-> "id" + "id" * "id"
$


*推导2*: 
$
  E &-> E * E \
    &-> E + E * E \
    &-> "id" + E * E \
    &-> "id" + "id" * E \
    &-> "id" + "id" * "id"
$

*归约1*:
$
  "id" + "id" * "id" &-> E + "id" * "id" \
    &-> E + E * "id" \
    &-> E + E * E \
    &-> E + E \
    &-> E
$


*归约2*:
$
  "id" + "id" * "id" &-> E + "id" * "id" \
    &-> E + E * "id" \
    &-> E + E * E \
    &-> E * E \
    &-> E
$

#showybox(
  title: "T2",
  frame: frameSettings,
)[
  设文法 $G$ 的产生式集如下, 试给出句子 $a a a b b b c c c$ 的至少两个不同的推导和至少两个不同的归约.
  $
    S &-> a B C | a S B C \
    a B &-> a b \
    b B &-> b b \
    C B &-> B C \
    b C &-> b c \
    c C &-> c c 
  $
]

*推导1*:
$
  S &-> a S B C \
    &-> a a S B C B C quad &(S -> a S B C) \
    &-> a a a B C B C B C quad &(S -> a B C) \
    &colMath(-> a a B B C C B C, #red) quad &colMath((C B -> B C), #red) \
    &colMath(-> a a B B C B C C, #blue) quad &colMath((C B -> B C), #blue) \
    &-> a a a B B B C C C quad &(C B -> B C) \
    &-> a a a b B B C C C quad &(a B -> a b) \
    &-> a a a b b B C C C quad &(b B -> b b) \
    &-> a a a b b b C C C quad &(b B -> b b) \
    &-> a a a b b b c C C quad &(b C -> b c) \
    &-> a a a b b b c c C quad &(c C -> c c) \
    &-> a a a b b b c c c quad &(c C -> c c)
$


*推导2*:
$
  S &-> a S B C \
    &-> a a S B C B C quad &(S -> a S B C) \
    &-> a a a B C B C B C quad &(S -> a B C) \
    &colMath(-> a a B C B B C C, #red) quad &colMath((C B -> B C), #red) \
    &colMath(-> a a B B C B C C, #blue) quad &colMath((C B -> B C), #blue) \
    &-> a a a B B B C C C quad &(C B -> B C) \
    &-> a a a b B B C C C quad &(a B -> a b) \
    &-> a a a b b B C C C quad &(b B -> b b) \
    &-> a a a b b b C C C quad &(b B -> b b) \
    &-> a a a b b b c C C quad &(b C -> b c) \
    &-> a a a b b b c c C quad &(c C -> c c) \
    &-> a a a b b b c c c quad &(c C -> c c)
$

*归约1*: 把推导1 反过来即可.

*归约2*: 把推导2 反过来即可.


#showybox(
  title: "T3",
  frame: frameSettings,
)[
  设文法 $G$ 的产生式集如下, 试给出句子 $a b e e b b e e b a$ 的推导. 你能给出句子 $a b e e b b e e b$ 的归约吗? 如果不能, 请说明理由.
  $
    S &-> a A a | b A b | e \
    A &-> S S \
    b B &-> b A b \
    b C &-> b c \
    B &-> b A b S
  $
]

*推导*:
$
  S &-> a A a \
    &-> a S S a quad &(A -> S S) \
    &-> a b A b S a quad &(S -> b A b) \
    &-> a b A b b A b a quad &(S -> b A b) \
    &-> a b S S b b A b a quad &(A -> S S) \
    &-> a b S S b b S S b a quad &(A -> S S) \
    &-> a b e e b b e e b a quad &(4 times S -> e)
$

*归约不可行的理由*:
文法规定 $a$ 只能成对出现, 因为只有 $S -> a A a$ 这一条产生式能生成 $a$. 因此, 句子 $a b e e b b e e b$ 中只有一个 $a$, 无法通过任何归约得到该句子.

#showybox(
  title: "T4",
  frame: frameSettings,
)[
 设文法 $G$ 的产生式集如下, 请给出 $G$ 的每个语法范畴代表的集合.
 $
   S &-> a S a | a a S a a | a A a \
   A &-> b A | b b b A | b B \
   B &-> c B | c C \
   C &-> c c C | D D \
   D &-> d D | d
 $
]

$
  L(D) &= { d^n | n >= 1 } \
  L(C) &= { c^(2n) d^k | n >= 0, k >= 2 } \
  L(B) &= { c^m d^k | m >= 1, k >= 2 } \
  L(A) &= {b^n c^m d^k | n >= 1, m >= 1, k >= 2 } \
  L(S) &= {a^p b^n c^m d^k a^p | p >= 1, n >= 1, m >= 1, k >= 2 } \
$


#showybox(
  title: "T5",
  frame: frameSettings,
)[
  构造产生下列语言的文法:

  (1). ${a^m b^m c^p | n, m, p >= 0}$

  (2). ${a^n b^(2m + 1) | n, m >= 0}$

  (3). 任何不是以 $0$ 打头的奇数所组成的集合

  (4). 所有偶数个 0 和偶数个 1 所组成的符号串
]

(1).
$
  S -> A B C \
  A -> a A | epsilon \
  B -> b B | epsilon \
  C -> c C | epsilon \
$

(2).
$
  S -> A b B \
  A -> a A | epsilon \
  B -> b b B | epsilon \
$

(3).
$
  S -> F M N | N \
  N -> 1 | 3 | 5 | 7 | 9 \
  F -> 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 \
  M -> 0 M | 1 M | 2 M | 3 M | 4 M | 5 M | \ 6 M | 7 M | 8 M | 9 M | epsilon \
$

(4).
我们可以构造一个自动机来识别该语言, 然后再将自动机转换为文法. 设四个状态为, $A$: 偶数个 0 偶数个 1, $B$: 奇数个 0 偶数个 1, $C$: 偶数个 0 奇数个 1, $D$: 奇数个 0 奇数个 1. 初始状态和接受状态均为 $A$. 转移函数如下:

- 从 $A$ 读入 $0$ 转移到 $B$, 读入 $1$ 转移到 $C$.
- 从 $B$ 读入 $0$ 转移到 $A$, 读入 $1$ 转移到 $D$.
- 从 $C$ 读入 $0$ 转移到 $D$, 读入 $1$ 转移到 $A$.
- 从 $D$ 读入 $0$ 转移到 $C$, 读入 $1$ 转移到 $B$.

于是有文法:
$
  S_A &-> 0 S_B | 1 S_C | epsilon \
  S_B &-> 0 S_A | 1 S_D \
  S_C &-> 0 S_D | 1 S_A \
  S_D &-> 0 S_C | 1 S_B \
$


#showybox(
  title: "T6",
  frame: frameSettings,
)[

  (1). 构造一个 DFA 接受如下文法定义的语言:
  $
    S -> a b A \
    A -> b a B \
    B -> a A | b b
  $

  (2). 构造产生语言 $a a^* (a b + a)^*$ 的正则文法.

  (3). 构造产生语言 $(a a b^* a b)^*$ 的正则文法.
]

(1). 有 $ S -> a b b a B$, 其中 $B -> a b a B | b b$. 所以对应的语言是 $a b b a (a b a)^* b b$

#align(center)[
  #automaton(
    (
      q1: (q2: "abba"),
      q2: (q2: "aba", q3: "bb"),
    ),
    initial: "q1",
    final: ("q3"),
    layout: finite.layout.custom.with(positions:(
      q1: (0, 0),
      q2: (3, 0),
      q3: (6, 0),
    ))
  )
]

(2).
$
  S -> a A \
  A -> a A | a B | epsilon \
  B -> b A
$

(3).
$
  S -> epsilon | a A \
  A -> a B \
  B -> b B | a C \
  C -> b S
$