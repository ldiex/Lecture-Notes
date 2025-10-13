#import "@preview/finite:0.5.0": automaton
#import "@preview/finite:0.5.0"

#set heading(numbering: "1.")
#set text(14pt, font:("Libertinus Serif", "Source Han Serif SC"))
#set page(numbering: "1")

#show heading.where(level: 1): set text(blue)
#show heading.where(level: 2): set text(green)
#show heading.where(level: 3): set text(purple)
#show ref: it => {
  text(green, it)
}
#align(center)[
  #text("Theoretic Computer Science", 20pt)
]

#outline(depth: 2)

= 数学术语
== 字符串和语言
=== 字母表
任意非空有穷集合: 
- $Sigma = {0 \, 1}$ 
- $Sigma = {a \, b \, c \, dots.h \, x \, y \, z \, upright("space")}$
=== (字符) 串 
字母的有穷序列 - $x = 01001$, $w = upright(m a d a m)$

字符串的 #strong[连接] 
- $x w = 01001 upright(m a d a m)$ 
- $x x = x^2 = 0100101001$

串的 #strong[长度] -
$lr(|x|) = lr(|w|) = 5 arrow.r.double.long lr(|x w|) = 10$

#strong[空串] $lr(|epsilon|) = 0$, $x^0 = epsilon$.

=== 子串和子序列
#strong[子串] 要求是连续的片段 - $upright(a d a)$ 是
$upright(m a d a m)$ 的子串

#strong[子序列] 则不要求连续 - $upright(m d m)$ 是 $upright(m a d a m)$
的子序列

=== 语言 
<lang-concat>
#strong[语言] 是由字符串组成的集合

几种特殊的语言:
$ Sigma^(*) & = {x divides x in Sigma upright(" and ") lr(|x|) upright(" is finite")}\
Sigma^(+) & = {x divides x in Sigma upright(" and ") lr(|x|) upright(" is finite") upright(" and ") lr(|x|) > 0}\
Sigma' & = {x divides x in Sigma upright(" and ") lr(|x|) upright(" is infinite")} $
因此, 任何由有限长度字符串组成的语言 $A$ 都是 $Sigma^(*)$ 的一个子集
$ A subset Sigma^(*) $ #strong[空语言] 是一个不包含任何字符串的语言,
用符号 $nothing$ 表示 #strong[空串语言] 是一个包含唯一一个字符串的语言,
而这个唯一的字符串是#strong[空串];, 符号为 ${epsilon}$.

#strong[语言的连接];:
$ A B = {x y divides x in A upright(" and ") y in B} $ 
有两个特殊情况是
- ${epsilon} A = A {epsilon} = A$ 
- $nothing A = A nothing = A$

=== 标准序
排序方法 
- #strong[先短后长];: 如果两个字符串的长度不同, 那么短的字符串排在前面 
- #strong[等长逐位比较];: 如果两个字符串的长度相同, 那么就从第一个字符开始, 逐个字符地比较它们的顺序

$ Sigma_2^(*) = { epsilon \, a \, b \, c \, dots.h \, x \, y \, z \, a a \, a b \, a c \, dots.h a x \, a y \, a z \, b a \, dots.h \, \ b z \, dots.h \, z a \, dots.h \, z z \, a a a \, dots.h \, z z z \, a a a a \, dots.h } $

== 可满足性问题
是否存在一种对变量的赋值方式 (比如把某个变量设为真或假),
能让整个公式的结果为真. 如果存在, 那么这个公式就是#strong[可满足的];.

SAT 定义为所有可满足的布尔公式的集合:
$ upright(S A T) = {phi.alt divides phi.alt upright(" is a satisfiable Boolean expression ")} $
#strong[CNF] 公式 也就是 #strong[合取范式];.
一个布尔公式如果是由若干个子句通过与 ($and$) 连接起来的, 那么它就是一个
CNF 公式. 特别地, 如果一个 CNF 公式中的所有字句都有三个文字,
那么这个公式就被称为 #strong[3-CNF 公式];. 例如:
$ \( x_1 or macron(x)_2 or macron(x)_3 \) and \( x_3 or macron(x)_5 or x_6 \) and \( x_3 or macron(x)_6 or x_4 \) $

