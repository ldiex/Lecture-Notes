
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
  title: [理论计算机科学作业 L2.7 - L2.11],
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
    证明如下两个 CFG 等价:
    $
      G_1: S -> a b A B | b a, quad A -> a a a, quad B -> a A | b b \
      G_2: S -> a b A a A | a b A b b | b a, quad A -> a a a
    $
]

可以发现 $G_1$ 比 $G_2$ 多了一个非终结符 $B$, 所以我们使用替换法来消除 $B$:
$
  G_1: S -> a b A (a A | b b) | b a \
     => S -> a b A a A | a b A b b | b a = G_2
$
所以 $G_1$ 和 $G_2$ 等价.

#prob(
  "T2"
)[
  去除如下 CFG 的无用产生式:
  $
    S -> a S | A B \
    A -> b A \
    B -> A A 
  $
  并指出该文法产生的语言是什么?
]

先替换 $B$:
$
  S -> a S | A A A \ 
  A -> b A
$

但是这里 $A$ 和 $S$ 都无法推导出纯终结符串, 所以该文法等价于空文法, 即产生空语言 $L = emptyset$.


#prob(
  "T3"
)[
  去除如下 CFG 的无用产生式:
  $
    S -> a | A A | B | C \
    A -> a B | epsilon \
    B -> A a \
    C -> c C D \
    D -> d d d 
  $
]

这里 $D$ 是有用的, 因为 $D -> d d d$ 是终结符串. 但是 $C$ 推导出的结果总包含 $C$, 所以 $C$ 是无用的. 另外 $A$ 和 $B$ 都能推导出终结符串, 所以是有用的. 最终结果为:
$
  S -> a | A A | B \
  A -> a B | epsilon \
  B -> A a
$


#prob(
  "T4"
)[
  去除如下 CFG 中的空产生式
  $
    S -> A a B | a a B \
    A -> epsilon \
    B -> b b A | epsilon
  $
]

首先删除 $A -> epsilon$, 得到:
$
  S -> a B | a a B \
  B -> b b | epsilon
$

然后删除 $B -> epsilon$, 得到:
$
  S -> a B | a a B | a | a a \
  B -> b b
$


#prob(
  "T5"
)[
  去除如下 CFG 中的所有单一产生式, 无用产生式和空产生式
  $
    S -> a A | a B B \
    A -> a a A | epsilon \
    B -> b B | b b C \
    C -> B
  $
]

单一产生式 $C -> B$ 可以删除, 变成:
$
  S -> a A | a B B \
  A -> a a A | epsilon \
  B -> b B | b b B
$

再删除无用产生式, 注意到这里 $B$ 推导出的语句总包含 $B$, 所以 $B$ 是无用的, 结果为
$
  S -> a A \
  A -> a a A | epsilon
$

再删除空产生式 $A -> epsilon$, 结果为
$
  S -> a A | a \
  A -> a a A | a a
$


#prob(
  "T6"
)[
  构造与下列文法等价的 CNF
  $
    S -> a B B | b A A \
    B -> a B a | a a | epsilon \
    A -> b b A | epsilon
  $
]

我们先删去掉空产生式, 先删除 $B -> epsilon$, 得到
$
  S -> a B B | a B | a | b A A \
  B -> a B a | a a \
  A -> b b A | epsilon \
$
然后删除 $A -> epsilon$, 得到
$
  S -> a B B | a B | a | b A A | b A | b \
  B -> a B a | a a \
  A -> b b A | b b \
$
整理一下, 变成
$
  S -> a B B | b A A | a B | b A | a | b \
  B -> a B a | a a \
  A -> b b A | b b
$

先考虑 $S -> a B B | b A A$, 我们令 $V_a -> a, V_b -> b, V_(A A) -> A A, V_(B B) -> B B$, 则有
$
  S -> V_a V_(B B) | V_b V_(A A) | V_a B | V_b A | a | b \
$

再考虑 $B -> a B a | a a$, 我们令 $V_(a B) -> V_a B$, 则有
$
  B -> V_(a B) V_a | V_a V_a \
$

类似地, 令 $V_(b b) -> V_b V_b$, 则有
$
  A -> V_(b b) A | V_b V_b \
$

最终结果为:
$
  S -> V_a V_(B B) | V_b V_(A A) | V_a B | V_b A | a | b \
  B -> V_(a B) V_a | V_a V_a \
  A -> V_(b b) A | V_b V_b \
  V_a -> a \
  V_b -> b \
  V_(A A) -> A A \
  V_(B B) -> B B \
  V_(a B) -> V_a B \
  V_(b b) -> V_b V_b \
