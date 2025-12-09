#import "@preview/showybox:2.0.4": showybox
#import "@preview/ilm:1.4.1": *
#import "@preview/finite:0.5.0": automaton
#import "@preview/finite:0.5.0"
#import "@preview/tdtr:0.3.0" : *
#import "@preview/algorithmic:1.0.6"
#import algorithmic: style-algorithm, algorithm-figure

#show: style-algorithm

#set text(font:("Libertinus Serif", "Source Han Serif SC"))

#show heading.where(level: 1): set text(navy.lighten(0%))
#show heading.where(level: 2): set text(navy.lighten(20%))
#show heading.where(level: 3): set text(navy.lighten(40%))

#show ref: it => {
  text(purple, it)
}

#show: ilm.with(
  title: [Theoretical Computer Science],
  date: datetime.today(),
  author: "Tianlin Pan",
  table-of-contents: outline(depth: 2),
)

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

#let frameSettingsEastern = (
  border-color: eastern,
  title-color: eastern.lighten(30%),
  body-color: eastern.lighten(95%),
  footer-color: eastern.lighten(80%)
)
#set quote(block: true)

#page(
)[
  #align(horizon)[
    "正则语言" 的大陆:
    1. 文法 (Grammar) 建造了大陆上的景观
    2. 机器 (The Acceptor): DFA $<==>$ NFA;  代数 (The Descriptor): 正则表达式. 它们是大陆上的交通工具
    3. 泵引理 (Pumping Lemma): 大陆上的自然法则, 确定了大陆的边界
  ]
]

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
$ ( x_1 or macron(x)_2 or macron(x)_3 ) and ( x_3 or macron(x)_5 or x_6 ) and ( x_3 or macron(x)_6 or x_4 ) $

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
$( Q \, Sigma \, delta \, q_0 \, F )$, 其中 
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

$ L ( M ) = {w in Sigma^(*) divides upright("the DFA ") M upright(" accepts ") w} = {w in Sigma^(*) divides hat(delta) ( q_0 \, w ) in F} $

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
对于一个有穷自动机 $M = ( Q \, Sigma \, delta \, q_0 \, F )$ 和输入串
$w = w_1 w_2 dots.h w_n$, $w_i in Sigma$, 如果存在一个状态序列
$r_0 \, r_1 \, dots.h \, r_n$, 使得 
1. $r_0 = q_0$ (初始状态) 
2. $r_(i + 1) = delta ( r_i \, w_(i + 1) )$ 对于 $0 lt.eq i < n$ (状态转移) 
3. $r_n in F$ (接受状态)

则称 $M$ 接受输入串 $w$ (接受计算). $M$ 接受的所有字符串的集合称为 $M$
识别的语言, 记为 $L ( M )$.

== 正则语言的定义
如果一个语言 $L$ 中的所有字符串都可以被某个有穷自动机 $M$ 接受, 则称 $L$
是一个 #strong[正则语言 (Regular Language)];. 即存在一个有穷自动机 $M$
使得 $L = L ( M )$.

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
4. #strong[对称差(Symmetric Difference)];: 如果 $L_1$ 和 $L_2$ 是正则语言, 则 $L_1 xor L_2 = ( L_1 - L_2 ) union ( L_2 - L_1 ) = ( L_1 union L_2 ) - ( L_1 inter L_2 )$ 也是正则语言.

= 非确定性有穷自动机
== 形式化定义
一个非确定性有穷自动机 (Nondeterministic Finite Automaton, NFA)
是一个五元组 $( Q \, Sigma \, delta \, q_0 \, F )$, 其中 
1. $Q$ 是一个有限 #strong[状态] 集合. 
2. $Sigma$ 是一个有限 #strong[输入符号] 集合, 称为 #strong[字母表];. 
3. $delta : Q times ( Sigma union { epsilon } ) arrow.r cal(P) ( Q )$ 是一个 #strong[状态转移函数];, 其中 $cal(P) ( Q )$ 表示状态集合的幂集. 它定义了在给定当前状态和输入符号的情况下, 自动机可以转移到哪些状态. 注意这里允许 $epsilon$ 转移, 即自动机可以在不读取任何输入符号的情况下转移状态. 
4. $q_0 in Q$ 是 #strong[初始状态];. 
5. $F subset.eq Q$ 是一个 #strong[接受状态] 集合.

== NFA 的状态转移
<nfa-的状态转移>
NFA 的状态转移函数 $delta$ 定义了在给定当前状态和输入符号的情况下,
自动机可以转移到哪些状态. 具体来说, 对于每个状态 $q in Q$ 和输入符号
$a in Sigma union { epsilon }$, $delta ( q \, a )$ 是一个状态集合,
表示自动机可以从状态 $q$ 通过读取输入符号 $a$ 转移到的所有可能状态.
这意味着在某个状态下, 自动机可能有多个选择,
包括不读取任何输入符号而直接转移到另一个状态 (通过 $epsilon$ 转移).

== NFA 的计算过程
给定一个 NFA $M = ( Q \, Sigma \, delta \, q_0 \, F )$ 和输入串
$w = w_1 w_2 dots.h w_n$, $w_i in Sigma$, NFA 的计算过程可以描述如下: 
1. #strong[初始状态];: 计算从初始状态 $q_0$ 开始, 包括所有通过 $epsilon$ 转移可以到达的状态集合. 记为 $E ( q_0 )$. 
2. #strong[状态转移];: 对于输入串的每个符号 $w_i$ (从 $i = 1$ 到 $n$), 计算当前状态集合 $S_(i - 1)$ (初始时为 $E ( q_0 )$) 通过读取符号 $w_i$ 后可以到达的所有状态集合, 记为 $S_i$:
$ S_i = union.big_(q in S_(i - 1)) delta ( q \, w_i ) $ 
然后, 计算 $S_i$ 中所有状态通过 $epsilon$ 转移可以到达的状态集合, 记为
$E ( S_i )$. 

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

如果我们使用 DFA 来识别同样的语言, 我们则必须要为最后三位可能的所有组合 $( 000 \, 001 \, 010 \, 011 \, 100 \, 101 \, 110 \, 111 )$ 设计状态, 这会导致状态数量的指数级增长.

== $epsilon$-NFA 的转换
一个 $epsilon$-NFA 是一种特殊的 NFA,
它允许在不读取任何输入符号的情况下进行状态转移 (即通过 $epsilon$ 转移).
这种能力使得 $epsilon$-NFA 在某些情况下更容易设计和理解.

我们可以通过以下步骤将一个 $epsilon$-NFA 转换为一个等价的 NFA: 
1. #strong[计算 $epsilon$-闭包];: 对于每个状态 $q in Q$, 计算其 $epsilon$-闭包 $E ( q )$, 即从状态 $q$ 出发, 通过任意数量的 $epsilon$ 转移可以到达的所有状态集合 (包含 $q$ 自己). 
2. #strong[定义新的状态转移函数];: 对于每个状态 $q in Q$ 和输入符号 $a in Sigma$, 定义新的状态转移函数 $delta'$: $ delta' ( q \, a ) = union.big_(p in E ( q )) delta ( p \, a ) $ 这表示从状态 $q$ 出发, 通过 $epsilon$ 转移到达的所有状态 $p$,
然后读取输入符号 $a$ 后可以到达的所有状态集合. 
3. #strong[定义新的接受状态];: 定义新的接受状态集合 $F'$: $ F' = { q in Q divides E ( q ) inter F eq.not nothing } $ 这表示如果从状态 $q$ 出发, 通过 $epsilon$ 转移可以到达至少一个接受状态, 则 $q$ 也是一个接受状态. 
4. #strong[构造新的 NFA];: 最终, 我们得到一个新的 NFA $M' = ( Q \, Sigma \, delta' \, q_0 \, F' )$, 它与原始的 $epsilon$-NFA 等价, 即它们识别相同的语言.

== NFA 和 DFA 的等价性
如果两个自动机 $M_1$ 和 $M_2$ 识别相同的语言, 即 $L ( M_1 ) = L ( M_2 )$, 则称它们是 #strong[等价] 的.

DFA 显然是 NFA 的一个特例, 所以要证明 NFA 和 DFA 的等价性, 只需要证明对于任意一个 NFA, 都存在一个等价的 DFA.

我们可以通过以下步骤将一个 NFA 转换为一个等价的 DFA: 
1. #strong[状态集合];: 新的 DFA 的状态集合 $Q'$ 是原始 NFA 的状态集合 $Q$ 的幂集, 即 $Q' = cal(P) ( Q )$. 这意味着每个新的状态都是原始 NFA 的状态的一个子集. 
2. #strong[初始状态];: 新的 DFA 的初始状态 $q_(0')$ 是原始 NFA 的初始状态 $q_0$ 的 $epsilon$-闭包, 即 $q_(0') = E ( q_0 )$. 
3. #strong[接受状态];: 新的 DFA 的接受状态集合 $F'$ 包含所有包含至少一个原始 NFA 接受状态的子集, 即 $F' = { S subset.eq Q | S inter F eq.not nothing }$. 
4. #strong[状态转移函数];: 新的 DFA 的状态转移函数 $delta'$ 定义如下: $ delta' ( S \, a ) = union.big_(q in S) delta ( q \, a ) $ 这表示从状态集合 $S$ 出发, 读取输入符号 $a$ 后可以到达的所有状态集合.

通过上述步骤, 我们可以构造出一个新的 DFA $M' = ( Q' \, Sigma \, delta' \, q_(0') \, F' )$, 它与原始的 NFA 等价, 即它们识别相同的语言.

