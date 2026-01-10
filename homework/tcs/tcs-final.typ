
#import "@preview/showybox:2.0.4": showybox
#import "@preview/ilm:1.4.1": *
#import "@preview/finite:0.5.0": automaton
#import "@preview/finite:0.5.0"
#import "@preview/tdtr:0.3.0": *
#import "@preview/algorithmic:1.0.6"
#import algorithmic: algorithm-figure, style-algorithm
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node

#show: style-algorithm

#set text(font: ("Libertinus Serif", "Source Han Serif SC"))

#show heading.where(level: 1): set text(navy.lighten(0%))
#show heading.where(level: 2): set text(navy.lighten(20%))
#show heading.where(level: 3): set text(navy.lighten(40%))

#show ref: it => {
  text(purple, it)
}

#show: ilm.with(
  title: [Theoretical Computer Science Final Review],
  date: datetime.today(),
  author: "Tianlin Pan",
  table-of-contents: outline(depth: 2),
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

#let frameSettingsEastern = (
  border-color: eastern,
  title-color: eastern.lighten(30%),
  body-color: eastern.lighten(95%),
  footer-color: eastern.lighten(80%),
)
#set quote(block: true)

= General Roadmap
== 公理化基石
一切始于符号与集合. 我们定义了计算的 "原材料" .
- 输入: 字母表 $Sigma$ 和 字符串集合 $Sigma^*$.
- 目标: 定义 语言 (Language) $L subset.eq Sigma^*$.
- 核心问题: 给定 $w in Sigma^*$, 判断 $w in L$ 是否成立? (即 "成员资格问题" )

== 有限内存的世界 (Regular Languages)
*核心假设*: 计算机只有 *有限的状态* (Finite Memory), 没有外部存储.

1. *定义模型*: 提出 *DFA* (确定性模型).
2. *引入非确定性*: 提出 *NFA*.
  - *推导*: 通过 *子集构造法 (Subset Construction)* 证明 $"NFA" subset.eq "DFA"$, 从而得出 $"DFA" approx "NFA"$.
3. *代数描述*: 提出 *正则表达式 (RE)*.
  - *推导*: 通过 *Kleene 定理* (状态消除法/Arden 引理) 证明 $"RE" approx "FA"$.
4. *确定边界 (局限性)*:
  - *推导*: 由于状态有限 ($|Q| = k$), 根据 *鸽巢原理*, 长字符串必然导致状态循环 $arrow.r$ 导出 *正则泵引理 (Pumping Lemma)*.
  - *推导*: 定义 *Myhill-Nerode 等价关系*, 证明正则语言的等价类是有限的 $arrow.r$ 导出 *DFA 极小化算法*.

== 栈的引入 (Context-Free Languages)
*核心假设*: 允许无限的内存, 但访问受限, 遵循 *LIFO (后进先出)* 规则.

1. *结构化描述*: 提出 *上下文无关文法 (CFG)*.
  - *推导*: 为了便于分析, 将 CFG 规范化为 *Chomsky 范式 (CNF)* (生成二叉派生树).
2. *机器模型*: 提出 *下推自动机 (PDA)*.
  - *推导*: 证明 $"CFG" approx "PDA"$ (文法与机器的等价性).
3. *确定性与非确定性的分裂*:
  - *观察*: 此时 $"DPDA" subset.neq "NPDA"$ (确定性真包含于非确定性), 这与正则语言不同. 这也引出了 $"LL(k)"$ 文法和解析 (Parsing) 的复杂性.
4. *确定边界*:
  - *推导*: 基于 CNF 的二叉树高度性质, 导出 *CFL 泵引理* (字符串被切分为 $u v x y z$).

== 线性有界存储 (Context-Sensitive Languages)
*核心假设*: 允许随机访问内存 (Tape), 但内存大小与输入长度成 *线性比例*.

1. *机器模型*: 提出 *线性有界自动机 (LBA)*.
2. *判定性*:
  - *推导*: 因为带长有限, 格局 (Configuration) 的总数是有限的. 检测循环可知 $A_"LBA"$ 是可判定的.
  - *推导*: 通过计算历史 (Computation History) 归约, 证明 $E_"LBA"$ (空性) 是不可判定的.

