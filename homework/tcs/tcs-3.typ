#import "@preview/finite:0.5.0": automaton
#import "@preview/finite:0.5.0"

#set text(15pt, font:("Libertinus Serif", "Source Han Serif SC"))

#show heading.where(level: 1): set text(blue)
#show heading.where(level: 2): set text(green)
#show heading.where(level: 3): set text(purple)
#show ref: it => {
  text(green, it)
}
= L1.6 - L1.9
== 1
构造识别如下语言的 NFA, 所有问题中的字母表都为 $Sigma = {0, 1}$.
- ${w | w "ends with" 00}$, 3 个状态
#align(center)[
  #automaton(
    (
      q1: (q1: "0,1", q2: "0"),
      q2: (q3: "0", q1: "1"),
      q3: (q1: "0,1") 
    ),
    initial: "q1",
    final: ("q3",),
    layout: finite.layout.custom.with(positions:(
      q1: (0, 0),
      q2: (3, 0),
      q3: (3, -3),
    ))
  )
]
- ${w | w "has even number of 0's" or w "has exact two 1's"}$, 6 个状态
#align(center)[
  #automaton(
    (
      q1: (q2: "0", q1: "1", q3: "epsilon"),
      q2: (q1: "0", q2: "1"),
      q3: (q4: "1", q3: "0"),
      q4: (q5: "1", q4: "0"),
      q5: (q5: "0", q6: "1"),
    ),
    initial: "q1",
    final: ("q1", "q5"),
    labels: (
      "q1-q3": [$epsilon$],
    ),
    layout: finite.layout.custom.with(positions:(
      q1: (3, 0),
      q2: (6, 0),
      q3: (3, -3),
      q4: (3, -6),
      q5: (6, -6),
      q6: (6, -3),
    ))
  )
]

== 2
构造识别如下语言的 NFA.
- $A = {w | w "has substring" 0101}$
#align(center)[
  #automaton(
    (
      q1: (q1: "0,1", q2: "0"),
      q2: (q3: "1", q1: "0"),
      q3: (q4: "0", q1: "1"),
      q4: (q5: "1", q1: "0"),
      q5: (q5: "0,1"),
    ),
    initial: "q1",
    final: ("q5",),
    layout: finite.layout.custom.with(positions:(
      q1: (0, 0),
      q2: (3, 0),
      q3: (6, 0),
      q4: (9, 0),
      q5: (12, 0),
    ))
  )
]
- $B = {w | w "does not have substring" 110}$
对此, 我们先构造识别 $B^c$ 的 NFA:
#align(center)[
  #automaton(
    (
      p1: (p1: "0,1", p2: "1"),
      p2: (p3: "1", p1: "0"),
      p3: (p4: "0", p3: "1"),
      p4: (p4: "0,1"),
    ),
    initial: "p1",
    final: ("p4",),
    layout: finite.layout.custom.with(positions:(
      p1: (0, 0),
      p2: (3, 0),
      p3: (6, 0),
      p4: (9, 0),
    ))
  )
]
然后通过状态补全法得到识别 $B^c$ 的 DFA:
#align(center)[
  #automaton(
    (
      p1: (p1: "0", p1_p2: "1"),
      p1_p2: (p1: "0", p1_p2_p3: "1"),
      p1_p2_p3: (p1_p4: "0", p1_p2_p3: "1"),
      p1_p4: (p1_p4: "0,1"),
    ),
    initial: "p1",
    final: ("p1_p4",),
    style: (
      state: (radius: 1.3)
    ),
    labels: (
      p1: ${p_1}$,
      p1_p2: ${p_1, p_2}$,
      p1_p2_p3: ${p_1, p_2, p_3}$,
      p1_p4: ${p_1, p_4}$,
    ),
  )
]
现在我们通过交换接受状态和非接受状态来得到识别 $B$ 的 DFA:
#align(center)[
  #automaton(
    (
      p1: (p1: "0", p1_p2: "1"),
      p1_p2: (p1: "0", p1_p2_p3: "1"),
      p1_p2_p3: (p1_p4: "0", p1_p2_p3: "1"),
      p1_p4: (p1_p4: "0,1"),
    ),
    initial: "p1",
    final: ("p1", "p1_p2", "p1_p2_p3"),
    style: (
      state: (radius: 1.3)
    ),
    labels: (
      p1: ${p_1}$,
      p1_p2: ${p_1, p_2}$,
      p1_p2_p3: ${p_1, p_2, p_3}$,
      p1_p4: ${p_1, p_4}$,
    ),
  )
]