#strong[推论];: 一个语言是正则的, 当且仅当它可以被某个 NFA 识别. 即
$ L upright(" is regular ") arrow.l.r.double exists upright(" NFA ") M upright(" s.t. ") L = L ( M ) $

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
- *(concatenation)* 如果 $R_1$ 和 $R_2$ 是正则表达式, 则 $R_1 R_2$ 是一个正则表达式, 它表示语言的连接 $L ( R_1 ) L ( R_2 )$ (见 @lang-concat). 
- *(alternation)* 如果 $R_1$ 和 $R_2$ 是正则表达式, 则 $R_1 + R_2$ 是一个正则表达式, 它表示语言的并 $L ( R_1 ) union L ( R_2 )$ (见 @reg-ops).
- *(Kleene star)* 如果 $R$ 是一个正则表达式, 则 $R^(*)$ 是一个正则表达式, 它表示语言的克林闭包 $L ( R )^(*)$ (见 @reg-ops).

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
  - 对于 $emptyset$, 构造一个 NFA $M = ( {q_0} \, Sigma \, delta \, q_0 \, emptyset )$, 其中 $delta$ 是一个空函数. 该 NFA 没有接受状态, 因此它识别的语言是空集.
  - 对于 $epsilon$, 构造一个 NFA $M = ( {q_0} \, Sigma \, delta \, q_0 \, {q_0} )$, 其中 $delta$ 是一个空函数. 该 NFA 的初始状态也是接受状态, 因此它识别的语言只包含空串.
  - 对于每个符号 $a in Sigma$, 构造一个 NFA $M = ( {q_0, q_1} \, Sigma \, delta \, q_0 \, {q_1} )$, 其中 $delta ( q_0 \, a ) = {q_1}$ 且 $delta$ 在其他情况下是空函数. 该 NFA 识别的语言只包含字符串 $a$.

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
4. 考虑 DFA $->$ GNFA 的构造过程: 给定一个 DFA $M = ( Q \, Sigma \, delta \, q_0 \, F )$, 我们可以构造一个等价的 GNFA $M' = ( Q' \, Sigma \, delta' \, q_0' \, q_f' )$, 其中:
  - 状态集合: $Q' = Q union { q_0', q_f' }$, 其中 $q_0'$ 是新的初始状态, $q_f'$ 是新的接受状态.
  - 输入符号集合: $Sigma$ 与原始 DFA 相同.
  - 状态转移函数 $delta'$ 定义如下:
    - 对于每个状态 $q in Q$, 添加一个从 $q_0'$ 到 $q$ 的转移, 标签为 $epsilon$.
    - 对于每个接受状态 $f in F$, 添加一个从 $f$ 到 $q_f'$ 的转移, 标签为 $epsilon$.
    - 对于每对状态 $(p, q) in Q times Q$, 如果存在一个输入符号 $a in Sigma$ 使得 $delta ( p \, a ) = q$, 则添加一个从 $p$ 到 $q$ 的转移, 标签为 $a$; 如果有多个这样的输入符号, 则标签为它们的并 (用 $+$ 连接); 如果没有这样的输入符号, 则标签为 $emptyset$.
5. 考虑 GNFA $->$ 正则表达式 的转换过程: 给定一个 GNFA $M' = ( Q' \, Sigma \, delta' \, q_0' \, q_f' )$, 我们可以通过逐步消除状态来构造一个等价的正则表达式 $R$:
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

== Arden 引理
=== 内容
设 $P$ 和 $Q$ 是正则表达式, 则关于正则表达式 $X$ 的方程 $X = Q + X P$ 的解为 $X = Q P^*$. 如果 $epsilon in.not L(P)$, 则该解是唯一的.

=== 使用 Arden 引理把 NFA 转换为正则表达式
*前提假设*:
1. 有穷自动机的状态转移图中不包含 $epsilon$ 转移.
2. 有穷自动机仅含有一个初始状态

*转换步骤*:
1. 对于有穷自动机的每个状态 $q_i$, 定义一个正则表达式 $R_i$ 表示从初始状态出发到达状态 $q_i$ 的所有字符串的集合.
2. 根据状态转移图, 对每个状态 $q_i$, 写出一个关于 $R_i$ 的方程. 该方程的形式为:
$ R_i = sum_(j) R_j a_(j i) + b_i $
其中, $a_(j i)$ 是从状态 $q_j$ 到状态 $q_i$ 的输入符号 (如果存在多条边, 则用 $+$ 连接), $b_i$ 是从初始状态直接到达状态 $q_i$ 的输入符号 (如果存在多条边, 则用 $+$ 连接; 如果没有, 则为 $emptyset$).
3. 对于每个接受状态 $q_f$, 使用 Arden 引理求解关于 $R_f$ 的方程, 得到 $R_f$ 的正则表达式.
4. 最终, 语言 $L(M)$ 可以表示为所有接受状态的正则表达式的并:
$ L(M) = sum_(q_f in F) R_f $

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
      state: (radius: 0.8)
    ),
    layout: finite.layout.custom.with(positions: (
      q0: (0, 0),
      q1: (5, 0),
      q2: (5, -5),
    ))
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

== 正则表达式的应用
=== `grep` 工具
`grep` 是一个在类 Unix 系统中广泛使用的命令行工具, 用于在文件中搜索符合特定模式的文本行. 

*例子*:
- 搜索包含 "error" 的行: `grep "error" filename.txt`
- 使用正则表达式搜索以 "a" 开头, 后跟任意数量的字符, 然后是 "b" 的行: `grep "^a.*b$" filename.txt`
- 忽略大小写搜索 "warning": `grep -i "warning" filename.txt`

= 泵引理 (Pumping Lemma)
== 引子
DFA 的状态数量是有限的, 因此当输入字符串足够长时, DFA 必须在某些状态之间循环 (即鸽巢原理), 而重复路径对应的子串就可以任意重复或删除而不影响字符串是否被接受. 泵引理正是基于这一观察, 它为正则语言提供了一个 *必要条件*.
== 引理内容
设 $L$ 是一个正则语言, 则存在一个整数 $p >= 1$ (称为泵长度), 使得对于任意字符串 $s in L$ 且 $|s| >= p$, 都可以将 $s$ 分割为三个子串 $s = x y z$, 满足以下条件:
1. $|y| >= 1$ (即子串 $y$ 非空)
2. $|x y| <= p$ (即子串 $x y$ 的长度不超过泵长度 $p$)
3. 对于所有整数 $i >= 0$, 字符串 $x y^i z in L$ (即通过重复子串 $y$ 任意次数, 生成的新字符串仍然属于语言 $L$)

== 证明思路
设 $L$ 是一个正则语言, 则存在一个识别 $L$ 的 DFA $M = ( Q \, Sigma \, delta \, q_0 \, F )$, 其中 $|Q| = n$ (状态数量). 取泵长度 $p = n$. 对于任意字符串 $s in L$ 且 $|s| >= p$, 在处理字符串 $s$ 时, DFA 必须经过至少 $p + 1$ 个状态 (包括初始状态). 根据鸽巢原理, 在这 $p + 1$ 个状态中, 至少有两个状态是相同的. 设这两个相同的状态分别在处理字符串 $s$ 的第 $k$ 个和第 $m$ 个字符后到达, 其中 $0 <= k < m <= |s|$. 将字符串 $s$ 分割为三个子串:
- $x = s[0:k]$ (从第 $0$ 个字符到第 $k - 1$ 个字符)
- $y = s[k:m]$ (从第 $k$ 个字符到第 $m - 1$ 个字符)
- $z = s[m: abs(s)]$ (从第 $m$ 个字符到最后一个字符)
由于在处理子串 $y$ 时, DFA 从状态 $q$ 回到状态 $q$, 因此对于任意整数 $i >= 0$, 处理字符串 $x y^i z$ 时, DFA 仍然会到达接受状态 (因为它与处理字符串 $s$ 时经过的状态路径相同). 因此, $x y^i z in L$. 这证明了泵引理的内容.

== 使用泵引理证明语言非正则
要使用泵引理证明一个语言 $L$ 非正则, 我们可以采用反证法. 假设 $L$ 是正则的, 则根据泵引理, 存在一个泵长度 $p >= 1$. 然后, 我们需要找到一个字符串 $s in L$ 且 $|s| >= p$, 使得对于任意的分割 $s = x y z$ 满足泵引理的条件, 都存在一个整数 $i >= 0$ 使得 $x y^i z not in L$. 这就与泵引理的结论矛盾, 因此 $L$ 非正则.

= 极小化 DFA
== 引子
极小化 DFA 的目标是构造一个状态数量最少的 DFA, 该 DFA 与原始 DFA 识别相同的语言. 
== 等价状态
一个 DFA 的两个状态 $q_i$ 和 $q_j$ 被称为是 *等价* 的, 如果对于任意输入字符串 $w in Sigma^*$, 从状态 $q_i$ 出发处理字符串 $w$ 和从状态 $q_j$ 出发处理字符串 $w$ 最终都到达相同的接受状态类别 (即要么都到达接受状态, 要么都不到达接受状态).

特别地, 当 $abs(w) = 0$ (即 $w = epsilon$) 时, 如果 $q_i$ 和 $q_j$ 是等价的, 则它们要么都属于接受状态集合 $F$, 要么都不属于 $F$. 这时候我们称它们是 $0$-等价的.

以此类推, 如果对于任意输入字符串 $w in Sigma^*$ 且 $abs(w) = k$, 从状态 $q_i$ 出发处理字符串 $w$ 和从状态 $q_j$ 出发处理字符串 $w$ 最终都到达相同的接受状态类别, 则称它们是 *$k$-等价* 的.

*状态的可区分性*:
如果存在一个输入字符串 $w in Sigma^*$, 使得从状态 $q_i$ 出发处理字符串 $w$ 和从状态 $q_j$ 出发处理字符串 $w$ 最终到达不同的接受状态类别, 则称状态 $q_i$ 和 $q_j$ 是 *可区分* 的. *不可区分* 的状态即为等价状态.

== 划分等价类法
基本思想:
1. 将 DFA 的状态集切分成等价状态类
2. 从每个等价状态类中选取一个代表, 构造新的极小化 DFA

例如对于如下 DFA:
#align(center)[
  #automaton(
    (
      A: ("B": "0", "C": "1" ),
      B: ("B": "0", "D": "1" ),
      C: ("B": "0", "C": "1" ),
      D: ("B": "0", "E": "1" ),
      E: ("B": "0", "C": "1" ),
    ),
    initial: "A",
    final: ("E",),
    layout: finite.layout.custom.with(positions: (
      A: (-3, 0),
      B: (1, 2),
      C: (1, -2),
      D: (5, 2),
      E: (5, -2),
    ))
  )
]