#strong[3SAT] 问题:
$ upright(3 S A T) = {phi.alt divides phi.alt upright(" is a satisfiable 3-CNF ")} $

= 定理和证明
== 零知识证明
零知识证明是一种协议, 它允许一个人向另一个人证明某个陈述是真实的,
而无需透露任何关于这个陈述的额外信息. 可以把它想象成一个谜题,
#strong[证明者];知道谜底, 他要让#strong[验证者];相信他确实知道谜底,
但同时又不能把谜底告诉对方.

= 确定性有穷自动机
== 有穷自动机的定义
一个确定性有穷自动机 (Deterministic Finite Automaton, DFA) 是一个五元组
$\( Q \, Sigma \, delta \, q_0 \, F \)$, 其中 
1. $Q$ 是一个有限 #strong[状态] 集合. 
2. $Sigma$ 是一个有限 #strong[输入符号] 集合, 称为 #strong[字母表];. 
3. $delta : Q times Sigma arrow.r Q$ 是一个 #strong[状态转移函数];, 它定义了在给定当前状态和输入符号的情况下, 自动机将转移到哪个状态. 
4. $q_0 in Q$ 是 #strong[初始状态];. 
5. $F subset.eq Q$ 是一个 #strong[接受状态] 集合.

== 有穷自动机识别的语言
一个 DFA 可以识别某些语言. 给定一个输入字符串, 自动机从初始状态 $q_0$
开始, 根据输入字符串的每个符号和状态转移函数 $delta$ 依次转移状态.
如果在处理完输入字符串后, 自动机停在一个接受状态 $F$ 中的某个状态,
那么该字符串被认为是被该自动机接受的.

$ L \( M \) = {w in Sigma^(*) divides upright("the DFA ") M upright(" accepts ") w} = {w in Sigma^(*) divides hat(delta) \( q_0 \, w \) in F} $

这里面, $hat(delta)$ 是 $delta$ 的扩展,
它定义了在给定初始状态和输入字符串的情况下, 自动机将转移到哪个状态.

== 有穷自动机的模拟运行
如果使用 Python 来模拟一个 DFA 的运行, 可以按照以下步骤进行:

```python
class DFA:
    def __init__(self, s, a, t, q0, f):
        self.states = s  # 状态集合
        self.alphabet = a  # 输入符号集合
        self.transition = t  # 状态转移函数
        self.start_state = q0  # 初始状态
        self.accept_states = f  # 接受状态集合

    def run(self, input_string):
        current_state = self.start_state
        for symbol in input_string:
            if symbol in self.alphabet:
                current_state = self.transition.get((current_state, symbol), None)
                if current_state is None:
                    break
            else:
                break
        return current_state in self.accept_states
```

= 正则语言
== 计算的形式化定义
对于一个有穷自动机 $M = \( Q \, Sigma \, delta \, q_0 \, F \)$ 和输入串
$w = w_1 w_2 dots.h w_n$, $w_i in Sigma$, 如果存在一个状态序列
$r_0 \, r_1 \, dots.h \, r_n$, 使得 
1. $r_0 = q_0$ (初始状态) 
2. $r_(i + 1) = delta \( r_i \, w_(i + 1) \)$ 对于 $0 lt.eq i < n$ (状态转移) 
3. $r_n in F$ (接受状态)

则称 $M$ 接受输入串 $w$ (接受计算). $M$ 接受的所有字符串的集合称为 $M$
识别的语言, 记为 $L \( M \)$.

== 正则语言的定义
如果一个语言 $L$ 中的所有字符串都可以被某个有穷自动机 $M$ 接受, 则称 $L$
是一个 #strong[正则语言 (Regular Language)];. 即存在一个有穷自动机 $M$
使得 $L = L \( M \)$.