== 无限随机访问 (Recursively Enumerable)
*核心假设*: 拥有无限的磁带, 且读写头可以自由移动.

1. *机器模型*: 提出 *图灵机 (TM)*.
2. *稳健性证明*:
  - *推导*: 证明 多带 TM $approx$ 单带 TM; 非确定性 TM $approx$ 确定性 TM. 得出 *Church-Turing Thesis*: 图灵机即是算法的极限.
3. *生成模型*: 提出 *无约束文法 (Type 0)*, 证明其与 TM 等价.

== 计算的深渊 (Undecidability)
*核心问题*: 有没有图灵机解决不了的问题?

1. *基数论证*:
  - *推导*: 图灵机集合是 *可数的* ($aleph_0$), 语言 ($2^(Sigma^*)$) 是 *不可数的* ($2^(aleph_0)$). 绝大多数语言是不可识别的.
2. *具体构造*:
  - *推导*: 利用 *康托尔对角线法* 构造悖论, 证明 *停机问题 ($A_"TM"$)* 不可判定.
3. *问题扩散 (归约)*:
  - *推导*: 利用 *归约 (Reduction)* 技术, 将 $A_"TM"$ 的难解性 "传染" 给其他问题.
  - $E_"TM"$ (空性不可判定)
  - $E Q_"TM"$ (等价性不可判定)
  - $E_"LBA"$ (LBA 空性不可判定)

== 计算问题的归约
#figure(
  diagram(
    node-corner-radius: 6pt,

    node((0, 0), $A_"TM"$, name: <Atm>, stroke: red),
    node((1, 0), $H_"TM"$, name: <Htm>, stroke: red),
    node((2, 0), $E_"TM"$, name: <Etm>, stroke: red),
    node((3, 0), $E Q_"TM"$, name: <Eqtm>, stroke: red),

    node((0, 1), $A_"CFG"$, name: <Acfg>),
    node((2, 1), $E_"CFG"$, name: <Ecfg>),
    node((3, 1), $E Q_"CFG"$, name: <Eqcfg>, stroke: red),

    node((0, 2), $A_"DFA"$, name: <Adfa>),
    node((2, 2), $E_"DFA"$, name: <Edfa>),
    node((3, 2), $E Q_"DFA"$, name: <Eqdfa>),

    edge(<Adfa>, <Acfg>, "->", label: $subset$, label-side: right, stroke: gray + 0.5pt),
    edge(<Acfg>, <Atm>, "->", label: $subset$, label-side: right, stroke: gray + 0.5pt),

    edge(<Atm>, <Htm>, "->"),
    edge(<Atm>, <Etm>, "->", bend: 20deg),
    edge(<Etm>, <Eqtm>, "->"),

    edge(<Adfa>, <Edfa>, "->", bend: 20deg, stroke: green),
    edge(<Edfa>, <Eqdfa>, "->", bend: 20deg, stroke: green),
  ),
)


== 总结
$
  "Regular" subset "DCFL" subset "CFL" subset "CSL (LBA)" \ subset "Decidable" subset "Recognizable (TM)"
$

= 考点
== 第一章
- DFA和NFA的具体含义 (DFA的每一个 (状态, 符号) 对都会有一个转移出去的状态)
- 给定一个正则语言, 给出对应的DFA或者NFA的形式 (包括正则语言的交, 补, 并, 连接, 星号运算得到的正则语言)
- DFA和NFA的相互转换方式
- 正则表达式与DFA, NFA的相互转换方式 (Arden引理)
- 泵引理证明语言非正则 (Myhill-Nerode定理)
- 极小化DFA的方法 (包括等价状态法, 填表法)

== 第二章
- 给定语言, 构造上下文无关文法 (包括给定正则语言, 给出对应的线性文法)
- 给定CFG, 对其进行化简
- 给定CFG, 构造对应的CNF, GNF
- 给定语言或CFG, 构造对应的PDA
- CFG的泵引理以及封闭性