1. 划分 $0$-等价类:
- 接受状态类: $F = { E }$
- 非接受状态类: $Q \\ F = { A \, B \, C \, D }$
2. 划分 $1$-等价类:
- 状态 $A, B$ 和 $C$ 属于同一类, 因为它们在输入符号 `0` 和 `1` 下都转移到非接受状态类.
- 状态 $D$ 属于单独一类, 因为它在输入符号 `1` 下转移到接受状态类.
- 因此, $1$-等价类为: $ { A \, B \, C }$ 和 $ { D }$ 以及 $ { E }$.
3. 划分 $2$-等价类:
- 状态 $A$ 和 $C$ 属于同一类, 状态 $B$ 属于单独一类, 状态 $D$ 和 $E$ 仍然分别属于各自的类.
- 因此, $2$-等价类为: $ { A \, C }$ 和 $ { B }$ 以及 $ { D }$ 和 $ { E }$.
4. 划分 $3$-等价类:
- 划分结果与 $2$-等价类相同, 因为 $A, C$ 无法在长度为 $3$ 的输入字符串下区分开来.
5. 构造极小化 DFA:
#align(center)[
  #automaton(
    (
      AC: ("B": "0", "AC": "1" ),
      B: ("B": "0", "D": "1" ),
      D: ("B": "0", "E": "1" ),
      E: ("B": "0", "AC": "1" ),
    ),
    initial: "AC",
    final: ("E",),
    layout: finite.layout.custom.with(positions: (
      AC: (-3, 0),
      B: (1, 2),
      D: (5, 2),
      E: (5, -2),
    ))
  )
] 

*存在不可达状态时的处理*:
在极小化 DFA 之前, 需要先移除所有不可达状态. 不可达状态是指从初始状态出发无法到达的状态. 这些状态不会影响 DFA 识别的语言, 因此可以安全地删除它们以简化 DFA.

== Myhill-Nerode 定理
=== 字符串的语言不可区分性
设 $A$ 是一个语言, 则对于任意两个字符串 $x, y in Sigma^*$, 如果对于所有字符串 $z in Sigma^*$, 字符串 $x z in A$ 当且仅当 $y z in A$, 则称字符串 $x$ 和 $y$ 是 *不可区分* 的 (with respect to $A$). 否则, 它们是 *可区分* 的.

直观来讲, 如果从字符串 $x$ 和 $y$ 出发, 无论后续添加什么字符串 $z$, 它们是否属于语言 $A$ 的结果总是相同的, 则称它们是不可区分的.

如果 $x$ 和 $y$ 是用 $A$ 不可区分的, 则记为 $x equiv_A y$. 这定义了一个等价关系, 因为它满足自反性, 对称性和传递性. 通过该等价关系, 我们可以将字符串集合 $Sigma^*$ 划分为若干个等价类, 每个等价类包含所有彼此不可区分的字符串:
$
  Sigma ^*  = union.big_(i in I) [ x_i ]_A
$
其中
$
  [ x_i ]_A = { y in Sigma ^* | y equiv_A x_i }
$
这个等价类中, 如果有一个字符串能被语言 $A$ 接受, 则该等价类中的所有字符串都能被接受, 因为根据不可区分的定义, 我们可以取 $z = epsilon$.

=== 字符串的DFA不可区分性
设 $M = ( Q \, Sigma \, delta \, q_0 \, F )$ 是一个 DFA, 则对于任意两个字符串 $x, y in Sigma^*$, 如果 $delta ^* ( q_0 \, x ) = delta ^* ( q_0 \, y )$, 则称字符串 $x$ 和 $y$ 是 *不可区分* 的 (with respect to $M$). 否则, 它们是 *可区分* 的.

这里 $delta^*$ 是状态转移函数 $delta$ 的扩展, 它定义如下:
- $delta^* ( q \, epsilon ) = q$;
- $delta^* ( q \, a w ) = delta^* ( delta ( q \, a ) \, w )$, 其中 $a in Sigma$.

直观来讲, 如果从初始状态 $q_0$ 出发, 处理字符串 $x$ 和 $y$ 最终到达相同的状态, 则称它们是不可区分的.

类似地我们也可以用字符串的DFA不可区分性定义一个等价关系 $equiv_M$, 并将字符串集合 $Sigma^*$ 划分为若干个等价类.

=== 两种等价类的关系
设 $A = L(M)$, 则对于任意字符串 $x, y in Sigma^*$, 有
$
 x equiv_M y ==> x equiv_A y
$
这告诉我们, $M$ 对 $Sigma^*$ 的划分比 $A$ 对 $Sigma^*$ 的划分更细致 (即 $M$ 的等价类数量不少于 $A$ 的等价类数量).

*推论*: 如果语言 $A$ 是正则的, 那么 $equiv_A$ 的等价类的数目是有限的. 这是因为如果 $A$ 是正则的, 则存在一个识别 $A$ 的 DFA $M$, 而 DFA 的状态数量是有限的, 因此 $equiv_M$ 的等价类数量也是有限的. 由于 $equiv_A$ 的等价类数量不多于 $equiv_M$ 的等价类数量, 因此 $equiv_A$ 的等价类数量也是有限的.

=== Myhill-Nerode Theorem
1. 语言 $A$ 是正则的, 当且仅当 $equiv_A$ 的等价类的数量是有限的.
2. 如果语言 $A$ 是正则的, 则存在一个识别 $A$ 的极小化 DFA, 其状态数量等于 $equiv_A$ 的等价类的数量.

=== 填表法
填表法是一种基于 Myhill-Nerode 定理的 DFA 极小化算法. 其基本思想是通过识别和合并不可区分的状态来减少 DFA 的状态数量.

*算法步骤*:
1. 初始化: 创建一个表格, 其中行和列分别对应 DFA 的状态. 将表格的下三角部分初始化为空, 因为我们只需要考虑每对状态一次.
2. 标记接受状态和非接受状态: 对于每对状态 $(q_i, q_j)$, 如果一个是接受状态而另一个不是, 则将表格中的对应单元格标记为可区分 (通常用 `X` 表示).
3. 迭代标记: 重复以下步骤直到没有新的标记:
  - 对于每对未标记的状态 $(q_i, q_j)$, 检查对于每个输入符号 $a in Sigma$, 它们的转移状态 $delta ( q_i \, a )$ 和 $delta ( q_j \, a )$ 是否已经被标记为可区分.
  - 如果存在一个输入符号 $a$ 使得转移状态被标记为可区分, 则将 $(q_i, q_j)$ 标记为可区分.
4. 合并不可区分的状态: 对于所有未标记的状态对 $(q_i, q_j)$, 将它们合并为一个状态, 因为它们是不可区分的.
5. 构造极小化 DFA: 使用合并后的状态构造新的 DFA, 并更新状态转移函数和接受状态集合.

*例子*:

#align(center)[
  #automaton(
    (
      A: ("B": "0", "C": "1" ),
      B: ("B": "0", "D": "1" ),
      C: ("B": "0", "C": "1" ),
      D: ("B": "0", "E": "1" ),
      E: ("B": "0", "C": "1" ),
    ),
    initial: "A",
    final: ("E",),
    layout: finite.layout.custom.with(positions: (
      A: (-3, 0),
      B: (1, 2),
      C: (1, -2),
      D: (5, 2),
      E: (5, -2),
    ))
  )
]

1. 初始化表格:
#align(center)[
  #table(
    columns: (auto, auto, auto, auto, auto, auto),
    inset: 10pt,
    align: horizon,
    " ", "A", "B", "C", "D", "E",
    "A", "", "", "", "", "",
    "B", "", "", "", "", "",
    "C", "", "", "", "", "",
    "D", "", "", "", "", "",
    "E", "", "", "", "", "",
  )
]

2. 标记接受状态和非接受状态对:
#align(center)[
  #table(
    columns: (auto, auto, auto, auto, auto, auto),
    inset: 10pt,
    align: horizon,
    " ", "A", "B", "C", "D", "E",
    "A", "", "", "", "", "",
    "B", "", "", "", "", "",
    "C", "", "", "", "", "",
    "D", "", "", "", "", "",
    "E", "X", "X", "X", "X", "",
  )
]

3. 迭代标记:
*第一轮*:
观察到现在只有 $(C, E)$ 这样的状态是可以区分的, 所以我们只考虑能通过一次转移到达 $E$ 的状态对, 这里能转移到 $E$ 的状态只有 $D$:
- 检查 $(A, D)$, 对于输入 `1`, $delta (A , 1) = C$ 和 $delta (D , 1) = E$, 因此标记 $(A, D)$ 为可区分.
- 检查 $(B, D)$, 对于输入 `1`, $delta (B , 1) = D$ 和 $delta (D , 1) = E$, 因此标记 $(B, D)$ 为可区分.
- 检查 $(C, D)$, 对于输入 `1`, $delta (C , 1) = C$ 和 $delta (D , 1) = E$, 因此标记 $(C, D)$ 为可区分.

#align(center)[
  #table(
    columns: (auto, auto, auto, auto, auto, auto),
    inset: 10pt,
    align: horizon,
    " ", "A", "B", "C", "D", "E",
    "A", "", "", "", "", "",
    "B", "", "", "", "", "",
    "C", "", "", "", "", "",
    "D", "X", "X", "X", "", "",
    "E", "X", "X", "X", "X", "",
  )
]

*第二轮*:
观察到现在 $(A, D)$, $(B, D)$ 和 $(C, D)$ 都是可区分的, 所以我们只考虑能通过一次转移到达 $D$ 的状态对, 这里能转移到 $D$ 的状态只有 $B$:
- 检查 $(A, B)$, 对于输入 `1`, $delta (A , 1) = C$ 和 $delta (B , 1) = D$, 因此标记 $(A, B)$ 为可区分.
- 检查 $(B, C)$, 对于输入 `1`, $delta (B , 1) = D$ 和 $delta (C , 1) = C$, 因此标记 $(B, C)$ 为可区分.

#align(center)[
  #table(
    columns: (auto, auto, auto, auto, auto, auto),
    inset: 10pt,
    align: horizon,
    " ", "A", "B", "C", "D", "E",
    "A", "", "", "", "", "",
    "B", "X", "", "", "", "",
    "C", "", "X", "", "", "",
    "D", "X", "X", "X", "", "",
    "E", "X", "X", "X", "X", "",
  )
]

*第三轮*:
还有未标记的状态对 $(A, C)$, 检查 $(A, C)$, 对于输入 `0`, $delta (A , 0) = B$ 和 $delta (C , 0) = B$, 对于输入 `1`, $delta (A , 1) = C$ 和 $delta (C , 1) = C$, 因此 $(A, C)$ 仍然是不可区分的.

4. 合并不可区分的状态:
将状态 $A$ 和 $C$ 合并为一个状态 $A C$.