== 非正则语言的例子
通常来说, 一个非正则语言 (即不能被任何有穷自动机识别的语言) 需要
#strong[存储] 的能力 (requires memory). 例如, 语言
$L = { a^n b^n divides n gt.eq 0 }$ 包含所有形式为 $a$
的若干个后跟同样数量的 $b$ 的字符串. 这个语言不是正则的,
因为有穷自动机无法记住它已经读了多少个 $a$, 以确保它读了相同数量的 $b$.

== 正则运算
<reg-ops>
正则语言在以下运算下是封闭的: 
1. #strong[并 (Union)];: 如果 $L_1$ 和 $L_2$ 是正则语言, 则 $L_1 union L_2$ 也是正则语言. 
2. #strong[连接(Concatenation)];: 如果 $L_1$ 和 $L_2$ 是正则语言, 则 $L_1 compose L_2 = { x y divides x in L_1 \, y in L_2 }$ 也是正则语言. 
3. #strong[克林闭包 (Kleene Star)] : 如果 $L$ 是正则语言, 则 $L^(*) = { x_1 x_2 dots.h x_k divides k gt.eq 0 \, x_i in L }$ 也是正则语言.

注意这里克林闭包是一元运算 (unary operation), 而并和连接是二元运算
(binary operations). 且克林闭包包含了空串 ($k = 0$ 的特殊情况), 即
$epsilon in L^(*)$.

#strong[例子];:

设 $A = { upright("Good") \, upright("Bad") }$, $B = { upright("Boy") \, upright("Girl") }$, 则
- $A union B = { upright("Good") \, upright("Bad") \, upright("Boy") \, upright("Girl") }$
- $A compose B = { upright("GoodBoy") \, upright("GoodGirl") \, upright("BadBoy") \, upright("BadGirl") }$
- $A^(*) = { epsilon \, upright("Good") \, upright("Bad") \, upright("GoodGood") \, upright("GoodBad") \, upright("BadGood") \, upright("BadBad") \, upright("GoodGoodGood") \, dots.h }$

#strong[一些其他运算];: 
1. #strong[补 (Complement)];: 如果 $L$ 是正则语言, 则 $overline(L) = Sigma^(*) \\ L$ 也是正则语言. 
2. #strong[交 (Intersection)];: 如果 $L_1$ 和 $L_2$ 是正则语言, 则 $L_1 inter L_2$ 也是正则语言. 
3. #strong[差 (Difference)];: 如果 $L_1$ 和 $L_2$ 是正则语言, 则 $L_1 - L_2 = L_1 inter overline(L_2)$ 也是正则语言. 
4. #strong[对称差(Symmetric Difference)];: 如果 $L_1$ 和 $L_2$ 是正则语言, 则 $L_1 xor L_2 = \( L_1 - L_2 \) union \( L_2 - L_1 \) = \( L_1 union L_2 \) - \( L_1 inter L_2 \)$ 也是正则语言.

= 非确定性有穷自动机
== 形式化定义
一个非确定性有穷自动机 (Nondeterministic Finite Automaton, NFA)
是一个五元组 $\( Q \, Sigma \, delta \, q_0 \, F \)$, 其中 
1. $Q$ 是一个有限 #strong[状态] 集合. 
2. $Sigma$ 是一个有限 #strong[输入符号] 集合, 称为 #strong[字母表];. 
3. $delta : Q times \( Sigma union { epsilon } \) arrow.r cal(P) \( Q \)$ 是一个 #strong[状态转移函数];, 其中 $cal(P) \( Q \)$ 表示状态集合的幂集. 它定义了在给定当前状态和输入符号的情况下, 自动机可以转移到哪些状态. 注意这里允许 $epsilon$ 转移, 即自动机可以在不读取任何输入符号的情况下转移状态. 
4. $q_0 in Q$ 是 #strong[初始状态];. 
5. $F subset.eq Q$ 是一个 #strong[接受状态] 集合.

== NFA 的状态转移
<nfa-的状态转移>
NFA 的状态转移函数 $delta$ 定义了在给定当前状态和输入符号的情况下,
自动机可以转移到哪些状态. 具体来说, 对于每个状态 $q in Q$ 和输入符号
$a in Sigma union { epsilon }$, $delta \( q \, a \)$ 是一个状态集合,
表示自动机可以从状态 $q$ 通过读取输入符号 $a$ 转移到的所有可能状态.
这意味着在某个状态下, 自动机可能有多个选择,
包括不读取任何输入符号而直接转移到另一个状态 (通过 $epsilon$ 转移).