为了方便下一题的符号表达, 这里简化状态符号为 ${p_1} -> p_1$, ${p_1, p_2} -> p_2$, ${p_1, p_2, p_3} -> p_3$, ${p_1, p_4} -> p_4$, 有
#align(center)[
  #automaton(
    (
      p1: (p1: "0", p2: "1"),
      p2: (p1: "0", p3: "1"),
      p3: (p4: "0", p3: "1"),
      p4: (p4: "0,1"),
    ),
    initial: "p1",
    final: ("p1", "p2", "p3"),
    style: (
      state: (radius: 0.8)
    ),
  )
]
- $A union B$, $A circle.small B, B^* $
对于 $A union B$, 我们可以通过添加一个新的初始状态 $q_0'$ 和两个 $epsilon$ 转移, 分别从 $q_0'$ 指向 $A$ 和 $B$ 的初始状态来构造 NFA:
#align(center)[
  #automaton(
    (
      q0: (q1: "epsilon", p1: "epsilon"),
      q1: (q1: "0,1", q2: "0"),
      q2: (q3: "1", q1: "0"),
      q3: (q4: "0", q1: "1"),
      q4: (q5: "1", q1: "0"),
      q5: (q5: "0,1"),
      p1: (p1: "0", p2: "1"),
      p2: (p1: "0", p3: "1"),
      p3: (p4: "0", p3: "1"),
      p4: (p4: "0,1"),
    ),
    initial: "q0",
    final: ("q5", "p1", "p2", "p3"),
    labels: (
      "q0-q1": [$epsilon$],
      "q0-p1": [$epsilon$],
    ),
    layout: finite.layout.custom.with(positions:(
      q0: (0, 0),
      q1: (3, 2),
      q2: (6, 2),
      q3: (9, 2),
      q4: (12, 2),
      q5: (15, 2),
      p1: (3, -2),
      p2: (6, -2),
      p3: (9, -2),
      p4: (12, -2),
    ))
  )
]

对于 $A circle.small B$, 我们可以通过将 $A$ 的所有接受状态与 $B$ 的初始状态通过 $epsilon$ 转移连接起来来构造 NFA:
#align(center)[
  #automaton(
    (
      q1: (q1: "0,1", q2: "0"),
      q2: (q3: "1", q1: "0"),
      q3: (q4: "0", q1: "1"),
      q4: (q5: "1", q1: "0"),
      q5: (p1: "epsilon"),
      p1: (p1: "0", p2: "1"),
      p2: (p1: "0", p3: "1"),
      p3: (p4: "0", p3: "1"),
      p4: (p4: "0,1"),
    ),
    initial: "q1",
    final: ("p1", "p2", "p3"),
    labels: (
      "q5-p1": [$epsilon$],
    ),
    layout: finite.layout.custom.with(positions:(
      q1: (0, 2),
      q2: (3, 2),
      q3: (6, 2),
      q4: (9, 2),
      q5: (12, 2),
      p1: (12, -2),
      p2: (9, -2),
      p3: (6, -2),
      p4: (3, -2),
    ))
  )
]

对于 $B^*$, 我们可以通过添加一个新的初始状态 $q_0'$ 和一个新的接受状态 $q_f'$. 然后, 添加两个 $epsilon$ 转移, 一个从 $q_0'$ 指向 $B$ 的初始状态, 另一个从 $B$ 的所有接受状态指向 $q_0'$. 另外, 添加一个 $epsilon$ 转移从 $q_0'$ 指向 $q_f'$, 以允许接受空串来构造 NFA:
#align(center)[
  #automaton(
    (
      q0: (p1: "epsilon", qf: "epsilon"),
      p1: (p1: "0", p2: "1", q0: "epsilon"),
      p2: (p1: "0", p3: "1", q0: "epsilon"),
      p3: (p4: "0", p3: "1", q0: "epsilon"),
      p4: (p4: "0,1"),
    ),
    initial: "q0",
    final: ("p1", "p2", "p3", "qf"),
    labels: (
      "q0-p1": [$epsilon$],
      "q0-qf": [$epsilon$],
      "p1-q0": [$epsilon$],
      "p2-q0": [$epsilon$],
      "p3-q0": [$epsilon$],
    ),
    layout: finite.layout.custom.with(positions:(
      q0: (0, -3),
      qf: (0, 0),  
      p1: (3, 0),
      p2: (6, 0),
      p3: (9, 0),
      p4: (12, 0),
    ))
  )
]

