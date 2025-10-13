#import "@preview/finite:0.5.0": automaton
#import "@preview/finite:0.5.0"

#set text(15pt, font:("Libertinus Serif", "Source Han Serif SC"))

#show heading.where(level: 1): set text(blue)
#show heading.where(level: 2): set text(green)
#show heading.where(level: 3): set text(purple)
#show ref: it => {
  text(green, it)
}
= L1.3 - L1.5
== 1

#automaton(
  (
    A: (B:"epsilon, c", C: "a, c"),
    B: (),
    C: (A: "epsilon, b", B: "b", C: "c")
  ),
  initial: "A",
  final: (none,),
  layout: finite.layout.custom.with(positions: (
    A: (0, 0),
    C: (4, -3),
    B: (8, 0),
  ))
) 
我们先计算所有状态的 $epsilon$-闭包:
1. $E(A) = {A, B}$, 因为 $A$ 通过 $epsilon$ 转移可以到达 $B$.
2. $E(B) = {B}$
3. $E(C) = {A, B, C}$, 因为 $C$ 通过 $epsilon$ 转移可以到达 $A$, 而 $A$ 又通过 $epsilon$ 转移可以到达 $B$.

由此, 我们可以定义新的状态转移函数 $delta'$:
1. 从 $E(A) = {A, B}$ 出发, 对于输入符号 $a$, 只能去到中间状态 $C$, 因此最后可以到达的目的地为 $E(C) = {A, B, C}$; 对于输入符号 $b$, 哪里都去不了; 对于输入符号 $c$, 可以去到 $A$ 和 $C$, 因此最后可以到达的目的地为 $E(A) union E(C) = {A, B, C}$.
2. 从 $E(B) = {B}$ 出发, 无论输入什么符号, 都哪里都去不了.
3. 从 $E(C) = {A, B, C}$ 出发, 对于输入符号 $a$, 只能去到中间状态 $C$, 因此最后可以到达的目的地为 $E(C) = {A, B, C}$; 对于输入符号 $b$, 可以去到 $A$ 和 $B$, 因此最后可以到达的目的地为 $E(A) union E(B) = {A, B}$; 对于输入符号 $c$, 可以去到 $B$ 和 $C$, 因此最后可以到达的目的地为 $E(B) union E(C) = {A, B, C}$.

所以新的不含 $epsilon$ 转移的 NFA 如下:
#figure(
  automaton(
    (
      A: (A: "a, c", B: "a, c", C: "a, c"),
      B: (),
      C: (A: "a, b, c", B: "a, b, c", C: "a, c")
    ),
    initial: "A",
    final: (none,),
    layout: finite.layout.custom.with(positions: (
      A: (0, 0),
      C: (4, -3),
      B: (8, 0),
    ))
  )
) <1-3-1>
== 2
=== 2.1
#automaton(
  (
    q1: (q1: "0,1", q2: "1"),
    q2: (q3: "0,1"),
  ),
  initial: "q1",
  final: ("q3",),
)

我们使用子集构造法来将该 NFA 转换为 DFA.
1. 我们的初始状态是 ${q_1}$, 从这个状态出发, 对于输入 $0$, 仍然是回到 ${q_1}$; 对于输入 $1$, 可以去到 ${q_1, q_2}$.
2. 考虑新状态 ${q_1, q_2}$, 对于输入 $0$, 可以到达 ${q_1, q_3}$; 对于输入 $1$, 仍然是 ${q_1, q_2}$.
3. 考虑新状态 ${q_1, q_3}$, 对于输入 $0$, 仍然是 ${q_1, q_3}$; 对于输入 $1$, 可以到达 ${q_1, q_2, q_3}$.
所有包含 $q_3$ 的状态都是接受状态, 所以 ${q_1, q_3}$ 和 ${q_1, q_2, q_3}$ 都是接受状态. 由此我们可以构造出如下的 DFA:
#automaton(
  (
    q1: (q1: "0", q1_q2: "1"),
    q1_q2: (q1_q3: "0", q1_q2: "1"),
    q1_q3: (q1_q3: "0", q1_q2_q3: "1"),
    q1_q2_q3: (q1_q3: "0", q1_q2_q3: "1"),
  ),
  initial: "q1",
  final: ("q1_q3", "q1_q2_q3"),
  labels: (
    q1: ${q_1}$,
    q1_q2: ${q_1, q_2}$,
    q1_q3: ${q_1, q_3}$,
    q1_q2_q3: ${q_1, q_2, q_3}$
  ),
  style: (
    state: (radius: 1.4)
  )
)
=== 2.2
#automaton(
  (
    A: (B:"epsilon, c", C: "a, c"),
    B: (),
    C: (A: "epsilon, b", B: "b", C: "c")
  ),
  initial: "A",
  final: (none,),
  layout: finite.layout.custom.with(positions: (
    A: (0, 0),
    C: (4, -3),
    B: (8, 0),
  ))
)