== NFA 的计算过程
给定一个 NFA $M = \( Q \, Sigma \, delta \, q_0 \, F \)$ 和输入串
$w = w_1 w_2 dots.h w_n$, $w_i in Sigma$, NFA 的计算过程可以描述如下: 
1. #strong[初始状态];: 计算从初始状态 $q_0$ 开始, 包括所有通过 $epsilon$ 转移可以到达的状态集合. 记为 $E \( q_0 \)$. 
2. #strong[状态转移];: 对于输入串的每个符号 $w_i$ (从 $i = 1$ 到 $n$), 计算当前状态集合 $S_(i - 1)$ (初始时为 $E \( q_0 \)$) 通过读取符号 $w_i$ 后可以到达的所有状态集合, 记为 $S_i$:
$ S_i = union.big_(q in S_(i - 1)) delta \( q \, w_i \) $ 
然后, 计算 $S_i$ 中所有状态通过 $epsilon$ 转移可以到达的状态集合, 记为
$E \( S_i \)$. 

3. #strong[接受状态];: 在处理完输入串 $w$ 后, 如果最终状态集合 $S_n$ (包括通过 $epsilon$ 转移可以到达的状态) 中包含至少一个接受状态 $F$ 中的状态, 则称 NFA #strong[接受];输入串 $w$.

== NFA 的 "猜想" 行为
NFA 的计算过程可以看作是对所有可能的状态路径进行 "猜测". 在每个状态, NFA 可以选择多个可能的转移, 包括通过 $epsilon$ 转移跳过某些输入符号. 这种非确定性使得 NFA 能够在某种程度上 "并行" 处理多个计算路径, 从而提高了对复杂语言的识别能力.

比如说, 如果我们要设计一个 NFA 来识别语言 
$ L = { x divides x "the third-to-last character of" x "is 1" } $ 
且 $Sigma = { 0 \, 1 }$, 我们可以设计如下的 NFA: 
- 状态集合: $Q = { q_0 \, q_1 \, q_2 \, q_3 }$ 
- 输入符号集合: $Sigma = { 0 \, 1 }$
- 初始状态: $q_0$ 
- 接受状态: $F = { q_3 }$ 
- 状态转移函数 $delta$:

#figure(
  align(center)[#table(
    columns: 3,
    align: (auto,auto,auto,),
    table.header([当前状态], [输入符号], [下一个状态],),
    table.hline(),
    [$q_0$], [0], [$q_0$],
    [$q_0$], [1], [$q_0 \, q_1$],
    [$q_1$], [0], [$q_2$],
    [$q_1$], [1], [$q_2$],
    [$q_2$], [0], [$q_3$],
    [$q_2$], [1], [$q_3$],
  )]
  , kind: table
  )

可以看到, 在状态 $q_0$ 读取到输入符号 `1` 时, NFA 可以选择留在 $q_0$ (继续读取更多的符号), 也可以转移到 $q_1$ (表示已经找到了一个可能的倒数第三个字符). 这种 "猜想" 行为使得 NFA 能够有效地识别符合条件的字符串.

如果我们使用 DFA 来识别同样的语言, 我们则必须要为最后三位可能的所有组合 $\( 000 \, 001 \, 010 \, 011 \, 100 \, 101 \, 110 \, 111 \)$ 设计状态, 这会导致状态数量的指数级增长.

== $epsilon$-NFA 的转换
一个 $epsilon$-NFA 是一种特殊的 NFA,
它允许在不读取任何输入符号的情况下进行状态转移 (即通过 $epsilon$ 转移).
这种能力使得 $epsilon$-NFA 在某些情况下更容易设计和理解.