== 第三章
- 图灵机, 图灵可识别 图灵可判定的具体概念
- 图灵机的稳健性 (即图灵机和其变形的能力等价)
- 给定语言, 给出对应的图灵机描述 (根据丘奇-图灵论题, 直接给出算法层面的描述)
- 证明一个语言是可判定的 (直接给出算法)
- 证明一个语言是不可判定的 (反证法, 规约)
- 了解典型的可判定, 不可判定问题

== 第四章
- 时间复杂度的概念
- 大O小o的含义
- P类和NP类的含义
- 了解典型的P类和NP类问题
- NP完全问题含义 (了解如何规约到NP完全问题)

= 例题
== epsilon-NFA to NFA
- 先写出每一个状态 $q$, 能够通过 epsilon 转移到达的状态集合 (包括自身), 设为 $"FROM"(q)$
- 再写出每一个状态 $q$, 有哪些状态 (包括自身) 能够通过 epsilon 转移到达这个状态, 设为 $"TO"(q)$
- 遍历每一个转移 $q_1 -> q_2$, 对于每一个 $q_i in "TO"(q_1)$ 和每一个 $q_j in "FROM"(q_2)$, 添加转移 $q_i -> q_j$, 在对应的符号下.

== REX to DFA
构造一个 DFA, 接受由正则表达式 $a^* + b c$ 描述的语言.

=== REX to NFA
我们先考虑构造一个 NFA. 考虑 正则表达式的结构:
#align(center)[
  #tidy-tree-graph(
    spacing: (30pt, 30pt),
    node-inset: 5pt,
    text-size: 14pt,
  )[
    - $a^* + b c$
      - $a^*$
        - $a$
      - $+$
      - $b c$
        - $b$
        - $c$
  ]
]
从最基本的组件 $a, b, c$ 开始.

$M(a)$: 接受单字符 $a$ 的 NFA:
#align(center)[
  #automaton(
    (
      q0: (q1: "a"),
    ),
    initial: "q0",
    final: ("q1",),
    layout: finite.layout.custom.with(positions: (
      q0: (0, 0),
    )),
  )
]

同理可以定义 $M(b), M(c)$:
#align(center)[
  #automaton(
    (
      q0: (q1: "b"),
    ),
    initial: "q0",
    final: ("q1",),
    layout: finite.layout.custom.with(positions: (
      q0: (0, 0),
    )),
  )


  #automaton(
    (
      q0: (q1: "c"),
    ),
    initial: "q0",
    final: ("q1",),
    layout: finite.layout.custom.with(positions: (
      q0: (0, 0),
    )),
  )
]

现在考虑 $M(a^*)$:
#align(center)[
  #automaton(
    (
      q0: (
        q0: "a",
      ),
    ),
    initial: "q0",
    final: ("q0",),
    layout: finite.layout.custom.with(positions: (
      q0: (0, 0),
    )),
  )
]

这是一个符合直觉的简化版本, 在标准的 Tompson 构造法中, 我们使用
#align(center)[
  #automaton(
    (
      q0: (
        q1: "eps",
        q3: "eps",
      ),
      q1: (
        q2: "a",
      ),
      q2: (
        q1: "eps",
        q3: "eps",
      ),
    ),
    initial: "q0",
    final: ("q3",),
    layout: finite.layout.custom.with(positions: (
      q0: (0, 0),
      q1: (2, 2),
      q2: (5, 2),
      q3: (8, 0),
    )),
    labels: (
      "q0-q1": [$epsilon$],
      "q0-q3": [$epsilon$],
      "q2-q1": [$epsilon$],
      "q2-q3": [$epsilon$],
      "q1": [In],
      "q2": [Out],
      "q3": [End],
    ),
  )
]
这样如果我们需要进行更复杂的构造, 可以直接在 In 和 Out 节点上进行连接.

接下来考虑 $M(b c)$:
#align(center)[
  #automaton(
    (
      q0: (q1: "b"),
      q1: (q2: "c"),
    ),
    initial: "q0",
    final: ("q2",),
    layout: finite.layout.custom.with(positions: (
      q0: (0, 0),
    )),
  )
]