5. 构造极小化 DFA:
#align(center)[
  #automaton(
    (
      AC: ("B": "0", "AC": "1" ),
      B: ("B": "0", "D": "1" ),
      D: ("B": "0", "E": "1" ),
      E: ("B": "0", "AC": "1" ),
    ),
    initial: "AC",
    final: ("E",),
    layout: finite.layout.custom.with(positions: (  
      AC: (-3, 0),
      B: (1, 2),
      D: (5, 2),
      E: (5, -2),
    ))
  )
]

== 判断 DFA 的等价性
=== 方法一
将两个 DFA 极小化, 然后比较它们的状态转移图是否同构 (isomorphic). 如果同构, 则两个 DFA 等价; 否则不等价.

同构: 存在一个双射映射 $f: Q_1 -> Q_2$, 使得对于任意状态 $q in Q_1$ 和输入符号 $a in Sigma$, 都有 $f ( delta_1 ( q \, a ) ) = delta_2 ( f(q) \, a )$, 且 $q in F_1$ 当且仅当 $f(q) in F_2$.

=== 方法二
令 $M$ 和 $tilde(M)$ 是两个 DFA, $Sigma$ 是输入符号集合. 
1. 构造一个状态为 ${q, tilde(q)}$ 的 DFA $N$, 其中 $q$ 是 $M$ 的状态, $tilde(q)$ 是 $tilde(M)$ 的状态, 写出它的状态转移表.
2. 如果在某一步中, 我们发现一个状态对 ${q, tilde(q)}$ 中一个是接受状态而另一个不是, 则 $M$ 和 $tilde(M)$ 不等价.
3. 如果我们遍历了所有可能的状态对而没有发现上述情况,则 $M$ 和 $tilde(M)$ 等价.

= 文法 (Grammar)
== 引子
我们如何描述语言?
1. 自动机: 通过状态转移图描述语言的生成过程.
2. 正则表达式: 通过代数表达式描述语言的结构.
3. 文法: 语言的 *有穷描述*, 通过一组生成规则描述语言的构造方式.

当我们描述一种语言时, 就是要说明这种语言的句子
- 如果语言只含有有穷多个句子, 则可以直接列举出所有句子.
- 如果语言含有无穷多个句子, 存在着如何给出它的有穷表示的问题. 这需要一种规则, 用这些规则来描述语言的结构, 可以把这些规则看成一种元语言，这些规则就称为文法.

#quote(attribution: [Noam Chomsky])[
A _language_ is a collection of sentences of finite length
all constructed from a finite alphabet of symbols. \

A _grammar_ can be regarded as a device that enumerates the sentences of a language.
]

== 形式化定义
文法 (Grammar) $G$ 是一个四元组 $(V, T, P, S)$, 其中:
- $V$ 是一个有限的符号集合.  $A in V$ 称为 *变量* (Variables) 或 *非终结符* (Non-terminals), 表示一个 *语法范畴* (Syntactic Categories).
- $T$ 是 *终结符* (Terminals) 的有限集合, 且 $V inter T = emptyset$. 终结符是语言的基本符号, 例如字母, 数字, 标点符号等. 语言的句子由终结符组成.
- $S in V$ 是 *开始符号* (Start Symbol), 表示语言的起始范畴.
- $P$ 是 *产生式* (Productions) 的有限集合, 每个产生式的形式为 $alpha -> beta$, 其中 $alpha in ( V union T )^(+)$, $beta in ( V union T )^(*)$. 产生式定义了如何从变量生成终结符和其他变量的组合.

*约定*
1. 对一组有相同左部的产生式 $alpha -> beta_1, alpha -> beta_2, ..., alpha -> beta_n$, 我们可以将它们简写为 $alpha -> beta_1 | beta_2 | ... | beta_n$. 这里 $beta_1, beta_2, ..., beta_n$ 被称为 *候选* (Candidates).
2. 使用符号:
- 英文字母表较为前面的大写字母 (如 $A, B, C, ...$) 表示变量.
- 英文字母表较为后面的小写字母 (如 $a, b, c, ...$) 表示终结符.
- 希腊字母 (如 $alpha, beta, gamma, ...$) 表示变量和终结符的混合.

#showybox(
  title: "文法的例子",
  frame: frameSettings
)[
  考虑一个文法 $G = (V, T, P, S)$ 用于生成所有由偶数个 $a$ 组成的字符串, 其中
  - $V = { S }$, $T = { a }$, $S = S$, $P = { S -> a a S | epsilon }$

  该文法通过 $S -> a a S$ 产生偶数个 $a$, 通过 $S -> epsilon$ 终止生成过程. 该文法可以生成字符串 $epsilon, a a, a a a a, a a a a a a, ...$.
]

== 推导 (Derivation)
在文法 $G$ 中, 如果存在一个产生式 $alpha -> beta$ 且字符串 $w$ 可以表示为 $w = x alpha y$ (其中 $x, y in ( V union T )^(*)$), 则我们可以通过将 $alpha$ 替换为 $beta$ 来得到字符串 $w' = x beta y$. 这种替换称为 *直接推导*, 记为 $w =>_G w'$.

另一方面, 如果 $w =>_G w'$, 称 $w'$ 在文法 $G$ 中直接 *规约* (Reduce) 为 $w$.

基于此, 我们可以定义
1. $w =>_(G^n) w'$: 如果存在一系列字符串 $w_0, w_1, w_2, ..., w_n$ 使得 $w_0 = w$, $w_n = w'$, 且对于每个 $i$ (其中 $0 <= i < n$), 都有 $w_i =>_G w_(i+1)$, 则称 $w'$ 在文法 $G$ 中经过 $n$ 步推导得到 $w$, 记为 $w =>_(G^n) w'$.

2. $w =>_(G^*) w'$: 如果存在一个整数 $n >= 0$ 使得 $w =>_(G^n) w'$, 则称 $w'$ 在文法 $G$ 中推导得到 $w$, 记为 $w =>_(G^*) w'$.

3. $w =>_(G^+) w'$: 如果存在一个整数 $n >= 1$ 使得 $w =>_(G^n) w'$, 则称 $w'$ 在文法 $G$ 中经过至少一步推导得到 $w$, 记为 $w =>_(G^+) w'$.

== 语言, 句子和句型
设文法 $G = ( V, T, P, S )$, 则由 $G$ 生成的语言 $L(G)$ 定义为:
$
  L(G) = { w in T^(*) | S =>_(G^*) w }
$
其中 $w$ 称为语言 $L(G)$ 的 *句子* (Sentences) 或 *字符串* (Strings).

此外, 如果存在一个字符串 $w in ( V union T )^(*)$ 使得 $S =>_(G^*) w$, 则称 $w$ 是文法 $G$ 的 *句型* (Sentential Forms).

*注*: 句型可以包含变量和终结符, 而句子仅包含终结符.

== 文法的构造
=== 凑规则
给定一个语言, 我们需要找到一套规则. 这套规则能生成这个语言里的所有句子, 不多也不少. 一种常用的方法是 *凑规则*. 这不是一个严格的算法, 而是一种启发式的方法, 通过分析语言的结构和模式, 来设计合适的产生式.

+ 找出语言的若干句子
+ 分析句子的特点
+ 根据句子的特点凑规则
+ 验证规则的正确性

=== 文法的等价
如果两个文法 $G_1$ 和 $G_2$ 生成相同的语言, 即 $L(G_1) = L(G_2)$, 则称它们是 *等价* 的.

=== 例子
*构造文法 $G$, 使得 $G = {0, 1, 00, 11}$*

将文法的开始符号定义为这 4 个句子
$
  G_1 = ({S}, {0, 1}, { S -> 0 | 1 | 00 | 11 }, S)
$

用变量 $A$ 和 $B$ 分别表示单个 $0$ 和单个 $1$
$
  G_2 = ({S, A, B}, {0, 1}, { S -> A | B | A A | B B, A -> 0, B -> 1 }, S)
$

*$L = {0^(2n)1^(3n) | n >= 0}$*
$
  G_3 = ({S}, {0, 1}, { S -> epsilon | 00 S 111 }, S)
$

*$L = {w w^T | w in {0, 1, 2, 3}^+}$, 其中 $w^T$ 是字符串 $w$ 的反转 (reverse)*

可以利用递归的方法来构造文法:
$
  G &= (V, T, P, S) \
  V &= { S } \
  T &= { 0, 1, 2, 3 } \
  P &= { S -> 0 S 0 | 1 S 1 | 2 S 2 | 3 S 3 | 0 0 | 1 1 | 2 2 | 3 3 } \
$

*$L = {w | w "is decimal rational number"}$*
$
  G &= (V, T, P, S) \
  V &= { S, R, N, M, A, B, D} \
  T &= { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, ".", "-", "+" } \
  P &= { S -> R | "-" R | "+" R, \ &quad R -> N | B, \ &quad B -> N.D, \ &quad N -> 0 | A M, \ &quad D -> 0 | M A, \ &quad A -> 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9, \ &quad M -> A | A M | epsilon \
  }
$

这里
- $S$ 表示整个数字
- $R$ 表示可选的符号和数字部分
- $N$ 表示整数部分, 如果超过 $0$ 则不能以 $0$ 开头
- $B$ 表示带小数点的数字
- $D$ 表示小数部分, 不能以 $0$ 结尾
- $A$ 表示非零数字
- $M$ 表示任意数量的数字

== 正则文法
=== 文法的 Chomsky 体系
设 $G = ( V, T, P, S )$ 是一个文法, 则根据产生式的形式, 我们可以将文法划分为以下四种类型:
1. 类型 0 (Type 0): *无约束文法* (Unrestricted Grammars), 其产生式形式为 $alpha -> beta$, 其中 $alpha in ( V union T )^(+)$, $beta in ( V union T )^(*)$.

无约束文法可以描述所有可计算的语言, 但其解析复杂度较高, 我们通常不直接在实践中处理无约束文法.

2. 类型 1 (Type 1): *上下文相关文法* (Context-Sensitive Grammars, *CSG*), 其产生式形式满足 $|beta| >= |alpha|$ 且 $beta != epsilon$.

这里是 "非收缩" 定义. 另外有一种等价定义的产生式形式为 $alpha_1 A alpha_2 -> alpha_1 beta alpha_2$, 其中 $A in V$, $alpha_1, alpha_2 in ( V union T )^(*)$, $beta in ( V union T )^(+)$. 这里 $|A| = 1$, $|beta| > 1$, 且替换 $A$ 时需要考虑其上下文 $alpha_1$ 和 $alpha_2$.