我们可以通过以下步骤将一个 $epsilon$-NFA 转换为一个等价的 NFA: 
1. #strong[计算 $epsilon$-闭包];: 对于每个状态 $q in Q$, 计算其 $epsilon$-闭包 $E \( q \)$, 即从状态 $q$ 出发, 通过任意数量的 $epsilon$ 转移可以到达的所有状态集合 (包含 $q$ 自己). 
2. #strong[定义新的状态转移函数];: 对于每个状态 $q in Q$ 和输入符号 $a in Sigma$, 定义新的状态转移函数 $delta'$: $ delta' \( q \, a \) = union.big_(p in E \( q \)) delta \( p \, a \) $ 这表示从状态 $q$ 出发, 通过 $epsilon$ 转移到达的所有状态 $p$,
然后读取输入符号 $a$ 后可以到达的所有状态集合. 
3. #strong[定义新的接受状态];: 定义新的接受状态集合 $F'$: $ F' = { q in Q divides E \( q \) inter F eq.not nothing } $ 这表示如果从状态 $q$ 出发, 通过 $epsilon$ 转移可以到达至少一个接受状态, 则 $q$ 也是一个接受状态. 
4. #strong[构造新的 NFA];: 最终, 我们得到一个新的 NFA $M' = \( Q \, Sigma \, delta' \, q_0 \, F' \)$, 它与原始的 $epsilon$-NFA 等价, 即它们识别相同的语言.

== NFA 和 DFA 的等价性
如果两个自动机 $M_1$ 和 $M_2$ 识别相同的语言, 即 $L \( M_1 \) = L \( M_2 \)$, 则称它们是 #strong[等价] 的.

DFA 显然是 NFA 的一个特例, 所以要证明 NFA 和 DFA 的等价性, 只需要证明对于任意一个 NFA, 都存在一个等价的 DFA.

我们可以通过以下步骤将一个 NFA 转换为一个等价的 DFA: 
1. #strong[状态集合];: 新的 DFA 的状态集合 $Q'$ 是原始 NFA 的状态集合 $Q$ 的幂集, 即 $Q' = cal(P) \( Q \)$. 这意味着每个新的状态都是原始 NFA 的状态的一个子集. 
2. #strong[初始状态];: 新的 DFA 的初始状态 $q_(0')$ 是原始 NFA 的初始状态 $q_0$ 的 $epsilon$-闭包, 即 $q_(0') = E \( q_0 \)$. 
3. #strong[接受状态];: 新的 DFA 的接受状态集合 $F'$ 包含所有包含至少一个原始 NFA 接受状态的子集, 即 $F' = { S subset.eq Q | S inter F eq.not nothing }$. 
4. #strong[状态转移函数];: 新的 DFA 的状态转移函数 $delta'$ 定义如下: $ delta' \( S \, a \) = union.big_(q in S) delta \( q \, a \) $ 这表示从状态集合 $S$ 出发, 读取输入符号 $a$ 后可以到达的所有状态集合.

通过上述步骤, 我们可以构造出一个新的 DFA $M' = \( Q' \, Sigma \, delta' \, q_(0') \, F' \)$, 它与原始的 NFA 等价, 即它们识别相同的语言.

#strong[推论];: 一个语言是正则的, 当且仅当它可以被某个 NFA 识别. 即
$ L upright(" is regular ") arrow.l.r.double exists upright(" NFA ") M upright(" s.t. ") L = L \( M \) $

#strong[子集构造法 (Subset Construction)];: 上述将 NFA 转换为 DFA 的方法称为子集构造法, 因为新的 DFA 的状态是原始 NFA 状态的子集.

= 正则表达式
== 引子
我们在算术中可以用运算符 (如 $+ \, - \, times \, div$) 来构造表达式, 类似地, 可以用正则运算符来构造描述语言的表达式, 称为正则表达式. 也就是说, 正则表达式的值是一个语言.

正则表达式能定义所有的正则语言, 反之亦然. 因此, 正则表达式和有穷自动机 (DFA/NFA) 是等价的.