最后得到 $M(a^* + b c)$:
#align(center)[
  #automaton(
    (
      q0: (
        q1: "eps",
        q4: "eps",
      ),
      q1: (
        q2: "b",
      ),
      q2: (
        q3: "c",
      ),
      q4: (
        q4: "a",
      ),
    ),
    initial: "q0",
    final: ("q3", "q4"),
    layout: finite.layout.custom.with(positions: (
      q0: (0, 0),
      q1: (2, 2),
      q2: (5, 2),
      q3: (8, 2),
      q4: (2, -2),
    )),
    labels: (
      "q0-q1": [$epsilon$],
      "q0-q4": [$epsilon$],
    ),
  )
]

=== NFA to DFA
一般的子集构造法步骤如下
- 写出每一个状态的 epsilon-闭包
- 整理所有的转移方程
- 从初始状态的闭包开始, 计算每一个输入符号下的转移, 形成新的状态集, 再取这个状态集的闭包, 继续计算转移, 直到没有新的状态集产生为止.


接下来我们使用子集构造法将上述 NFA 转换为 DFA. 首先准备一下每一个状态的 epsilon-闭包:
- $"epsilon-closure"(q_0) = {q_0, q_1, q_4}$
- $"epsilon-closure"(q_1) = {q_1}$
- $"epsilon-closure"(q_2) = {q_2}$
- $"epsilon-closure"(q_3) = {q_3}$
- $"epsilon-closure"(q_4) = {q_4}$

接下来我们开始构造 DFA 的状态集. 初始状态为 NFA 初始状态的 epsilon-闭包 $D_0 = {q_0, q_1, q_4}$

接下来计算从 $D_0$ 出发, 在输入符号 $a, b, c$ 下的转移:
- 在输入 $a$ 下:
  - 从 $q_0$ 出发, 没有 $a$ 转移
  - 从 $q_1$ 出发, 没有 $a$ 转移
  - 从 $q_4$ 出发, 有 $a$ 转移到 $q_4$
  - 因此, $"move"(D_0, a) = {q_4}$
- 在输入 $b$ 下:
  - 从 $q_0$ 出发, 没有 $b$ 转移
  - 从 $q_1$ 出发, 有 $b$ 转移到 $q_2$
  - 从 $q_4$ 出发, 没有 $b$ 转移
  - 因此, $"move"(D_0, b) = {q_2}$
- 在输入 $c$ 下:
  - 从 $q_0$ 出发, 没有 $c$ 转移
  - 从 $q_1$ 出发, 没有 $c$ 转移
  - 从 $q_4$ 出发, 没有 $c$ 转移
  - 因此, $"move"(D_0, c) = {}$

现在令 $D_1 = {q_4}$, $D_2 = {q_2}$.

从 $D_1$ 出发只有 $a$ 转移回 $D_1$ 本身, $b, c$ 均无转移.

从 $D_2$ 出发, 在输入 $c$ 下有转移到 $q_3$, 因此 $"move"(D_2, c) = {q_3}$, 其他输入无转移. 令 $D_3 = {q_3}$.

从 $D_3$ 出发无任何转移.

最终我们得到 DFA 的状态集:
- $D_0 = {q_0, q_1, q_4}$
- $D_1 = {q_4}$
- $D_2 = {q_2}$
- $D_3 = {q_3}$
- $D_4 = {}$ (死状态, 考试中不可省略)

新的接受状态为包含 NFA 接受状态的那些集合, 即 $D_0, D_1, D_3$.

有 DFA
#align(center)[
  #automaton(
    (
      D0: (
        D1: "a",
        D2: "b",
        D4: "c",
      ),
      D1: (
        D1: "a",
        D4: "b,c",
      ),
      D2: (
        D3: "c",
        D4: "a,b",
      ),
      D3: (
        D4: "a,b,c",
      ),
    ),
    initial: "D0",
    final: ("D0", "D1", "D3"),
    layout: finite.layout.custom.with(positions: (
      D0: (0, 0),
      D1: (4, -2),
      D2: (4, 2),
      D3: (8, 2),
      D4: (8, -2),
    )),
  )
]

== Arden引理
设 $P$ 和 $Q$ 是正则表达式, 则关于正则表达式 $X$ 的方程 $X = Q + X P$ 的解为 $X = Q P^*$. 如果 $epsilon in.not L(P)$, 则该解是唯一的.

