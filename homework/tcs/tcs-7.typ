
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
  title: [理论计算机科学作业 L2.4 - L2.6],
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
  分别构造产生下列语言的 CFG:
  + ${1^n 0^m | n >= m >= 1}$ 
  + ${1^n 0^(2m) 1^n | n, m >= 1}$ 
  + ${1^n 0^n 1^m 0^m | n, m >= 1}$ 
  + 含有相同个数的 $0$ 和 $1$ 的所有 $01$ 串
  + 字母表 ${1, 2, 3}$ 上的所有正则表达式
]

1. 这里要求 $1$ 不少于 $0$ 的个数, 因此可以同时生成 $0, 1$ 配对的部分, 然后再生成多余的 $1$:
$
  S-> 1 S | A \
  A -> 1 A 0 | 1 0
$

2. 中间要求有偶数个 $0$, 因此可以每次生成两个 $0$:
$
  S -> 1 S 1 | A \
  A -> 1 B 1 \
  B -> 0 B 0 | 0 0
$

3. 我们令 $A$ 是生成 $1^n 0^n$ 的变量
$
  S -> A A \
  A -> 1 A 0 | 1 0
$

4. 如果新串以 $0$ 开头, 则必须有一个对应的 $1$ 在这个 $0$ 之后; 同理, 如果新串以 $1$ 开头, 则必须有一个对应的 $0$ 在这个 $1$ 之后. 因此我们可以这样构造:
$
  S -> 0 S 1 S | 1 S 0 S | epsilon
$

5.
$
  R -> R + R | R R | R^* | ( R ) | 1 | 2 | 3 | epsilon | emptyset
$


#showybox(
  title: "T2",
  frame: frameSettings,
)[
  对于如下 CFG:
  $
    S -> a b B \
    A -> a a B b \
    B -> b b A a \
    A -> epsilon
  $
  给出字符串 $w = a b b b a a b b a a b a$ 的派生树, 利用该派生树找出该字符串的最左派生.
]

#align(center)[
  #tidy-tree-graph(
    spacing: (20pt, 20pt),
    node-inset: 6pt
  )[
    - $S$
      - $a$
      - $b$
      - $B$
        - $b$
        - $b$
        - $A$
          - $a$
          - $a$
          - $B$
            - $b$
            - $b$
            - $A$
              - $epsilon$
            - $a$
          - $b$
        - $a$
  ]
]
所以最左派生为:
$
  S &=> a b B \
    &=> a b b b A a \
    &=> a b b b a a B b a \
    &=> a b b b a a b b A a a \
    &=> a b b b a a b b epsilon a a \
    &= a b b b a a b b a a
$

#showybox(
  title: "T3",
  frame: frameSettings,
)[
1. 请总结非二义性CFG的句型的派生, 最左/最右派生以及派生树之间的关系
2. 请总结二义性文法中派生, 最左/最右派生以及派生树之间的关系
3. 描述语言的固有二义性与文法的二义性之间的关系
4. 对例7给定的文法, 采用穷举搜索法对字符串 $a a b d a b b $ 进行解析
]

1. 对于一个 CFG 产生的任何一个句子, 都存在唯一的一棵派生树. 这一棵派生树对应唯一的最左派生和最右派生.

2. 如果一个文法是二义性的, 那么该文法生成的语言中, 至少存在一个句子, 它拥有两棵或两棵以上不同的派生树. 对于这个特定的句子, 它会有两个或更多不同的最左派生, 以及两个或更多不同的最右派生.

3. 文法的二义性指某个特定的文法存在二义性. 通常情况下, 对于很多二义性文法, 我们可以通过重写规则 (例如引入优先级、结合性或分层) 来构造一个生成同样语言但不存在二义性的新文法. 语言的固有二义性指无论采用何种文法, 该语言中总存在至少一个句子具有多于一棵派生树. 换句话说, 该语言无法通过任何文法来消除二义性.

4. 
$
  S => a A b => a a A b b => a a b B a b b => a a b d a b b 
$