$

#prob(
  "T7"
)[
  构造与下列文法等价的 GNF
  $
    S -> a S b | b S a | a | b
  $
]

令 $V_b -> b, V_a -> a$, 则有
$
  S -> a S V_b | b S V_a | a | b \
  V_a -> a \
  V_b -> b 
$


#prob(
  "T8"
)[
  构造与下列文法等价的 GNF
  $
    S -> A B b | a \
    A -> a a A | B \
    B -> b A b
  $
]
首先 $S -> A B b$ 不符合 GNF, 所以我们先把 $A$ 替换掉, 得到
$
  S -> a a A B b | B B b | a \
  A -> a a A | B \
  B -> b A b
$
这里 $S -> B B b$ 也不符合 GNF, 所以我们把 $B$ 替换掉, 得到
$
  S -> a a A B b | b A b B b | a \
  A -> a a A | b A b \
  B -> b A b
$
这样的话就简单了, 令 $V_a -> a, V_b -> b$, 则有
$
  S -> a V_a A B V_b | b A V_b B V_b | a \
  A -> a V_a A | b A V_b \
  B -> b A V_b \
  V_a -> a \
  V_b -> b
$


#prob(
  "T9"
)[
  利用 CYK 算法判断字符串 $a a b b$, $a a b b a$ 以及 $a b b b b$ 是否可由下列文法生成:
  $
    S -> A B \
    A -> B B | a \
    B -> A B | b
  $
]

1. 考虑 $a a b b$. 先初始化长度为 $1$ 的子串:
- $a : {A}$
- $a : {A}$
- $b : {B}$
- $b : {B}$
都可以生成. 

考虑长度为 $2$ 的子串:
- $a a : {A times A}$ 不能生成.
- $a b : {A times B}$ 可以由 $S$ 或者 $B$ 推导出来, 所以 $a b : {S, B}$.
- $b b : {B times B}$ 可以被 $A$ 推导出来, 所以 $b b : {A}$.

考虑长度为 $3$ 的子串:
- $a a b$, 它可以被拆分为 $(a)(a b)$ 或者 $(a a)(b)$
  - $(a)(a b)$ 对应 $A times {S, B}$, 不能生成. 其中 ${A times S}$ 不能被生成, 但是 ${A times B}$ 可以被生成, 所以 $a a b : {S, B}$.
  - $(a a)(b)$ 中因为 $a a$ 不能被生成, 所以也不能被生成.
  结果为 $a a b : {S, B}$.

- $a b b$, 它可以被拆分为 $(a)(b b)$ 或者 $(a b)(b)$
  - $(a)(b b)$ 对应 $A times A$, 不能生成.
  - $(a b)(b)$ 对应 ${S, B} times B$, 可以被 $A$ 推导出来, 所以 $a b b : {A}$.
  结果为 $a b b : {A}$.

考虑长度为 $4$ 的子串 $a a b b$, 它可以被拆分为 $(a)(a b b)$, $(a a)(b b)$ 或者 $(a a b)(b)$
- $(a)(a b b)$ 对应 $A times A$, 不能生成.
- $(a a)(b b)$ 中 $a a$ 不能被生成, 所以也不能被生成.
- $(a a b)(b)$ 对应 ${S, B} times B$, 可以被 $A$ 推导出来.
结果为 $a a b b : {A}$.

但是 ${A}$ 中不含有起始符号 $S$, 所以 $a a b b$ 不能被该文法生成.

2. 考虑 $a a b b a$. 观察到文法必须以 $b$ 结尾, 所以 $a a b b a$ 不能被该文法生成.

3. 考虑 $a b b b b$. 我们不用再考长度为 $1$ 和 $2$ 的子串, 直接从长度为 $3$ 的子串开始:
- $a b b$, 结果为 $a b b : {A}$ (同上).
- $b b b$, 它可以被拆分为 $(b)(b b)$ 或者 $(b b)(b)$
  - $(b)(b b)$ 对应 $B times A$, 不能生成.
  - $(b b)(b)$ 对应 $A times B$, 可以被 $S$ 或者 $B$ 推导出来, 所以 $b b b : {S, B}$.
  结果为 $b b b : {S, B}$.
  