3. 类型 2 (Type 2): *上下文无关文法* (Context-Free Grammars, *CFG*), 其产生式形式为 $A -> beta$, 其中 $A in V$, $beta in ( V union T )^(*)$.

这里 $A$ 是单个变量, 替换 $A$ 时不考虑其上下文.

4. 类型 3 (Type 3): *正则文法* (Regular Grammars, *RG*), 其产生式形式为 $A -> a B$ 或 $A -> a$ 或 $A -> epsilon$, 其中 $A, B in V$, $a in T$.

正则文法是最简单的一类文法, 每次替换只能处理一个终结符, 并且可以选择性地跟随一个变量或结束替换过程. 

=== 线性文法
一个文法是 *线性文法* (Linear Grammar), 如果它的所有产生式都满足以下形式之一:
1. $A -> w B$
2. $A -> B w$
3. $A -> w$
其中 $A, B in V$, $w in T^(*)$. 也就是说, 每个产生式的右部 *最多* 包含一个变量.

*右线性文法* (Right-Linear Grammar) 是线性文法的一种特殊情况, 其中所有产生式都满足形式 $A -> w B$ 或 $A -> w$, 也就是说变量只能出现在最右侧; *左线性文法* (Left-Linear Grammar) 是线性文法的另一种特殊情况, 其中所有产生式都满足形式 $A -> B w$ 或 $A -> w$, 即变量只能出现在最左侧.

一个文法是正则文法的充分必要条件是, 要么它的所有产生式都是右线性的, 要么它的所有产生式都是左线性的. *两种语法不能混合使用*, 否则可能生成非正则语言.

=== 正则文法与正则语言的等价性
*把右线性文法转换为 NFA*:
1. 为文法的每个变量创建一个状态.
2. NFA 的初始状态对应文法的开始符号.
3. 对于每个产生式 $A -> a B$, 添加一个从状态 $A$ 到状态 $B$ 的转换, 输入符号为 $a$.
4. 对于每个产生式 $A -> a$, 添加一个从状态 $A$ 到接受状态的转换, 输入符号为 $a$.
5. 如果存在产生式 $A -> epsilon$, 则将状态 $A$ 标记为接受状态.

*把 DFA 转换为右线性文法*:
1. 为 DFA 的每个状态创建一个变量.
2. 文法的开始符号对应 DFA 的初始状态.
3. 对于每个转换 $delta ( q_i \, a ) = q_j$, 添加一个产生式 $A_i -> a A_j$, 其中 $A_i$ 和 $A_j$ 分别对应状态 $q_i$ 和 $q_j$.
4. 对于每个接受状态 $q_f$, 添加一个产生式 $A_f -> epsilon$, 其中 $A_f$ 对应状态 $q_f$.

#showybox(
  title: "左线性文法呢?",
  frame: frameSettings
)[
  直接把左线性文法的所有产生式反转, 就能得到一个右线性文法. 因为正则语言对反转是封闭的, 所以左线性文法生成的语言也是正则语言.
]

== 空语句 (Null Sentence)
=== "不合法" 的规则
理论上来说, 产生空语句的规则 $A -> epsilon$ 是收缩的, 所以不属于类型 1 (上下文相关文法) 的定义范围. 但是在实际应用中, 我们通常允许文法包含产生空语句的规则, 因为空语句在很多语言中是有意义的.