另一种形式:
$
  X = Q + P X ==> X = P^* Q
$

*例子*:
考虑如下的 DFA:
#align(center)[
  #automaton(
    (
      q0: (q1: "0", q0: "1"),
      q1: (q2: "1", q0: "0"),
      q2: (q2: "0 + 1"),
    ),
    initial: "q0",
    final: ("q2",),
    style: (
      state: (radius: 0.8),
    ),
    layout: finite.layout.custom.with(positions: (
      q0: (0, 0),
      q1: (5, 0),
      q2: (5, -5),
    )),
  )
]
1. 定义正则表达式: $R_0, R_1, R_2$ 分别表示从初始状态 $q_0$ 出发到达状态 $q_0, q_1, q_2$ 的所有字符串的集合.
2. 写出方程:
  - 对于状态 $q_0$: $R_0 = R_0 1 + R_1 0 + epsilon$
  - 对于状态 $q_1$: $R_1 = R_0 0$
  - 对于状态 $q_2$: $R_2 = R_1 1 + R_2 0 + R_2 1$
3. 求解方程:
  - 从第二个方程得到 $R_1 = R_0 0$.
  - 将 $R_1$ 代入第一个方程, 得到 $R_0 = R_0 1 + R_0 0 0 + epsilon = R_0 (1 + 00) + epsilon$. 根据 Arden 引理, 得到 $R_0 = epsilon (1 + 00)^* = (1 + 00)^*$.
  - 将 $R_1$ 代入第三个方程, 得到 $R_2 = R_0 0 1 + R_2 (0 + 1)$. 根据 Arden 引理, 得到 $R_2 = R_0 0 1 (0 + 1)^* = (1 + 00)^* 0 1 (0 + 1)^*$.
4. 语言 $L(M)$ 可以表示为 $R_2$: $L(M) = R_2 = (1 + 00)^* 0 1 (0 + 1)^*$.

== 极小化 DFA

#align(center)[
  #automaton(
    (
      A: ("B": "0", "C": "1"),
      B: ("B": "0", "D": "1"),
      C: ("B": "0", "C": "1"),
      D: ("B": "0", "E": "1"),
      E: ("B": "0", "C": "1"),
    ),
    initial: "A",
    final: ("E",),
    layout: finite.layout.custom.with(positions: (
      A: (-3, 0),
      B: (1, 2),
      C: (1, -2),
      D: (5, 2),
      E: (5, -2),
    )),
  )
]

1. 划分 $0$-等价类:
- 接受状态类: $F = { E }$
- 非接受状态类: $Q \\ F = { A \, B \, C \, D }$
2. 划分 $1$-等价类:
- 状态 $A, B$ 和 $C$ 属于同一类, 因为它们在输入符号 `0` 和 `1` 下都转移到非接受状态类.
- 状态 $D$ 属于单独一类, 因为它在输入符号 `1` 下转移到接受状态类.
- 因此, $1$-等价类为: ${ A \, B \, C }$ 和 ${ D }$ 以及 ${ E }$.
3. 划分 $2$-等价类:
- 状态 $A$ 和 $C$ 属于同一类, 状态 $B$ 属于单独一类, 状态 $D$ 和 $E$ 仍然分别属于各自的类.
- 因此, $2$-等价类为: ${ A \, C }$ 和 ${ B }$ 以及 ${ D }$ 和 ${ E }$.
4. 划分 $3$-等价类:
- 划分结果与 $2$-等价类相同, 因为 $A, C$ 无法在长度为 $3$ 的输入字符串下区分开来.
5. 构造极小化 DFA:
#align(center)[
  #automaton(
    (
      AC: ("B": "0", "AC": "1"),
      B: ("B": "0", "D": "1"),
      D: ("B": "0", "E": "1"),
      E: ("B": "0", "AC": "1"),
    ),
    initial: "AC",
    final: ("E",),
    layout: finite.layout.custom.with(positions: (
      AC: (-3, 0),
      B: (1, 2),
      D: (5, 2),
      E: (5, -2),
    )),
  )
]