考虑长度为 $4$ 的子串:
- $a b b b$, 它可以被拆分为 $(a)(b b b)$, $(a b)(b b)$ 或者 $(a b b)(b)$
  - $(a)(b b b)$ 对应 $A times {S, B}$, 不能生成. 其中${A times B}$ 可以由 $S$ 或者 $B$ 推导出来, 所以 $a b b b : {S, B}$.
  - $(a b)(b b)$ 对应 ${S, B} times A$, 不能生成.
  - $(a b b)(b)$ 对应 ${A} times B$, 可以被 $S, B$ 推导出来, 所以 $a b b b : {S, B}$.
  结果为 $a b b b : {S, B}$.

- $b b b b$, 它可以被拆分为 $(b)(b b b)$, $(b b)(b b)$ 或者 $(b b b)(b)$
  - $(b)(b b b)$ 对应 $B times {S, B}$, 可以被 $A$ 推导出来, 所以 $b b b b : {A}$.
  - $(b b)(b b)$ 对应 $A times A$, 不能生成.
  - $(b b b)(b)$ 对应 ${S, B} times B$, 可以被 $A$ 推导出来, 所以 $b b b b : {A}$.
  结果为 $b b b b : {A}$.

考虑长度为 $5$ 的子串 $a b b b b$, 它可以被拆分为 $(a)(b b b b)$, $(a b)(b b b)$, $(a b b)(b b)$ 或者 $(a b b b)(b)$
- $(a)(b b b b)$ 对应 $A times A$, 不能生成.
- $(a b)(b b b)$ 对应 ${S, B} times {S, B}$, 其中只有 ${B, B}$ 可以被 $A$ 推导出来, 所以 $a b b b b : {A}$.
- $(a b b)(b b)$ 对应 $A times A$, 不能生成.
- $(a b b b)(b)$ 对应 ${S, B} times B$, 可以被 $A$ 推导出来, 所以 $a b b b b : {A}$.
结果为 $a b b b b : {A}$.

但是 ${A}$ 中不含有起始符号 $S$, 所以 $a b b b b$ 不能被该文法生成.


#prob(
  "T10"
)[
  设 PDA $M = ({q, p}, {0, 1}, {Z_0 X}, delta, q, Z_0, {p})$ 具有如下转移函数:
  $
    delta(q, 0, Z_0) = {(q, X Z_0)} \
    delta(q, 0, X) = {(q, X X)} \
    delta(q, 1, X) = {(q, X)} \
    delta(q, epsilon, X) = {(p, epsilon)} \
    delta(p, epsilon, X) = {(p, epsilon)} \
    delta(p, 1, X) = {(p, X X)} \
    delta(p, 1, Z_0) = {(p, epsilon)}
  $
  1. 画出该 PDA 的状态转换图;
  2. 从初始 ID $(q, w, Z_0)$ 开始, 给出当输入串 $w = 0 0 1 1$ 时所有可达的 ID.
]

1. PDA 的状态转换图如下:
#align(center)[
  #automaton(
    (
      q: (q: "loop-q", p: "trans-qp"),
      p: (p: "loop-p"),
    ),
    initial: "q",
    final: ("p",), // 终态集合
    labels: (
      // q 状态的自环 (3条规则)
      "q-q": [
        $0, Z_0 -> X Z_0$ \
        $0, X -> X X$ \
        $1, X -> X$
      ],
      // q 到 p 的转移 (1条规则)
      "q-p": [ $epsilon, X -> epsilon$ ],
      // p 状态的自环 (3条规则)
      "p-p": [
        $epsilon, X -> epsilon$ \
        $1, X -> X X$ \
        $1, Z_0 -> epsilon$
      ]
    ),
    layout: finite.layout.custom.with(positions: (
      q: (0, 0),
      p: (6, 0)
    ))
  )
]

2. 
初始 ID 为 $(q, 0 0 1 1, Z_0)$. 读入 $0$ 后, 转移到
$
  (q, 0 1 1, X Z_0)
$
再读入 $0$, 转移到
$
  (q, 1 1, X X Z_0) \
  (p, 1 1, X Z_0) \
  (p, 1 1, Z_0)
$
再读入 $1$, 转移到
$
  (q, 1, X X Z_0) \
  (p, 1, X X Z_0) \
  (p, 1, X Z_0) \
  (p, 1, Z_0) \
  (q, 1, epsilon) quad "- Crash!" 
$
最后读入 $1$, 转移到
$
  (q, epsilon, X X Z_0) \
  (p, epsilon, X X X Z_0) \
  (p, epsilon, X X Z_0) \
  (p, epsilon, X Z_0) \
  (p, epsilon, Z_0) \
  (p, epsilon, epsilon) quad "- Accept!"
$