== 正则表达式的形式化定义
=== 归纳定义法
一个正则表达式 (Regular Expression, RE) 是通过以下规则递归定义的:
1. *基本表达式*:
- *(empty set)* $emptyset$ 是一个正则表达式, 它表示空语言.
- *(empty string)* $epsilon$ 是一个正则表达式, 它表示只包含空串的语言.
- *(literal character)* 对于每个符号 $a in Sigma$, $a$ 是一个正则表达式, 它表示只包含字符串 $a$ 的语言.

2. *复合表达式*:
- *(concatenation)* 如果 $R_1$ 和 $R_2$ 是正则表达式, 则 $R_1 R_2$ 是一个正则表达式, 它表示语言的连接 $L \( R_1 \) L \( R_2 \)$ (见 @lang-concat). 
- *(alternation)* 如果 $R_1$ 和 $R_2$ 是正则表达式, 则 $R_1 + R_2$ 是一个正则表达式, 它表示语言的并 $L \( R_1 \) union L \( R_2 \)$ (见 @reg-ops).
- *(Kleene star)* 如果 $R$ 是一个正则表达式, 则 $R^(*)$ 是一个正则表达式, 它表示语言的克林闭包 $L \( R \)^(*)$ (见 @reg-ops).

正则表达式 $R$ 所表示的语言记为 $L(R)$.

=== 一些正则表达式的例子
假设字母表 $Sigma = { 0 \, 1 }$, 则以下是一些正则表达式及其对应的语言:

1. $0^*10^* = {w | w "has exactly one 1"}$. 这是因为 $0^*$ 表示任意数量的 $0$ (包括零个), 因此 $0^*10^*$ 表示一个 $1$ 前后可以有任意数量的 $0$.

2. $Sigma^* 1 Sigma^* = {w | w "contains at least one 1"}$.

3. $Sigma^*001Sigma^* = {w | w "contains 001 as a substring"}$.

4. $1^*(01^+)^* = {w | "every 0 in" w "is followed by at least one 1"}$. 注意这里为了方便起见, 我们用 $R^+$ 表示 $R R^(*)$.

5. $(Sigma Sigma)^* = {w | "the length of" w "is even"}$.

6. $01 + 10 = {01, 10}$

7. $0 Sigma^* 0 + 1 Sigma^* 1 + 0 + 1 = {w | w "starts and ends with the same symbol"}$

8. $(0 + epsilon) (1 + epsilon) = {epsilon, 0, 1, 01}$

9. $1^* nothing = nothing$. 注意空集连接任何语言仍然是空集.

10. $emptyset^* = {epsilon}$. 星号运算把该语言中的任意个字符串连接在一起, 得到运算结果中的一个字符串. 如果该语言是空集, 星号运算能把 $0$ 个字符串连接在一起, 结果就是空串.


== 运算的优先级
正则表达式中的运算符有不同的优先级, 其优先级从高到低依次为: 
1. 克林闭 包 ($""^(*)$)
2. 连接
3. 并 ($+$)

== 有穷自动机和正则表达式
就描述语言的能力而言, 有穷自动机 (DFA/NFA) 和正则表达式是等价的. 具体来说, 任何的正则表达式都能够转换成能识别它所描述语言的有穷自动机, 反之亦然.

=== 如果一个语言可以用正则表达式描述, 那么它是正则的.
考虑如下的证明思路:
1. 由于 NFA 和 DFA 是等价的, 因此只需要证明对于任意一个正则表达式 $R$, 都存在一个等价的 NFA $M$ 使得 $L(R) = L(M)$.

2. 对于每个基本正则表达式, 我们可以直接构造一个等价的 NFA:
  - 对于 $emptyset$, 构造一个 NFA $M = \( {q_0} \, Sigma \, delta \, q_0 \, emptyset \)$, 其中 $delta$ 是一个空函数. 该 NFA 没有接受状态, 因此它识别的语言是空集.
  - 对于 $epsilon$, 构造一个 NFA $M = \( {q_0} \, Sigma \, delta \, q_0 \, {q_0} \)$, 其中 $delta$ 是一个空函数. 该 NFA 的初始状态也是接受状态, 因此它识别的语言只包含空串.
  - 对于每个符号 $a in Sigma$, 构造一个 NFA $M = \( {q_0, q_1} \, Sigma \, delta \, q_0 \, {q_1} \)$, 其中 $delta \( q_0 \, a \) = {q_1}$ 且 $delta$ 在其他情况下是空函数. 该 NFA 识别的语言只包含字符串 $a$.