== 3
给出识别下列语言的 NFA, 字母表均为 ${0, 1}$
- ${w | w "ends with" 00}$, 3 个状态
#align(center)[
  #automaton(
    (
      q1: (q1: "0,1", q2: "0"),
      q2: (q3: "0", q1: "1"),
      q3: (q1: "1", q3: "0")
    ),
    initial: "q1",
    final: ("q3",),
    layout: finite.layout.custom.with(positions:(
      q1: (0, 0),
      q2: (3, 0),
      q3: (3, -3),
    ))
  )
]

- $0^*1^*0^+$, 3 个状态
#align(center)[
  #automaton(
    (
      q1: (q1: "0", q2: "1", q3: "0"),
      q2: (q2: "1", q3: "0"),
      q3: (q3: "0"),
    ),
    initial: "q1",
    final: ("q3",),
    layout: finite.layout.custom.with(positions:(
      q1: (0, 0),
      q2: (3, 0),
      q3: (3, -3),
    ))
  )
]

- ${w | w "has substring" 0101}$, 5 个状态
#align(center)[
  #automaton(
    (
      q1: (q1: "0,1", q2: "0"),
      q2: (q3: "1", q1: "0"),
      q3: (q4: "0", q1: "1"),
      q4: (q5: "1", q1: "0"),
      q5: (q5: "0,1"),
    ),
    initial: "q1",
    final: ("q5",),
    layout: finite.layout.custom.with(positions:(
      q1: (0, 0),
      q2: (3, 0),
      q3: (6, 0),
      q4: (9, 0),
      q5: (12, 0),
    ))
  )
]

- ${w | w "has even number of 0's or exactly two 1's"}$, 6 个状态
#align(center)[
  #automaton(
    (
      q1: (q2: "0", q1: "1", q3: "epsilon"),
      q2: (q1: "0", q2: "1"),
      q3: (q4: "1", q3: "0"),
      q4: (q5: "1", q4: "0"),
      q5: (q5: "0", q6: "1"),
    ),
    initial: "q1",
    final: ("q1", "q5"),
    labels: (
      "q1-q3": [$epsilon$],
    ),
    layout: finite.layout.custom.with(positions:(
      q1: (3, 0),
      q2: (6, 0),
      q3: (3, -3),
      q4: (3, -6),
      q5: (6, -6),
      q6: (6, -3),
    ))
  )
]

== 4
给出识别下列语言的并集的 NFA, 字母表均为 ${0, 1}$
- ${w | w "starts with 1 and ends with 0"} union {w | w "has at least three 1's"}$
#align(center)[
  #automaton(
    (
      q0: (q1: "epsilon", p1: "epsilon"),
      q1: (q2: "1"),
      q2: (q2: "0,1", q3: "0"),
      p1: (p2: "1", p1: "0"),
      p2: (p3: "1", p2: "0"),
      p3: (p4: "1", p3: "0"),
      p4: (p4: "0,1"),
    ),
    initial: "q0",
    final: ("q3", "p4"),
    labels: (
      "q0-q1": [$epsilon$],
      "q0-p1": [$epsilon$],
    ),
    layout: finite.layout.custom.with(positions:(
      q0: (0, 0),
      q1: (3, 2),
      q2: (6, 2),
      q3: (9, 2),
      p1: (3, -2),
      p2: (6, -2),
      p3: (9, -2),
      p4: (12, -2),
    ))
  )
]