#align(center)[ #automaton(
  (
    A: ("B": "0", "C": "1"),
    B: ("D": "0", "A": "1"),
    C: ("E": "0", "A": "1"),
    D: ("D": "0", "F": "1"),
    E: ("E": "0", "G": "1"),
    F: ("F": "0,1"),
    G: ("G": "0", "A": "1"),
    H: ("A": "0,1"),
  ),
  initial: "A",
  final: ("D", "E"),
  layout: finite.layout.custom.with(positions: (
    A: (-4, 0),
    B: (-2, 2),
    C: (-2, -2),
    D: (1, 2),
    E: (1, -2),
    F: (4, 2),
    G: (4, -2),
    H: (-4, 3),
  )),
) ]

答案: 只有 $B, C$ 能被合并
== 泵引理 (RL + CFL)
=== RL
设 $L$ 是一个正则语言, 则存在一个整数 $p >= 1$, 使得对于任意字符串 $s in L$ 且 $|s| >= p$, 都可以将 $s$ 分割为三个子串 $s = x y z$, 满足以下条件:
1. $|y| >= 1$ (子串 $y$ 非空)
2. $|x y| <= p$ (子串 $x y$ 的长度不超过 $p$)
那么对于所有整数 $i >= 0$, 字符串 $x y^i z in L$

=== CFL
设 $L$ 是一个上下文无关语言, 则存在一个整数 $p >= 1$, 使得对于任意字符串 $s in L$ 且 $|s| >= p$, 都可以将 $s$ 分割为五个子串 $s = u v x y z$, 满足以下条件:
1. $|v y| >= 1$ (子串 $v$ 和 $y$ 中至少有一个非空)
2. $|v x y| <= p$ (子串 $v x y$ 的长度不超过 $p$)

那么对于所有整数 $i >= 0$, 字符串 $u v^i x y^i z in L$

== CFG 的化简
1. 删除空产生式 (注意形如 $A -> a a A | epsilon$ 的, 不只是其他生成 $A$ 的地方要改, 还有给自己也加上 $A -> a a A | a a$)
2. 删除单一产生式 (形如 $A -> B$, 把 $B$ 的产生式都加到 $A$ 上)
3. 删除无用符号 (包括 a. 不可达符号 b. 无法推出终结符)


== CFG to CNF/GNF
先删除空产生式和单一产生式

构造与下列文法等价的 CNF
$
  S -> a B B | b A A \
  B -> a B a | a a | epsilon \
  A -> b b A | epsilon
$

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


构造与下列文法等价的 GNF
$
  S -> A B b | a \
  A -> a a A | B \
  B -> b A b
$

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

== PDA 模拟
注意栈顶在字符串的最左边.
== CFG to PDA
PDA 的初始栈符号为文法的开始符号 $S$, 且只需要一个状态 $q$, 不存在接受状态.

对于每一个产生式 $A -> alpha | beta | ...$, PDA 有一个 epsilon 转移, 将栈顶的 $A$ 替换为 $alpha$, 即
$
  delta (q, epsilon, A) = {(q, alpha) , (q, beta), ... }
$
对于每一个符号 $a in Sigma$, PDA 有一个转移, 当输入符号为 $a$ 且栈顶符号为 $a$ 时, 弹出栈顶符号 $a$, 即
$
  delta (q, a, a) = {(q, epsilon)}
$

== 典型的 CFG 构造
1. 生成一个 $1$ 和 个 $0$ 数量相等的字符串:
$
  S-> 0 S 1 | 1 S 0 | S S | epsilon
$
2. 生成一个 $a$ 数量是 $b$ 数量的 $k$ 倍的字符串:
先给出所有 $a^k b$ 的全排列, 然后对每一个排列添加
$
  S -> S x_1 S x_2 S ... S x_(k+1)
$

== P 和 NP 类问题举例
=== P 类问题
- 判断一个图中有向路径是否存在的问题
- 互素问题
- 每一个上下文无关语言的成员资格问题

=== NP 类问题
- 哈密尔顿路径问题
- 子集和问题

=== NP 完全问题
- 3-SAT 问题
- 哈密尔顿路径问题
- 子集和问题