3. 对于复合正则表达式, 我们可以通过归纳假设来构造等价的 NFA:
  - 对于 $R_1 R_2$, 假设存在等价的 NFA $M_1$ 和 $M_2$ 分别识别 $R_1$ 和 $R_2$. 我们可以构造一个新的 NFA $M$, 通过将 $M_1$ 的所有接受状态与 $M_2$ 的初始状态通过 $epsilon$ 转移连接起来. 这样, $M$ 识别的语言就是 $L(R_1) L(R_2)$.
  - 对于 $R_1 + R_2$, 假设存在等价的 NFA $M_1$ 和 $M_2$ 分别识别 $R_1$ 和 $R_2$. 我们可以构造一个新的 NFA $M$, 通过添加一个新的初始状态 $q_0'$ 和两个 $epsilon$ 转移, 分别从 $q_0'$ 指向 $M_1$ 和 $M_2$ 的初始状态. 这样, $M$ 识别的语言就是 $L(R_1) union L(R_2)$.
  - 对于 $R^(*)$, 假设存在一个等价的 NFA $M$ 识别 $R$. 我们可以构造一个新的 NFA $M'$, 通过添加一个新的初始状态 $q_0'$ 和一个新的接受状态 $q_f'$. 然后, 添加两个 $epsilon$ 转移, 一个从 $q_0'$ 指向 $M$ 的初始状态, 另一个从 $M$ 的所有接受状态指向 $q_0'$. 另外, 添加一个 $epsilon$ 转移从 $q_0'$ 指向 $q_f'$, 以允许接受空串. 这样, $M'$ 识别的语言就是 $L(R)^(*)$.

4. 通过上述步骤, 我们可以递归地构造出一个等价的 NFA $M$ 对应于任意的正则表达式 $R$, 从而证明了如果一个语言可以用正则表达式描述, 那么它是正则的.

=== 如果一个语言是正则的, 则可以用正则表达式描述它
考虑如下的证明思路:
1. 由于 NFA 和 DFA 是等价的, 因此只需要证明对于任意一个 DFA $M$, 都存在一个等价的正则表达式 $R$ 使得 $L(R) = L(M)$.
2. 该过程需要引入一种称为 *广义非确定型有穷自动机* (Generalized Nondeterministic Finite Automaton, GNFA) 的中间模型. GNFA 与 NFA 类似, 但它的状态转移函数允许使用正则表达式作为标签, 而不仅仅是单个符号或 $epsilon$. 如下图所示:
#align(center)[
  #automaton(
    (
      q1: (q2: "ab*", q3: "b"),
      q2: (q4: "a*", q3: "ab + ba"),
      q4: (q2: "(aa)*", q3: "b*", q4: "ab"),  
    ),
    initial: "q1",
    final: ("q2",),
    style: (
      state: (radius: 0.8)
    ),
    layout: finite.layout.custom.with(positions: (
      q1: (0, 0),
      q2: (5, 0),
      q3: (5, -5),
      q4: (0, -5),
    ))
  )
]
3. GNFA 还满足以下条件:
  - GNFA 只有一个初始状态, 它有到所有其他状态的转移, 但没有任何进入它的转移.
  - GNFA 只有一个接受状态, 它有从所有其他状态的转移, 但没有任何离开它的转移.
  - 除了初始状态和接受状态之外, 每对状态之间恰好有一条单向转移 (可能标签为 $emptyset$).