在 @1-3-1 中我们已经把这个 NFA 转换成了不含 $epsilon$ 转移的 NFA, 现在我们继续将其转换为 DFA.
1. 初始状态是 ${A}$, 对于输入 $a$, 可以去到 ${A, B, C}$; 对于输入 $b$, 哪里都去不了; 对于输入 $c$, 可以去到 ${A, B, C}$.
2. 考虑新状态 ${A, B, C}$, 对于输入 $a$, 仍然是 ${A, B, C}$; 对于输入 $b$, 可以去到 ${A, B}$; 对于输入 $c$, 仍然是 ${A, B, C}$.
3. 考虑新状态 ${A, B}$, 对于输入 $a$, 可以去到 ${A, B, C}$; 对于输入 $b$, 哪里都去不了; 对于输入 $c$, 可以去到 ${A, B, C}$.
所以我们可以构造出如下的 DFA:
#automaton(
  (
    A: (A_B_C: "a, c"),
    A_B_C: (A_B_C: "a, c", A_B: "b"),
    A_B: (A_B_C: "a, c"),
  ),
  initial: "A",
  final: (none,),
  labels: (
    A: ${A}$,
    A_B_C: ${A, B, C}$,
    A_B: ${A, B}$,
  ),
  style: (
    state: (radius: 1.4)
  ),
)

= 3
设 $Sigma = {a, b}$, 构造识别下列语言的 NFA: 
$
  {w | w "ends with" a b b}
$
并将其转化为等价的 DFA.

#automaton(
  (
    q1: (q1: "a, b", q2: "a"),
    q2: (q3: "b", q1: "a"),
    q3: (q4: "b", q1: "a"),
    q4: (q1: "a, b"),
  ),
  initial: "q1",
  final: ("q4",),
  layout: finite.layout.custom.with(positions:(
    q1: (0, 0),
    q2: (3, 0),
    q3: (3, -3),
    q4: (0, -3),
  ))
)

我们使用子集构造法来将该 NFA 转换为 DFA.
1. 我们的初始状态是 ${q_1}$, 从这个状态出发, 对于输入 $a$, 可以去到 ${q_1, q_2}$; 对于输入 $b$, 仍然是回到 ${q_1}$.
2. 考虑新状态 ${q_1, q_2}$, 对于输入 $b$, 可以到达 ${q_1, q_3}$; 对于输入 $a$, 则是回到 ${q_1}$
3. 考虑新状态 ${q_1, q_3}$, 对于输入 $b$, 可以到达 ${q_1, q_4}$; 对于输入 $a$, 则是回到 ${q_1, q_2}$
4. 考虑新状态 ${q_1, q_4}$, 对于输入 $a, b$, 都是回到 ${q_1}$
所有包含 $q_4$ 的状态都是接受状态, 所以 ${q_1, q_4}$ 是接受状态. 由此我们可以构造出如下的 DFA:
#automaton(
  (
    q1: (q1: "b", q1_q2: "a"),
    q1_q2: (q1: "a", q1_q3: "b"),
    q1_q3: (q1: "a", q1_q4: "b"),
    q1_q4: (q1: "a, b"),  
  ),
  initial: "q1",
  final: ("q1_q4",),
  labels: (
    q1: ${q_1}$,
    q1_q2: ${q_1, q_2}$,
    q1_q3: ${q_1, q_3}$,
    q1_q4: ${q_1, q_4}$,
  ),
  style: (
    state: (radius: 1)
  ),
  layout: finite.layout.custom.with(positions: (
    q1: (0, 0),
    q1_q2: (5, 0),
    q1_q3: (5, -5),
    q1_q4: (0, -5),
  ))
)