#import "@preview/finite:0.5.0": automaton
#import "@preview/finite:0.5.0"

#set text(15pt, font:("Libertinus Serif", "Source Han Serif SC"))
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
#automaton(
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