4. 考虑 DFA $->$ GNFA 的构造过程: 给定一个 DFA $M = \( Q \, Sigma \, delta \, q_0 \, F \)$, 我们可以构造一个等价的 GNFA $M' = \( Q' \, Sigma \, delta' \, q_0' \, q_f' \)$, 其中:
  - 状态集合: $Q' = Q union { q_0', q_f' }$, 其中 $q_0'$ 是新的初始状态, $q_f'$ 是新的接受状态.
  - 输入符号集合: $Sigma$ 与原始 DFA 相同.
  - 状态转移函数 $delta'$ 定义如下:
    - 对于每个状态 $q in Q$, 添加一个从 $q_0'$ 到 $q$ 的转移, 标签为 $epsilon$.
    - 对于每个接受状态 $f in F$, 添加一个从 $f$ 到 $q_f'$ 的转移, 标签为 $epsilon$.
    - 对于每对状态 $(p, q) in Q times Q$, 如果存在一个输入符号 $a in Sigma$ 使得 $delta \( p \, a \) = q$, 则添加一个从 $p$ 到 $q$ 的转移, 标签为 $a$; 如果有多个这样的输入符号, 则标签为它们的并 (用 $+$ 连接); 如果没有这样的输入符号, 则标签为 $emptyset$.
5. 考虑 GNFA $->$ 正则表达式 的转换过程: 给定一个 GNFA $M' = \( Q' \, Sigma \, delta' \, q_0' \, q_f' \)$, 我们可以通过逐步消除状态来构造一个等价的正则表达式 $R$:
  - 选择一个非初始状态且非接受状态 $r in Q' \\ { q_0', q_f' }$.
  - 对于每对状态 $(p, q) in Q' times Q'$ (包括 $p = r$ 或 $q = r$), 更新状态转移函数 $delta'$ 以反映消除状态 $r$ 的影响:
    - 如果存在从 $p$ 到 $r$ 的转移, 标签为 $R_1$, 从 $r$ 到 $r$ 的转移, 标签为 $R_2$, 以及从 $r$ 到 $q$ 的转移, 标签为 $R_3$, 则添加一个从 $p$ 到 $q$ 的新转移, 标签为 $R_1 R_2^(*) R_3$.
    - 如果存在从 $p$ 到 $r$ 的转移, 标签为 $R_1$, 以及从 $r$ 到 $q$ 的转移, 标签为 $R_3$, 则添加一个从 $p$ 到 $q$ 的新转移, 标签为 $R_1 R_3$.
    - 如果存在从 $p$ 到 $q$ 的转移, 标签为 $R_4$, 则更新该转移的标签为 $R_4 + R_1 R_2^(*) R_3$ (如果同时存在上述情况).
  - 删除状态 $r$ 及其所有相关的转移.
  - 重复上述步骤直到只剩下初始状态和接受状态.
6. 最终, 当只剩下初始状态 $q_0'$ 和接受状态 $q_f'$ 时, 状态转移函数 $delta'$ 中从 $q_0'$ 到 $q_f'$ 的转移标签就是所求的正则表达式 $R$.

== 正则表达式代数定律
=== 正则表达式的等价性
如果两个正则表达式定义了相同的语言, 则称这两个正则表达式是等价的.

例如, 下面两个表达式都表示交替的 0 和 1 的串的集合
- $(epsilon + 1) (01)^* (epsilon + 0)$
- $(01)^* + (10)^* + 1(01)^* + 0(10)^*$

=== 单位元和零元
1. 单位元: $R + emptyset = R$, $R epsilon = epsilon R = R$
2. 零元: $R emptyset = emptyset R = emptyset$, $R + Sigma^(*) = Sigma^(*)$

=== 正则表达式的代数定律
1. 交换律: $R_1 + R_2 = R_2 + R_1$
2. 结合律: $(R_1 + R_2) + R_3 = R_1 + (R_2 + R_3)$, $(R_1 R_2) R_3 = R_1 (R_2 R_3)$
3. 分配律: $R_1 (R_2 + R_3) = R_1 R_2 + R_1 R_3$, $(R_1 + R_2) R_3 = R_1 R_3 + R_2 R_3$

=== 幂等律
1. $R + R = R$
2. $R inter R = R$

=== 克林闭包的性质
1. $epsilon in L(R^(*) )$
2. $(R^*)^* = R^*$
3. $emptyset^* = epsilon$, $epsilon^* = epsilon$
4. $R^+ = R R^* = R^* R$
5. $R^* = R^+ + epsilon$