=== 准备工作: 如何处理开始符号
*定理1*: 对于任何一个文法 $G$, 都存在一个等价的文法 $G'$ 满足以下条件:
1. $G'$ 中的开始符号 $S'$ 不出现在任何产生式的右部.
2. $L(G') = L(G)$.

*证明*:
1. 创造一个全新的开始符号 $S'$.
2. 找到旧文法 $G$ 中所有以旧开始符号 $S$ 为左部的产生式, 并将它们复制到新文法 $G'$ 中, 但将左部替换为 $S'$.
3. $G'$ 包含旧文法 $G$ 中的所有产生式, 以及我们新增的 $S' -> dots.c$ 规则.

这就相当于给一个公司重组: 原来的 CEO $S$ 既要做决策 (出现在左部), 还要执行任务 (出现在右部). 为了让 CEO 专注于决策, 我们任命一个新的董事长 $S'$, 其唯一工作就是任命 CEO $S$ 来执行任务. 这样, 新的董事长 $S'$ 就不会出现在任何任务描述中 (右部).

=== 如何给一个语言添加空语句
如果一个语言 $L$ 是某种类型 (比如说上下文无关语言 CFL), 则我们可以通过以下步骤构造一个新的文法 $G'$ 来生成包含空语句的语言 $L' = L union { epsilon }$, 其类型保持不变:
1. 任何一个语言 $L$, 都有一个文法 $G$ 生成它.
2. 根据定理 1, 构造一个等价的文法 $G'$ 使得 $G'$ 的开始符号 $S'$ 不出现在任何产生式的右部.
3. 在 $G'$ 中添加一个新的产生式 $S' -> epsilon$.
4. 因为 $S'$ 不出现在任何产生式的右部, 所以添加 $S' -> epsilon$ 不会影响其他句子的生成, 它唯一的作用就是能直接产生一个空语句.
5. 所以新文法产生的语言 $L(G') = L(G) union { epsilon }$, 且 $G'$ 的类型与 $G$ 相同.

=== 如何从一个语言中移除空语句
<remove-null-sentence>
如果一个语言 $L$ 包含空语句, 则我们可以通过以下步骤构造一个新的文法 $G'$ 来生成不包含空语句的语言 $L' = L \\ { epsilon }$, 其类型保持不变:
1. 如果 $epsilon in L$, 则必须存在一个文法 $G$ 生成 $L$ 且包含一个产生式 $S -> epsilon$, 其中 $S$ 是 $G$ 的开始符号.
2. 利用定理 1, 构造一个等价的文法 $G''$ 使得 $G''$ 的开始符号 $S'$ 不出现在任何产生式的右部.
3. 在这种情况下, $S' -> epsilon$ 这条规则是 "孤立" 的, 它只负责产生空语句. 所以我们可以直接删除这条规则.
4. 删除后的新文法产生的语言, $L(G') = L(G) \\ { epsilon }$, 且 $G'$ 的类型与 $G$ 相同.

= 上下文无关文法 (CFG)
== CFG 的派生树
在上下文无关文法 (CFG) 中, 我们可以使用 *派生树* (Derivation Trees) 来表示句子的生成过程. 派生树是一种树形结构, 其中:
- 每个内部节点表示一个变量 (非终结符).
- 每个叶子节点表示一个终结符 (终结符) 或空串 $epsilon$.
- 根节点表示开始符号.
- 从根节点到叶子节点的路径表示从开始符号到句子的推导过程.

考虑下面算术表达式的文法
$
  G: & E -> E + T | E - T | T \
  & T -> T * F  | T \/ F | F \
  & F -> F arrow.t P | P \
  & P -> (E) | N (L) | "id" \
  & N -> "sin" | "cos" | "exp" | "log" | ... \
  & L -> L, E | E
$

其中
- $E$ 表示表达式 (Expressions), 通过加法和减法组合.
- $T$ 表示项 (Terms), 通过乘法和除法组合.
- $F$ 表示因子 (Factors), 通过底数和指数组合.
- $P$ 表示基本元素 (Primitives), 可以是括号内的表达式, 函数调用, 或标识符.
- $N$ 表示函数名称 (Function Names).
- $L$ 表示函数参数列表 (Argument Lists), 通过逗号分隔的表达式序列.

和表达式 $x + x \/ y arrow.t 2$:

#align(center)[
  #tidy-tree-graph(
    spacing: (20pt, 20pt),
    node-inset: 4pt
  )[
    - $E$
      - $E$
        - $T$
          - $F$
            - $P$
              - id =  $x$
      - $+$
      - $T$
        - $T$
          - $F$
            - $P$
              - id =  $x$
        - $\/$
        - $F$
          - $F$
            - $P$
              - id =  $y$
          - $arrow.t$
          - $P$
            - $2$
  ]
]

*注意派生树是有序的*: 同一层级的节点从左到右的顺序与产生式中候选的顺序一致.


*派生子树*: 派生树的任意一个节点及其所有子节点构成一个子树, 称为 *派生子树* (Subtree). 派生子树本身也是一个派生树, 可以表示从该节点开始的推导过程. 它和派生树的区别在于根节点可以标记为任意变量, 而不是必须是开始符号.

== 最左派生和最右派生
在 CFG 中, 我们可以通过不同的策略来选择替换变量的顺序
- *最左派生* (Leftmost Derivation): 每次选择最左侧的变量进行替换.
- *最右派生* (Rightmost Derivation): 每次选择最右侧的变量进行替换.

- *左句型* (Left Sentential Form): 在最左派生过程中出现的句型.
- *右句型* (Right Sentential Form): 在最右派生过程中出现的句型.

- *最右归约* (Rightmost Reduction): 逆向过程, 每次选择最右侧的变量进行规约, 和最*左*派生对应.
- *最左归约* (Leftmost Reduction): 逆向过程, 每次选择最左侧的变量进行规约, 和最*右*派生对应.

*规范派生*: 我们约定最右派生为 CFG 的 *规范派生* (Canonical Derivation), 相应地, 最左归约为 CFG 的 *规范归约* (Canonical Reduction). 

== 派生树和句型的关系
设 CFG $G = (V, T, P, S)$, 则 $S =>_(G^*) alpha$ 的充分必要条件是存在一个以 $S$ 为根节点, 以 $alpha$ 为叶子节点的派生树.

如果 $alpha$ 是 $G$ 的一个句型, 则 $G$ 中存在 $alpha$ 的最左派生和最右派生.

对于一个给定的句型 $alpha$, 它的派生树是唯一的. 从这棵派生树出发，只能构造出唯一的一个最左派生过程, 同样地也只能构造出唯一的一个最右派生过程.
=== 文法的二义性
对于计算机语言来说, 一条指令必须有且仅有一个确切的含义. 如果一个语法规则 (文法) 允许一个句子 (或一段代码) 被解释成两种或更多的含义, 那么这个文法就是 *二义性* 的.

既然二义性这么糟糕, 我们必须消除它. 方法有两种:
1. *外部规定*: 通过在文法之外添加额外的规则来消除二义性. 例如, 在算术表达式中规定乘法优先于加法, 这样就能消除表达式 $a + b * c$ 的二义性.
2. *修改文法本身*: 我们可以设计一套更精巧的语法规则, 让它本身就含有优先级的概念. 比如, 我们可以引入不同的变量来表示不同优先级的表达式, 例如:
$  E -> E + T | T \
  T -> T * F | F \
  F -> ( E ) | id \
$
这样, 乘法 $T * F$ 总是在加法 $E + T$ 之内被解析, 从而消除了二义性.

但是, 二义性问题是 *不可解的* (Undecidable). 对于一个语言, 在产生它的所有可能文法中, 有的可能是二义性的, 有的可能不是. 而且, 我们无法设计一个通用的算法来判断任意文法是否二义性.

*固有二义性* (Inherently Ambiguous) 的语言是指那些无论用什么文法来描述, 都无法避免二义性的语言.

== 解析 (Parsing)
<parsing>
解析是给定 $w in L(G)$, 确定如何从开始符号 $S$ 推导出 $w$ 的过程. 解析的结果通常表示为一个派生树, 显示了从 $S$ 到 $w$ 的推导步骤.

最直观的解析方法就是先写出文法 $G$ 的所有可能派生, 检查是否能得到 $w$. 这种方法叫做 *穷举解析* (Exhaustive Parsing), 但它效率极低, 因为可能的派生数量随着句子长度呈指数增长. 可以分为自顶向下解析 (Top-Down Parsing) 和自底向上解析 (Bottom-Up Parsing) 两大类.

在特定情况下, 穷举解析是可行的. 如果上下文无关文法 $G = (V, T, P, S)$ 不包含任何空产生式 $A -> epsilon$ 和单一产生式 $A -> B$ (其中 $A, B in V$), 那么对于任意字符串 $w in Sigma^*$, 穷举搜索解析方法可以得到 $w$ 的解析 (即找到一个推导过程), 或者判定 $w in.not L(G)$.

=== 解析的复杂度
对于任意上下文无关文法 $G$ 和字符串 $w$ (长度为 $n$), 存在一种解析算法, 它能在 $O(n^3)$ 时间内完成解析任务. 这个算法称为 *CYK 算法* (Cocke-Younger-Kasami Algorithm), 它基于动态规划的思想, 通过构建一个解析表来记录子字符串的可能生成变量, 最终确定整个字符串是否能由开始符号生成.

但是这样的解析算法并不高效. 对于某些特定类型的上下文无关文法, 可以设计出更高效的解析算法. 

上下文无关文法 $G = (V, T, P, S)$ 被称为 *简单文法* (Simple Grammar), 或者 $s$-文法, 如果它的所有产生式具有如下形式
$
  A -> a x
$
其中 $A in V, a in T, x in V^*$ 且 $(A, a)$ 在产生式 $P$ 中至多出现一次.

如果 $G$ 是一个 $s$-文法, 则对于 $forall w in G$, $w$ 的解析可以在 $O(n)$ 时间内完成.

== 上下文无关语法的化简
=== 为什么要化简?
上面我们提到简单文法更容易被解析, 所以为了提高解析效率, 我们希望能把一个上下文无关文法化简为等价的, 满足一定约束条件的形式.

=== 替换规则
设在一个 CFG 的产生式集合 $P$ 中, 存在一个产生式 $A -> x_1 B x_2$. 其中 $A != B$ 且有 $B -> y_1 | y_2 | dots.c | y_n$ 是 $P$ 中所有以 $B$ 为左部的产生式. 则我们可以用以下步骤来替换 $B$:

1. 删除产生式 $A -> x_1 B x_2$.
2. 添加产生式 $A -> x_1 y_1 x_2 | x_1 y_2 x_2 | dots.c | x_1 y_n x_2$.

可以证明, 替换前后的文法是等价的.

=== 去除无用符号
给定一个 CFG $G = ( V, T, P, S )$, 变量 $A in V$ 被称为 *有用的* (Useful), 当且仅当存在字符串 $w in L(G)$, 满足
$
  S =>_(G^*) x A y =>_(G^*) w.
$
换言之, $A$ 有用当且仅当它出现在某一个字符串的推导过程中, 否则称 $A$ 是 *无用的* (Useless). 由此, $A$ 是无用的存在两种可能:
1. $A$ 无法生成任何终结符串, 即不存在字符串 $w in T^(*)$ 使得 $A =>_(G^*) w$.
2. $A$ 无法从开始符号 $S$ 推导出来, 即不存在字符串 $w_1, w_2 in ( V union T )^(*)$ 使得 $S =>_(G^*) w_1 A w_2$.

根据这两个情况, 我们可以设计两个算法来去除无用符号:

#algorithm-figure(
  "去除无法派生字符串的变量符号",
  vstroke: .5pt + luma(200),
  {
    import algorithmic: *
    Procedure(
      "RemoveNonGeneratingSymbols",
      ($V$, $P$, $T$, $S$),
      {
        Assign[$V_"old"$][$emptyset$]
        Assign[$V_"new"$][${A | A -> w in P "and" w in T^*}$]
        LineBreak
        While(
          $V_"old" != V_"new"$,
          {
            Assign[$V_"old"$][$V_"new"$]
            Assign[$V_"new"$][$V_"old" union {A | A -> x in P "and" x in (V_"old" union T)^*}$]
          },
        )

        LineBreak
        Assign[$V'$][$V_"new"$]
        Assign[$P'$][${A -> w in P | A in V' "and" w in (V' union T)^*}$]
        Return[$V'$, $P'$, $T$, $S$]
      },
    )
  }
)

这里一开始 $V_"new"$ 被初始化为所有能一步生成终结符串的变量. 然后, 在每次迭代中, 我们将 $V_"new"$ 更新为所有能生成由 $V_"old"$ 和 $T$ 组成的字符串的变量. 这个过程持续进行, 直到 $V_"new"$ 不再变化为止. 这是一个从派生树的叶子节点向上收集变量的过程. 

#algorithm-figure(
  "去除无法到达的符号",
  vstroke: .5pt + luma(200),
  {
    import algorithmic: *
    Procedure(
      "RemoveUnreachableSymbols",
      ($V$, $P$, $T$, $S$),
      {
        Assign[$V_"old"$][$emptyset$]
        Assign[$T_"old"$][$emptyset$]
        Assign[$V_"new"$][${S} union {A | S -> x A y in P}$]
        Assign[$T_"new"$][${a | S -> x a y in P}$]
        LineBreak
        While(
          $V_"old" != V_"new" or T_"old" != T_"new"$,
          {
            Assign[$V_"old"$][$V_"new"$]
            Assign[$T_"old"$][$T_"new"$]
            Assign[
              $V_"new"$][
              $V_"old" union {B | A in V_"old" "and" A -> x B y in P "and" B in V}$
            ]
            Assign[
              $T_"new"$][
              $T_"old" union {a | A in V_"old" "and" A -> x a y in P "and" a in T}$
            ]
          },
        )

        LineBreak
        Assign[$V'$][$V_"new"$]
        Assign[$T'$][$T_"new"$]
        Assign[$P'$][${A -> alpha in P | A in V' and alpha in (T' union V')^*}$]
        Return[$V'$, $P'$, $T'$, $S$]
      },
    )
  }
)

需要注意的是, 为了删去 CFG 中的所有无用变量, 我需要先使用算法1, 去除无法派生字符串的变量符号, 然后再使用算法2, 去除无法到达的符号. 这是因为一个变量可能既无法生成终结符串, 又无法从开始符号推导出来. 只有先去除那些无法生成终结符串的变量, 才能确保在去除无法到达的符号时不会遗漏任何无用变量.

=== 去除 $epsilon$-产生式
参见 @remove-null-sentence

=== 去除单一产生式
在一个 CFG $G = ( V, T, P, S )$ 中, 如果存在一个产生式 $A -> B$, 其中 $A, B in V$, 则称其为 *单一产生式* (Unit Production). 我们可以通过以下步骤来去除所有单一产生式:
1. 对于每个变量 $A in V$, 找出所有能通过一系列单一产生式从 $A$ 推导出来的变量集合 $"Unit"(A)$.
2. 对于每个变量 $A in V$ 和每个变量 $B in "Unit"(A)$, 将 $B$ 的所有非单一产生式添加到 $A$ 的产生式集合中.
3. 删除所有单一产生式.

=== CFG 化简步骤
1. 去除空产生式.
2. 去除单一产生式.
3. 去除无用符号 (先去除无法生成字符串的变量, 再去除无法到达的符号).

= CFG 的规范形式 (Normal Forms)
== Chomsky 范式 (CNF)
=== 定义
如果一个 CFG $G = ( V, T, P, S )$ 的所有产生式都满足以下形式之一:
1. $A -> B C$, 其中 $A, B, C in V$
2. $A -> a$, 其中 $A in V$, $a in T$
则称 $G$ 是 Chomsky 范式 (CNF).


=== 转换为 CNF
对于任意一个 CFG $G = ( V, T, P, S )$, 我们可以通过以下步骤将其转换为等价的 CNF 文法 $G' = ( V', T', P', S' )$:
1. 确保 $G$ 不存在空产生式和单一产生式. 如果存在, 则先使用前面提到的化简算法去除它们.
2. 对于每个产生式 $A -> a_1 a_2 ... a_n$ (其中 $n >= 2$ 且 $a_i in T$), 将其替换为一系列产生式:
   - $A -> X_1 X_2 ... X_n$, 其中每个 $X_i$ 是一个新的变量, 并添加产生式 $X_i -> a_i$ 到 $P'$.
3. 对于每个产生式 $A -> B_1 B_2 ... B_n$ (其中 $n >= 3$ 且 $B_i in V$), 将其替换为一系列产生式:
   - $A -> B_1 Y_1,  Y_1 -> B_2 Y_2, ..., Y_(n-2) -> B_(n-1) B_n$, 其中每个 $Y_i$ 是一个新的变量.

=== CYK 算法
CYK 算法是一种用于解析上下文无关文法的动态规划算法. 它要求输入的文法必须是 Chomsky 范式 (CNF). 该算法通过构建一个解析表来记录子字符串的可能生成变量, 最终确定整个字符串是否能由开始符号生成.

#showybox(
  title: "CNF 的二叉树结构",
  frame: frameSettings
)[
  由于 CNF 的产生式形式限制了每次替换只能生成两个变量或一个终结符, 因此其派生树必然是二叉树结构. 它的叶子节点对应终结符, 内部节点对应变量.

  正因为 CNF 的这种二叉树结构, CYK 算法能够高效地构建解析表, 通过动态规划的方法逐步填充表格, 最终确定字符串是否能由开始符号生成.
]

== Greibach 范式 (GNF)
<GNF>
=== 定义
如果一个 CFG $G = ( V, T, P, S )$ 的所有产生式都满足以下形式
$ A -> a x, $ 其中 $A in V$, $a in T$, $x in V^*$
则称 $G$ 是 Greibach 范式 (GNF).

=== 转换为 GNF
对于任意一个 CFG $G = ( V, T, P, S )$, 我们可以通过以下步骤将其转换为等价的 GNF 文法 $G' = ( V', T', P', S' )$:
1. 确保 $G$ 不存在空产生式和单一产生式. 如果存在, 则先使用前面提到的化简算法去除它们.
2. 对变量进行编号, 使得 $V = { A_1, A_2, ..., A_n }$.
3. 对于每个产生式 $A_i -> A_j x$ (其中 $j <= i$), 将 $A_j$ 替换为其所有产生式的右部, 即:
   - 如果 $A_j -> a y$ (其中 $a in T$, $y in V^*$), 则添加产生式 $A_i -> a y x$.
   - 如果 $A_j -> B z$ (其中 $A_k in V$, $z in V^*$), 则添加产生式 $A_i -> A_k z x$. 这里的 $k > i$.
4. 对于每个产生式 $A_i -> a x$ (其中 $a in T$), 保持不变.
5. 重复步骤 3 和 4, 直到所有产生式都满足 GNF 的形式.

= 下推自动机 (PDA)
== 定义
下推自动机 (Pushdown Automaton, *PDA*) 是一种比有限状态自动机更强大的计算模型. 它在有限状态自动机的基础上增加了一个栈 (Stack) 作为辅助存储器, 使其能够处理更复杂的语言, 特别是上下文无关语言 (CFG).

一个下推自动机 $M$ 定义为一个七元组
$
  M = ( Q, Sigma, Gamma, delta, q_0, Z_0, F )
$
其中
- $Q$ 是有限状态集合.
- $Sigma$ 是输入符号的有限集合 (输入字母表).
- $Gamma$ 是栈符号的有限集合 (栈字母表).
- $delta: Q times ( Sigma union { epsilon } ) times Gamma -> P( Q times Gamma^(*) )$ 是状态转移函数, 其中 $P$ 表示幂集.
- $q_0 in Q$ 是初始状态.
- $Z_0 in Gamma$ 是初始栈符号.
- $F subset.eq Q$ 是接受状态集合.

这里转移函数的具体形式就是
$
  delta ( q, a, X ) = { ( p_1, gamma_1 ), ( p_2, gamma_2 ), ..., ( p_k, gamma_k ) }
$
表示当 PDA 处于状态 $q$, 读取输入符号 $a$ (或 $epsilon$), 并且栈顶符号为 $X$ 时, 它可以转移到状态 $p_i$ 并将栈顶符号 $X$ 替换为字符串 $gamma_i$ (其中 $1 <= i <= k$). 这里的替换也可以被理解为, 先弹出栈顶符号 $X$, 然后将字符串 $gamma_i$ 的符号依次压入栈中 (从右到左).

特别地, 当 $a = epsilon$ 时, 表示 PDA 可以在不读取输入的情况下进行状态转移和栈操作. 这被称为 *空移动*

== PDA 的计算过程
一个 PDA $( Q, Sigma, Gamma, delta, q_0, Z_0, F )$ 接受输入串 $w$, 如果
1. $w$ 可以写成 $w_1 w_2 ... w_n$, 其中 $w_i in Sigma union { epsilon }$.
2. 存在一个状态序列 $r_0, r_1, r_2, ..., r_n in Q$ 和栈内容序列 $s_0, s_1, s_2, ..., s_n in Gamma^(*)$ 满足:
  - 初始条件: $r_0 = q_0$ 且 $s_0 = Z_0$.
  - 转移条件: 对于每个 $i$ (其中 $0 <= i < n$), 存在 $( r_(i+1), gamma ) in delta( r_i, w_(i+1), X )$, 其中 $X$ 是栈顶符号, 并且 $s_(i+1)$ 是通过将栈顶符号 $X$ 替换为字符串 $gamma$ 得到的栈内容.
  - 接受条件: $r_n in F$.

举一个例子, 考虑一个 PDA 用于识别语言 $L = { 0^n 1^n | n >= 0 }$, 我们可以这么设计它:

#align(center)[
  #automaton(
    (
      q1: (q2: "eps, eps -> $"),
      q2: (q2: "0, eps -> 0", q3: "1, 0 -> eps"),
      q3: (q3: "1, 0 -> eps", q4: "eps, $ -> eps"),
    ),
    initial: "q1",
    final: ("q1", "q4"),
    labels: (
      "q1-q2": [$epsilon, space epsilon -> \$ $],
      "q2-q2": [ $0, space epsilon -> 0 $ ],
      "q2-q3": [ $1, space 0 -> epsilon $ ],
      "q3-q3": [ $1, space 0 -> epsilon $ ],
      "q3-q4": [ $epsilon, space \$ -> epsilon $ ]
    ),
    layout: finite.layout.custom.with(positions: (
      q1: (0, 0),
      q2: (6, 0),
      q3: (6, -6),
      q4: (0, -6)
    ))
  )
]

这个 PDA 的工作原理如下:
1. 初始状态 $q_1$: PDA 将栈初始化为包含一个特殊符号 `$`.
2. 状态 $q_2$: PDA 读取输入的 `0`, 每读取一个 `0`, 就将一个 `0` 压入栈中.
3. 状态 $q_3$: 当 PDA 读取到输入的 `1` 时, 它开始弹出栈中的 `0` 来匹配输入的 `1`. 每读取一个 `1`, 就弹出一个 `0`.
4. 状态 $q_4$: 当输入全部读取完毕, 并且栈中只剩下特殊符号 `$` 时, PDA 弹出 `$` 并进入接受状态.

通过这种方式, PDA 能够确保输入中 `0` 的数量与 `1` 的数量相等, 从而识别非正则语言 $L$. 可以发现, 相较于有限状态自动机, 下推自动机通过引入栈结构, 获得了 "记忆" 的能力, 能够处理更复杂的语言结构.

== PDA 的即时描述
PDA 的即时描述 (Instantaneous Description, *ID*) $(q, w, gamma)$ 用于表示 PDA 在某一时刻的 *状态*. 一个 ID 由三部分组成:
1. 当前状态 $q in Q$.
2. 剩余输入串 $w in Sigma^(*)$.
3. 当前栈内容 $gamma in Gamma^(*)$.

这样我们就可以用 ID 来描述 PDA 在计算过程中的每一个步骤. 例如,
$
  (q, a w, Z beta) tack.r_M (p, w, gamma beta)
$
表示当 PDA 处于状态 $q$, 剩余输入串为 $a w$, 栈内容为 $Z beta$ 时, 它可以通过读取输入符号 $a$ 并弹出栈顶符号 $Z$, 转移到状态 $p$, 剩余输入串变为 $w$, 栈内容变为 $gamma beta$. 若 $a in Sigma$, 则称之为 *非空移动*; 若 $a = epsilon$, 则称之为 *空移动*.

类似之前我们定义推导的方式, 我们可以定义:
- $tack.r_(M^n)$: 表示经过 $n$ 步转移.
- $tack.r_(M^*)$: 表示经过任意步数的转移.
- $tack.r_(M^+)$: 表示经过至少一步的转移.

== PDA 的 ID 转移性质
1. 在一个合法计算中, 如果给所有ID的 *栈底* 统一加上相同的符号, 得到的新计算仍然合法. 这是因为PDA的栈操作只能从栈顶进行, 它无法 "看到" 栈底新加的那些符号, 除非它把上面的全都弹出去. 只要它没弹到那些新加符号, 这些符号就对转移没有任何影响.

2. 如果一个ID序列是合法的, 那么在所有ID的输入串末尾加上同一个字符串, 新序列依然是合法的; 反之, 如果一个合法计算对应的输入串后面还有一段未被读取的内容, 那么把这段内容从所有ID的输入中删掉, 得到的计算依然合法.

这两条说明了 PDA 的决策是局部的、短视的. 它没有全局视野, 只能根据眼前这一点信息做动作. 也正是这种 "局部性", 使得PDA虽然比有限自动机强大, 却仍不足以处理所有上下文有关语言.

== PDA 的接受语言
一个 PDA 有两种方式去接受一个输入串 $w in Sigma^(*)$:

=== 以终结状态方式接受
设 $M = (Q, Sigma, Gamma, delta, q_0, Z_0, F)$ 是一个 PDA, 那么 $M$ 以终结状态方式接受的语言为
$
  L(M) = { w | (q_0, w, Z_0) tack.r_(M^*) (q_f, epsilon, gamma) "for some" q_f in F, gamma in Gamma^(*) }
$
这种接受方式要求 PDA 在读取完整个输入串后, 处于一个接受状态, 无论栈中是否还有剩余符号.

=== 以空栈方式接受
设 $M = (Q, Sigma, Gamma, delta, q_0, Z_0, F)$ 是一个 PDA, 那么 $M$ 以空栈方式接受的语言为
$
  N(M) = { w | (q_0, w, Z_0) tack.r_(M^*) (q, epsilon, epsilon) "for some" q in Q }
$
这种接受方式要求 PDA 在读取完整个输入串后, 栈必须为空. 此时, 集合 $F$ 中的状态就不再重要, 所以我们可以把它去掉, 从而将 PDA 简化为六元组 $M = ( Q, Sigma, Gamma, delta, q_0, Z_0 )$.

=== 两种接受方式的等价性
对于任意一个 PDA $M$ (以终结状态方式接受), 存在一个等价的 PDA $M'$ (以空栈方式接受), 使得 $L(M) = N(M')$. 反之亦然, 对于任意一个 PDA $M$ (以空栈方式接受), 存在一个等价的 PDA $M'$ (以终结状态方式接受), 使得 $N(M) = L(M')$.