== 5
给出识别下列语言的连接的 NFA, 字母表均为 ${0, 1}$
- ${w | abs(w) <= 5} circle.small {w | w "has 1 on all its odd positions"}$
首先, 我们构造识别 ${w | abs(w) <= 5}$ 的 NFA:
#align(center)[
  #automaton(
    (
      q0: (q1: "0,1", qf: "epsilon"),
      q1: (q2: "0,1", qf: "epsilon"),
      q2: (q3: "0,1", qf: "epsilon"),
      q3: (q4: "0,1", qf: "epsilon"),
      q4: (q5: "0,1", qf: "epsilon"),
      q5: (qf: "epsilon"),
      qf: (),
    ),
    initial: "q0",
    final: ("qf"),
    labels: (
      "q0-qf": [$epsilon$],
      "q1-qf": [$epsilon$],
      "q2-qf": [$epsilon$],
      "q3-qf": [$epsilon$],
      "q4-qf": [$epsilon$],
      "q5-qf": [$epsilon$],
    ),
    layout: finite.layout.custom.with(positions:(
      q0: (0, 0),
      q1: (3, 0),
      q2: (6, 0),
      q3: (6, -3),
      q4: (6, -6),
      q5: (3, -6),
      qf: (0, -6),
    ))
  )
]

然后, 我们构造识别 ${w | w "has 1 on all its odd positions"}$ 的 NFA:
#align(center)[
  #automaton(
    (
      p0: (p1: "epsilon", p3: "epsilon"),
      p1: (p2: "1"),
      p2: (p1: "0,1"),
    ),
    initial: "p0",
    final: ("p2", "p3"),
    labels: (
      "p0-p1": [$epsilon$],
      "p0-p3": [$epsilon$],
    ),
    layout: finite.layout.custom.with(positions:(
      p0: (0, 0),
      p1: (3, 0),
      p2: (6, 0),
      p3: (0, -3),
    ))
  )
]

最后, 我们通过将第一个 NFA 的所有接受状态与第二个 NFA 的初始状态通过 $epsilon$ 转移连接起来来构造 NFA:
#align(center)[
  #automaton(
    (
      q0: (q1: "0,1", qf: "epsilon"),
      q1: (q2: "0,1", qf: "epsilon"),
      q2: (q3: "0,1", qf: "epsilon"),
      q3: (q4: "0,1", qf: "epsilon"),
      q4: (q5: "0,1", qf: "epsilon"),
      q5: (qf: "epsilon"),
      qf: (p1: "epsilon", p3: "epsilon"),
      p1: (p2: "1"),
      p2: (p1: "0,1"),
    ),
    initial: "q0",
    final: ("p2", "p3"),
    labels: (
      "q0-qf": [$epsilon$],
      "q1-qf": [$epsilon$],
      "q2-qf": [$epsilon$],
      "q3-qf": [$epsilon$],
      "q4-qf": [$epsilon$],
      "q5-qf": [$epsilon$],
      "qf-p1": [$epsilon$],
      "qf-p3": [$epsilon$],
    ),
    layout: finite.layout.custom.with(positions:(
      q0: (0, 3),
      q1: (3, 3),
      q2: (6, 3),
      q3: (6, 0),
      q4: (6, -3),
      q5: (3, -3),
      qf: (0, -3),
      p1: (3, -6),
      p2: (6, -6),
      p3: (0, -6),
    ))
  )
]

== 6
给出识别下列语言星号闭包的 NFA, 字母表均为 ${0, 1}$
- ${w | w "has at least three 1's"}$
#align(center)[
  #automaton(
    (
      q1: (q2: "1", q1: "0"),
      q2: (q3: "1", q2: "0"),
      q3: (q4: "1", q3: "0"),
      q4: (q4: "0,1", q0: "epsilon"),
      q0: (q1: "epsilon", qf: "epsilon"),
    ),
    initial: "q0",
    final: ("qf"),
    labels: (
      "q0-q1": [$epsilon$],
      "q0-qf": [$epsilon$],
      "q4-q0": [$epsilon$],
    ),
    layout: finite.layout.custom.with(positions:(
      q0: (0, 0),
      q1: (3, 0),
      q2: (6, 0),
      q3: (9, 0),
      q4: (12, 0),
      qf: (0, -3),
    ))
  ) 
]

