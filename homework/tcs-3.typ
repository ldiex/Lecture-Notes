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