*从终结状态方式到空栈方式*:
给定一个以终结状态接受语言 $L$ 的 PDA $M$, 我们希望造一个 $M'$, 它不关心是否停在终结状态, 只关心是否清空栈, 且清空栈当且仅当原机 $M$ 停在终结状态. 我们可以这么做:
1. $M'$ 先模拟 $M$ 的行为, 即复制 $M$ 的所有状态和转移规则.
2. 在 $M$ 进入任何一个终结状态时, $M'$ 立刻开始弹出栈中的所有符号, 直到栈为空为止. 

这里的 2. 可以通过添加新的状态和转移规则来实现. 例如, 对于每个终结状态 $q_f in F$ 和每个栈符号 $X in Gamma$, 添加一个新的状态 $q_f'$ 和转移规则
$
  delta'( q_f, epsilon, X ) = { ( q_f', epsilon ) }
$
以及
$
  delta'( q_f', epsilon, X ) = { ( q_f', epsilon ) }
$
直到栈为空时, $M'$ 停在状态 $q_f'$.

*从空栈方式到终结状态方式*:
给定一个以空栈接受语言 $L$ 的 PDA $M$, 我们希望造一个 $M'$, 它在栈清空时停在一个终结状态. 我们可以这么做:
1. $M'$ 先模拟 $M$ 的行为, 但是 $M'$ 先要在栈底压入一个特殊符号 `$`, 以标记栈底.
2. 当 $M$ 清空栈时, $M'$ 的栈中只剩下 `$`. 此时, $M'$ 弹出 `$` 并进入一个新的终结状态 $q_f$.

== PDA 和 CFG 的等价性
类似于 DFA/NFA 和正则文法的等价性, PDA 和 CFG 之间也存在等价关系. 具体来说:
1. 对于任意一个上下文无关文法 (CFG) $G$, 存在一个等价的下推自动机 (PDA) $M$, 使得 $L(G) = L(M)$.
2. 对于任意一个下推自动机 (PDA) $M$, 存在一个等价的上下文无关文法 (CFG) $G$, 使得 $L(M) = L(G)$.
=== 从 CFG 构造 PDA
为了方便起见, 我们假设 CFG 不生成空串 $epsilon$, 由此我们可以把它转化为 Greibach 范式 (GNF, @GNF). 一个 GNF 的产生式满足如下形式
$
  A -> a V_1 V_2 ... V_k
$
其中 $A, V_i in V$, $a in T$, 且 $k >= 0$. 也就是说, 每应用一条语法规则, GNF 必须且只能消耗输入带上的一个字符.

所以, 我们只需要构造一个单状态 (Single-state) 的 PDA, 所有的逻辑控制完全交给栈来完成:

1. *状态*: 设该 PDA 只有一个状态 $q$.
2. *初始栈符号*: 设初始栈符号为 CFG 的开始符号 $S$.
3. *转移函数*: 对于每个产生式 $A -> a V_1 V_2 ... V_k$ (其中 $k >= 0$), 添加转移
$
  delta( q, a, A ) = ( q, V_1 V_2 ... V_k )
$
注意这里 $V_1$ 在栈顶. 由此, PDA 每次读取输入符号 $a$, 并将栈顶的变量 $A$ 替换为 $V_1 V_2 ... V_k$, 这也就模拟了 CFG 的推导过程.

=== 从 PDA 构造 CFG
我们要关注 PDA 运作时的生命周期. 想象 PDA 处于状态 $p$, 栈顶刚刚压入一个符号 $X$, 然后经过一系列状态转移, 最终弹出栈顶符号 $X$, 并停在状态 $q$. 这个过程可以被看作是从状态 $p$ 到状态 $q$ 的一个 "子计算" (Sub-computation), 它以栈符号 $X$ 的压入和弹出为边界.

在 CFG 的视角里, 这个闭环就是一个非终结符. 我们可以把这个过程命名为 $A_(p q)$, 然后通过产生式来描述这个非终结符的行为:
1. 如果机器只是简单地读了个输入符号 $a$, 然后弹出了栈顶符号 $X$. 则我们添加产生式
$
  A_(p q) -> a
$
2. 如果机器读了 $a$ 后又压入了一个新的栈符号 $Y$, 进入状态 $r$, 然后通过子计算从状态 $r$ 弹出 $Y$ 并进入状态 $s$, 最后再读入 $b$ 弹出 $X$ 并进入状态 $q$. 则我们添加产生式
$
  A_(p q) -> a A_(r s) b
$
也就是说, 无论 PDA 在压入 $X$ 和弹出 $X$ 之间经历了多少次状态转移, 我们都可以通过递归地定义这些子计算来描述整个过程.

建立了这个直觉, 我们就可以正式地构造 CFG 了:

1. *变量*: 对于 PDA 的每一对状态 $( p, q ) in Q times Q$, 创建一个变量 $A_(p q)$.
2. *终结符*: 设终结符集合为 PDA 的输入符号集合 $Sigma$.
3. *开始符号*: 设开始符号为 $A_(q_0 q_f)$, 其中 $q_0$ 是 PDA 的初始状态, $q_f$ 是 PDA 的某个接受状态.
4. *产生式*: 
  - 边界情况: $ A_(p p) -> epsilon $
  - 路径拼接: 如果从 $p$ 到 $q$ 中间进入了状态 $r$, 则添加产生式 $ A_(p q) -> A_(p r) A_(r q) $.
  - 弹入弹出: $ A_(p q) -> a A_(r s) b $


= 上下文无关语言 (CFL) 
== 定义
使用上下文无关文法 (CFG) 所生成的语言称为 *上下文无关语言* (Context-Free Language, *CFL*). 也就是说, 如果存在一个 CFG $G$ 使得 $L = L(G)$, 则称 $L$ 是一个 CFL.

== CFL 的泵引理
类似于正则语言的泵引理, 上下文无关语言 (CFL) 也有自己的泵引理. 它描述了 CFL 的一个重要性质, 即对于任何足够长的字符串, 都可以将其分解为五个部分, 并通过重复某些部分来生成新的字符串, 而这些新字符串仍然属于同一语言.

设 $L$ 是一个上下文无关语言, 则存在一个整数 $p >= 1$, 使得对于任意字符串 $s in L$ 且 $|s| >= p$, 都可以将 $s$ 分解为五个部分 $s = u v x y z$, 满足以下条件:
1. $forall i >0, u v^i x y^i z in L$
2. $|v y| >= 1$
3. $|v x y| <= p$

== CFL 的封闭性
上下文无关语言 (CFL) 在以下操作下是封闭的:
1. *并运算* (Union): 如果 $L_1$ 和 $L_2$ 是 CFL, 则 $L_1 union L_2$ 也是 CFL.
2. *连接运算* (Concatenation): 如果 $L_1$ 和 $L_2$ 是 CFL, 则 $L_1 dot.c L_2$ 也是 CFL.
3. *克林闭包* (Kleene Star): 如果 $L$ 是 CFL, 则 $L^*$ 也是 CFL.
4. *反转* (Reversal): 如果 $L$ 是 CFL, 则 $L^R = { w^R | w in L }$ 也是 CFL.

注意, CFL 在交运算 (Intersection) 和补运算 (Complementation) 下并不封闭. 但是, 对于一个 CFL $L$ 和一个正则语言 $R$, 它们的交集 $L inter R$ 仍然是 CFL.

== DPDA 及其语言
一个 PDA 被称为 *确定性下推自动机* (Deterministic Pushdown Automaton, *DPDA*), 如果对于任意状态 $q in Q$, 输入符号 $a in Sigma union { epsilon }$, 栈顶符号 $X in Gamma$, 都满足以下条件:
1. $| delta( q, a, X ) | <= 1$
2. 如果 $delta( q, epsilon, X ) != emptyset$, 则 $delta( q, a, X ) = emptyset$ 对于所有 $a in Sigma$

也就是说, DPDA 在任何时刻最多只能有一个可能的转移, 并且不能同时有空移动和非空移动的选择.

同时, 一个语言被称为 *确定性上下文无关语言* (Deterministic Context-Free Language, *DCFL*), 如果存在一个 DPDA $M$ 使得 $L = L(M)$.

需要注意的是, DPDA 的表达能力严格弱于 NPDA, 这和 DFA 和 NFA 之间的关系不同. 也就是说, 存在一些 CFL 不能被任何 DPDA 所识别. 因此, DCFL 是 CFL 的一个真子集.

== 描述 DCFL 的文法
已知 CFG 能够描述所有的 CFL, 也就能描述所有的 DCFL. 但是由于 DCFL 的特殊性, 我们希望能给 CFG 提供一些额外的约束条件, 来满足
- 这种受限的 CFG 还可以生成所有的 DCFL (或尽可能表达更多的 DCFL)
- 这种受限的 CFG 可以被更高效地解析 (@parsing)

=== 简单文法

我们之前提出过 *简单文法* (s-grammar), 它的所有产生式都满足如下形式
$
  A -> a x
$
其中 $A in V, a in T, x in V^*$ 且 $(A, a)$ 在产生式 $P$ 中至多出现一次. 这种文法在自顶向下解析时, 只要看到当前输入符号 $a$, 就能唯一确定使用哪一个产生式. 这种性质保证了解析过程是确定的、无回溯的. 但它的表达能力太弱, 无法描述大多数实际编程语言的语法结构.

=== LL($k$) 文法
LL($k$) 文法是比简单文法更强大的一类文法. 它们允许在选择产生式时, 查看接下来的 $k$ 个输入符号, 从而做出更明智的决策. 具体来说, 一个 CFG $G = ( V, T, P, S )$ 被称为 LL($k$) 文法, 如果对于任意两个最左派生序列
$
  A =>_(G^*) w A x_1 =>_G w y_1 x_1 =>_(G^*) w w_1 \
  A =>_(G^*) w A x_2 =>_G w y_2 x_2 =>_(G^*) w w_2
$
其中
- $w, w_1, w_2 in T^*$ 是终结符串
- $x_1, x_2 in ( V union T )^*$ 
- $A -> y_1, A -> y_2 in P$ 是产生式
只要 $w_1$ 和 $w_2$ 的前 $k$ 个符号相同, 则 $y_1 = y_2$. 也就是说, 在任何给定的解析状态下, 通过查看接下来的 $k$ 个输入符号, 都能唯一确定使用哪一个产生式.

LL($k$) 文法相比简单文法, 能够描述更多的语言结构, 包括一些常见的编程语言语法. 但是, 它们仍然无法描述所有的 DCFL. 这些文法的表达能力如下面的包含关系所示:
$
  "s-grammar" subset "LL"(1) subset "LL"(2) subset dots.c subset "DCFL" subset "CFL"
$

= 图灵机 (Turing Machine)