- ${w | w "has least two 0's and at most one 1"}$
#align(center)[
  #automaton(
    (
      q0: (p0: "epsilon", qf: "epsilon"),
      p0: (p1: "0", p3: "1"),
      p1: (p2: "0", p4: "1"),
      p2: (p2: "0", p5: "1", qf: "epsilon"),
      p3: (p6: "0"),
      p4: (p5: "0"),
      p5: (p5: "0", qf: "epsilon"),
      p6: (p7: "0"),
      p7: (p7: "0", qf: "epsilon"),
    ),
    initial: "p0",
    final: ("p2", "p5", "p7"),
    labels: (
      "q0-p0": [$epsilon$],
      "p2-qf": [$epsilon$],
      "p5-qf": [$epsilon$],
      "p7-qf": [$epsilon$],
      "q0-qf": [$epsilon$],
    ),
    layout: finite.layout.custom.with(positions:(
      q0: (0, -3),
      p0: (0, 0),
      p1: (3, 0),
      p2: (6, 0),
      p3: (3, -3),
      p4: (6, -3),
      p5: (9, -3),
      p6: (6, -6),
      p7: (9, -6),
      qf: (0, -6),
    ))
  )
]

== 7
写出表示下列语言的正则表达式
- 字母表 ${a, b, c}$ 上包含至少一个 $a$ 和一个 $b$ 的所有字符串的集合
$
  (a + b + c)^* a (a + b + c)^* b (a + b + c)^* \
  + (a + b + c)^* b (a + b + c)^* a (a + b + c)^*
$
- 倒数第10个符号是1的01串的集合
$
  (0 + 1)^* 1 (0 + 1)^9
$
- 最多只有一对连续1的01串的集合
$
[(epsilon + 1)0]^*[epsilon + 1 + 11(0 +01)^*]
$
- 0 的个数被 5 整除的01串的集合
$
  (1^* 01^*01^*01^*01^*01^* )^*
$
- 不包含子串 101 的01串的集合
$
0^* (1^+ (00^+ + epsilon))^* 0^*
$
- 0 的个数被 5 整除且 1 的个数为偶数的01串的集合

== 8
给出下列正则表达式的自然语言描述
- $(1 + epsilon) (00^* 1)^* 0^*$

表示所有以 1 开头 (可以没有), 后跟零个或多个 "一个 0 后跟零个或多个 0 再跟一个 1" 的重复序列, 最后以零个或多个 0 结尾的字符串集合.

- $(0^*1^*)^* 000 (0 + 1)^*$
表示所有包含至少三个连续 0 的字符串集合

- $(0 + 10)^* 1^*$
表示所有由零个或多个 "一个 0 或一个 1 后跟一个 0" 的重复序列后跟零个或多个 1 组成的字符串集合.

== 9
把下列正则表达式转化为带 $epsilon$ 转移的 NFA

- $01^*$
#align(center)[
  #automaton(
    (
      q1: (q2: "0"),
      q2: (q2: "1", q3: "epsilon"),
      q3: (),
    ),
    initial: "q1",
    final: ("q3",),
    labels: (
      "q2-q3": [$epsilon$],
    ),
    layout: finite.layout.custom.with(positions:(
      q1: (0, 0),
      q2: (3, 0),
      q3: (6, 0),
    ))
  )
]

- $(0 + 1) 01$
#align(center)[
  #automaton(
    (
      q1: (q2: "0,1"),
      q2: (q3: "0"),
      q3: (q4: "1"),
      q4: (),
    ),
    initial: "q1",
    final: ("q4",),
    layout: finite.layout.custom.with(positions:(
      q1: (0, 0),
      q2: (3, 0),
      q3: (6, 0),
      q4: (9, 0),
    ))
  )
]

- $00 (0 + 1)^*$
#align(center)[
  #automaton(
    (
      q1: (q2: "0"),
      q2: (q3: "0"),
      q3: (q3: "0,1"),
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

== 10
把以下 DFA 转化为正则表达式
#align(center)[
  #automaton(
    (
      q1: (q1: "a", q2: "b"),
      q2: (q1: "b", q2: "a"),
    ),
    initial: "q1",
    final: ("q2",),
  )
]

答案: $a^* b a^* (b a^* b a^*)^*$

#align(center)[
  #automaton(
    (
      q1: (q2: "a,b"),
      q2: (q3: "b", q2: "a"),
      q3: (q1: "a", q2: "b"),
    ),
    initial: "q1",
    final: ("q3","q1"),
  
]

答案: $((a + b) a^* b (b a^* b)^* a)(epsilon + (a+b)a^*b(b a^* b)^*)$

