
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
  title: [理论计算机科学作业 L1.13 - L1.18],
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

#showybox(
  title: "T1",
  frame: frameSettings,
)[
  给出下列语言的最小泵长度, 并给出证明:
  + $0001^*$
  + $0^*1^*$
  + $001 union 0^*1^*$
  + $(01)^*$
  + $epsilon$
  + $1^*01^*01^*$
  + $1011$
  + $Sigma^*$
]

1. $0001^*$ 的最小泵长度为 $5$. 当 $p = 5$ 时, 选择字符串 $s = 00011$, 则取 $x = 000$, $y = 1$, $z = 1$. 对任意 $i >= 0$, 有 $x y^i z = 000 1^(i+1) in 0001^*$. 当 $p = 4$ 时, 选择字符串 $s = 0001$, 则无论如何分割字符串, 都无法满足泵引理的条件.

2. $0^*1^*$ 的最小泵长度为 $1$, 取字符串 $s = 0$ 和 $x = z = epsilon$, $y = 0$, 则对任意 $i >= 0$, 有 $x y^i z = 0^i in 0^*1^*$. 

3. 最小泵长度为 $1$, 这是 2. 的直接推论.

4. $(01)^*$ 的最小泵长度为 $2$. 取字符串 $s = 01$ 和 $x = 0$, $y = 01$, $z = epsilon$. 对任意 $i >= 0$, 有 $x y^i z = 0 (01)^i in (01)^*$. 

5. 由于泵引理要求字符串长度至少为泵长度, 即至少长度为 $1$, 而 $epsilon$ 的长度为 $0$, 因此不存在最小泵长度.

6. $1^*01^*01^*$ 的最小泵长度为 $3$. 取字符串 $s = 101$ 和 $x = 0$, $y = 1$, $z = 0$, 则对任意 $i >= 0$, 有 $x y^i z = 0 1^i 0 in 1^*01^*01^*$.

7. 不存在最小泵长度. 由于字符串 $1011$ 的长度为 $4$, 因此泵长度至少为 $5$. 取字符串 $s = 1011$, 则无论如何分割字符串, 都无法满足泵引理的条件.

8. 假设 $1 in Sigma$, 则 $Sigma^*$ 的最小泵长度为 $1$. 取字符串 $s = 1$ 和 $x = z = epsilon$, $y = 1$, 则对任意 $i >= 0$, 有 $x y^i z = 1^i in Sigma^*$.

#showybox(
  title: "T2",
  frame: frameSettings,
)[
  使用泵引理证明下列语言不是正则语言:
  1. $A_1 = {0^n 1^n 2^n | n >= 0}$
  2. $A_2 = {w w w | w in {a, b}^*}$
  3. $A_3 = {a^(2^n) | n >= 0}$
]

1. 取 $s = 012 in A_1$, 则在所有可能的分割方案中, 若 $y$ 包含 $1$ 个或者 $2$ 个字符, 则重复 $y$ 都会导致三个字符的数量不相等; 若 $y$ 包含了 $3$ 的字符即 $y = 012$, 那么显然 $y y$ 就不在 $A_1$ 中. 因此 $A_1$ 不是正则语言.

2. 如果 $A_2$ 是正则语言, 则存在一个泵长度 $p$. 现在我们取字符串 $a^p b a^p b a^p b in A_2$, 根据泵引理的要求, $|x y| <= p$, 因此 $x y$ 只能在第一个 $a^p$ 中. 现在我们可以设 $x = a^n$, $y = a^m$, 则 $z = a^(p - n - m) b a^p b a^p b$. 于是我们有
$
  x y^i z = a^n (a^m)^i a^(p - n - m) b a^p b a^p b = a^(p + (i - 1) m) b a^p b a^p b
$
我们取 $i = 2$, 则 $x y^2 z = a^(p + m) b a^p b a^p b$, 显然 $x y^2 z in.not A_2$. 因此 $A_2$ 不是正则语言.

3. 如果 $A_3$ 是正则语言, 设泵长度 $p>= 1$, 则一定存在 $k in NN$ 使得 $2^k <= p < 2^(k + 1)$. 我们取语言 $s = a^(2^(k + 1)) in A_3$. 由于 $|x y| <= p$, 我们设 $x = a^m$, $y = a^n$, 则 $z = a^(2^(k + 1) - m - n)$, 其中 $n >= 1$ 且 $m + n <= p$, 于是我们有
$
  x y^i z = a^m (a^n)^i a^(2^(k + 1) - m - n) = a^(2^(k + 1) + (i - 1) n)
$
这里 $1 <= n <= p < 2^(k + 1)$. 所以我们取 $i = 2$, 则有 $2^(k + 1) < 2^(k + 1) + n < 2^(k + 2)$, 因此 $x y^2 z in.not A_3$. 因此 $A_3$ 不是正则语言.

#showybox(
  title: "T3",
  frame: frameSettings,
)[
  考察语言
  $
    F = {a^i b^j c^k | i, j, k >= 0 "and if" i = 1 "then" j = k}
  $
  1. 证明 $F$ 不是正则语言.
  2. 对一个给定的整数 $p >= 1$, 说明 $F$ 满足泵引理的条件.
  3. 说明为什么 2. 并不与 1. 矛盾.
]

1. 设 $R = {a b^j c^k}$ 是正则语言 (因为它可以被正则表达式 $a b^* c^*$ 描述). 由于正则语言在交运算下封闭, 则 $F inter R = {a b^n c^n | n >= 0}$ 也是正则语言. 但是根据泵引理, $ {a b^n c^n | n >= 0}$ 不是正则语言, 因此 $F$ 不是正则语言.

2. 我们声明 $p = 3$. 对任意字符串 $s in F$ 且 $|s| >= p$, 我们可以分以下几种情况讨论:
- 情况 1: $s$ 不包含字符 $a$. 则 $s$ 的形式为 $b^j c^k$. 如果 $j = 0$, 则取 $x = epsilon$, $y = b$, $z = b^(j - 1) c^k$; 如果 $j > 0$, 则取 $x = b^(j - 1)$, $y = b$, $z = c^k$. 对任意 $i >= 0$, 有 $x y^i z = b^(j - 1 + i) c^k in F$.
- 情况 2: $s$ 包含字符 $a$, 直接取 $x = epsilon$, $y = a$, $z = b^j c^k$. 对任意 $i >= 0$, 有 $x y^i z in F$.
所以, 对任意字符串 $s in F$ 且 $|s| >= p$, 都存在分割 $s = x y z$ 满足泵引理的条件.

3. 泵引理给出的条件是正则语言的必要条件, 但不是充分条件. 也就是说, 如果一个语言是正则语言, 则它一定满足泵引理的条件; 但是, 如果一个语言满足泵引理的条件, 并不意味着它一定是正则语言. 因此 2. 并不与 1. 矛盾.

#showybox(
  title: "T4",
  frame: frameSettings,
)[
  $L = {1^p | p "is prime"}$. 证明 $L$ 不是正则语言.
]

假设 $L$ 是正则语言, 则存在一个泵长度 $q$, 取字符串 $s = 1^p in L$, 其中 $p$ 是大于 $q$ 的最小素数. 我们设 $x = 1^m$, $y = 1^n$, $z = 1^(p - m - n)$, 其中 $m + n <= q$ 且 $n >= 1$. 于是我们有
$
  x y^i z = 1^m (1^n)^i 1^(p - m - n) = 1^(p + (i - 1) n)
$
如果要满足泵引理的条件, 则对任意 $i >= 0$, 都存在 $n$ 使得 $p + (i - 1) n$ 是素数. 现在我们取 $i = p + 1$, 则有
$
  x y^(p + 1) z = 1^(p + p n) = 1^(p (n + 1))
$
由于 $n >= 1$, 则 $n + 1 >= 2$, 因此 $p (n + 1)$ 不是素数, 即 $x y^(p + 1) z in.not L$. 这与泵引理的条件矛盾. 因此 $L$ 不是正则语言.

#showybox(
  title: "T5",
  frame: frameSettings,
)[
  极小化如下 DFA
  #align(center)[
    #automaton(
      (
        A: (B: "a", C: "b"),
        B: (B: "a", D: "b"),
        C: (B: "a", C: "b"),
        D: (B: "a", E: "b"),
        E: (B: "a", C: "b"),
      ),
      initial: "A",
      final: ("E",),
      layout: finite.layout.custom.with(positions:(
        A: (0, 0),
        B: (3, 0),
        C: (3, 3),
        D: (6, 0),
        E: (10, 3),
      ))
    )
  ]
]

1. 划分 $0$-等价类: ${A, B, C, D}$, ${E}$.

2. 划分 $1$-等价类
  - 在输入 a 后, ${A, B, C, D}$ 都不会转移到接受类
  - 在输入 b 后, ${A, B, C}$ 都不会转移到接受类, 但 $D$ 会转移到接受类
  因此划分为: ${A, B, C}$, ${D}$, ${E}$.

3. 划分 $2$-等价类
  - 在输入 aa 或者 ba 后, ${A, B, C}$ 都不会转移到接受类
  - 在输入 ab 后, ${A, B, C}$ 都不会转移到接受类
  - 在输入 bb 后, ${A, C}$ 都不会转移到接受类, 但 $B$ 会转移到接受类
  因此划分为: ${A, C}$, ${B}$, ${D}$, ${E}$.

4. 划分 $3$-等价类
  - $A, C$ 无法区分

所以极小化后的 DFA 如下:
#align(center)[
  #automaton(
    (
      AC: (B: "a", AC: "b"),
      B: (B: "a", D: "b"),
      D: (B: "a", E: "b"),
      E: (B: "a", AC: "b"),
    ),
    initial: "AC",
    final: ("E",),
    layout: finite.layout.custom.with(positions:(
      AC: (0, 0),
      B: (3, 0), 
      D: (6, 0),
      E: (3, -3),
    ))
  )
]

#showybox(
  title: "T6",
  frame: frameSettings,
)[
  极小化如下 DFA
  #align(center)[
    #automaton(
      (
        Q0: (Q1: "0", Q2: "1"),
        Q1: (Q3: "0", Q4: "1"),
        Q2: (Q4: "0", Q3: "1"),
        Q3: (Q5: "0,1"),
        Q4: (Q5: "0,1"),
        Q5: (Q5: "0,1"),
      ),
      initial: "Q0",
      final: ("Q1", "Q2", "Q5"),
      layout: finite.layout.custom.with(positions:(
        Q0: (0, 0),
        Q1: (3, 3),
        Q2: (3, -3),
        Q3: (6, 3),
        Q4: (6, -3),
        Q5: (9, 0),
      ))
    )
  ]
]

1. 划分 $0$-等价类: ${Q_0, Q_3, Q_4}$, ${Q_1, Q_2, Q_5}$.

2. 划分 $1$-等价类
  - 在输入 0 后, ${Q_0, Q_3, Q_4}$ 都会转移到接受类, ${Q_1, Q_2}$ 都会转移到非接受类, 但 $Q_5$ 会转移到接受类;
  - 在输入 1 后, ${Q_0, Q_3, Q_4}$ 都会转移到接受类, ${Q_1, Q_2}$ 都会转移到非接受类, 但 $Q_5$ 会转移到接受类.
  因此划分为: ${Q_0, Q_3, Q_4}$, ${Q_1, Q_2}$, ${Q_5}$.

3. 划分 $2$-等价类
  - 先考虑划分 ${Q_0, Q_3, Q_4}$:
    - 在输入 00 后, ${Q_0}$ 会转移到非接受类, ${Q_3, Q_4}$ 都会转移到接受类;
    - 但是 ${Q_3, Q_4}$ 始终无法区分.
  - 再考虑划分 ${Q_1, Q_2}$:
    - 也始终无法区分.
  因此划分为: ${Q_0}$, ${Q_3, Q_4}$, ${Q_1, Q_2}$, ${Q_5}$

所以极小化后的 DFA 如下:
#align(center)[
  #automaton(
    (
      Q0: (Q12: "0,1"),
      Q12: (Q34: "0,1"),
      Q34: (Q5: "0,1"),
      Q5: (Q5: "0,1"),
    ),
    initial: "Q0",
    final: ("Q12", "Q5"),
    layout: finite.layout.custom.with(positions:(
      Q0: (0, 0),
      Q12: (3, 0),
      Q34: (6, 0),
      Q5: (9, 0),
    ))
  )
]


#showybox(
  title: "T7",
  frame: frameSettings,
)[
  利用 Myhill-Nerode 定理证明:
  1. $A_1 = {0^n 1^n 2^n | n >= 0}$ 不是正则的
  2. $A_2 = {w w w | w in {a, b}^*}$ 不是正则的
  3. $A_3 = {a^(2^n) | n >= 0}$  (这里 $a^(2^n)$ 表示 $2^n$ 个 $a$ 构成的串) 不是正则的
  4. 设 $Sigma = {0, 1}$: 
    - 若 $A = {0^k u 0^k | k >= 1 "and" u in Sigma^*}$, 证明: $A$ 是正则的;
    - 若 $B = {0^k 1 u 0^k | k >= 1 "and" u in Sigma^*}$, 证明: $B$ 不是正则的.
]

1. Myhill-Nerode 定理指出, 如果一个语言是正则的, 则它的等价类数量是有限的. 现在我们考虑字符串 $0^n$ 和 $0^m$, 其中 $n != m$. 我们可以选择字符串 $1^n 2^n$, 则有
$
  0^n 1^n 2^n in A_1, quad 0^m 1^n 2^n in.not A_1
$
因此 $0^n$ 和 $0^m$ 属于不同的等价类. 由于 $n, m$ 可以是任意非负整数, 因此存在无限多个等价类. 所以根据 Myhill-Nerode 定理, $A_1$ 不是正则的.

2. 考虑任意字符串 $a^n b$ 和 $a^m b$, 其中 $n != m$. 我们选择字符串 $a^n b a^n b$, 则有 $a^n b a^n b a^n b in A_2$. 分析 $L_m = a^m b a^n b a^n b$, 如果 $L_m in A_2$, 则设 $L_m = w w w$, 其中 $w$ 有且只能有一个 $b$, 所以我们可以设 $w = a^k b a^l$, 则有
$
  a^m b a^n b a^n b = (a^k b a^l) (a^k b a^l) (a^k b a^l) = a^k b a^(l + k) b a^(l + k) b a^l
$
这说明 $m = k$, $n = l + k$, $n = l + k$, $0 = l$. 但是 $l = 0$ 意味着 $n = k = m$, 这和 $n != m$ 矛盾. 因此 $L_m in.not A_2$. 所以 $a^n b$ 和 $a^m b$ 属于不同的等价类. 由于 $n, m$ 可以是任意非负整数, 因此存在无限多个等价类. 所以根据 Myhill-Nerode 定理, $A_2$ 不是正则的.

3. 设 $s_k = a^(2^k)$, 我们证明对于任意 $0 <= i < j$, $s_i$ 和 $s_j$ 属于不同的等价类. 我们选择字符串 $a^(2^j - 2^i)$, 则有
$
  s_i a^(2^j - 2^i) = a^(2^i) a^(2^j - 2^i) = a^(2^j) in A_3, \ s_j a^(2^j - 2^i) = a^(2^j) a^(2^j - 2^i) = a^(2^(j + 1) - 2^i) in.not A_3
$
因此 $s_i$ 和 $s_j$ 属于不同的等价类. 由于 $i, j$ 可以是任意非负整数, 因此存在无限多个等价类. 所以根据 Myhill-Nerode 定理, $A_3$ 不是正则的.

4. 这里 $A$ 的定义中的 $k$ 是冗余的, 我们可以证明 $A = {0 u 0 | u in Sigma^*}$. 显然 $0 u 0$ 都可以被写成 $0^k u 0^k$ 的形式, 其中 $k = 1$. 反过来, 对任意 $0^k u 0^k in A$, 由于 $k >= 1$, 则可以写成 $0 u' 0$ 的形式, 其中 $u' = 0^(k - 1) u 0^(k - 1) in Sigma^*$. 因此 $A$ 是正则的, 因为它可以被正则表达式 $0 (0 + 1)^* 0$ 描述; 而对于 $B$, 我们考虑任意字符串 $0^n 1$ 和 $0^m 1$, 其中 $n < m$. 我们选择字符串 $0^n$, 则有 $0^n 1 0^n in B$. 分析 $L_m = 0^m 1 0^n$, 如果 $L_m in B$, 则设 $L_m = 0^k 1 u 0^k$, 其中 $k >= 1$ 且 $u in Sigma^*$. $0^m 1 0^n$ 中的第一个字符 $1$ 之前有 $m$ 个 $0$, 而在 $0^k 1 u 0^k$ 中, 第一个字符 $1$ 之前有 $k$ 个 $0$, 因此 $k = m$. 这个时候就有 $|0^k 1 u 0^k| >= 2k + 1 = 2m + 1 > 2n + 1 = |0^m 1 0^n|$, 这和 $L_m = 0^m 1 0^n$ 矛盾. 因此 $L_m in.not B$. 所以 $0^n 1$ 和 $0^m 1$ 属于不同的等价类. 根据 Myhill-Nerode 定理, $B$ 不是正则的.


#showybox(
  title: "T8",
  frame: frameSettings,
)[
  使用填表法极小化如下 DFA
  #align(center)[
    #automaton(
      (
        A: (B: "a", C: "b"),
        B: (B: "a", D: "b"),
        C: (B: "a", C: "b"),
        D: (B: "a", E: "b"),
        E: (B: "a", C: "b"),
      ),
      initial: "A",
      final: ("E",),
      layout: finite.layout.custom.with(positions:(
        A: (0, 0),
        B: (3, 0),
        C: (3, 3),
        D: (6, 0),
        E: (10, 3),
      ))
    )
  ]
]

#align(center)[
  #table(
    columns: (auto, auto, auto, auto, auto, auto),
    inset: 10pt,
    align: horizon,
    " ", "A", "B", "C", "D", "E",
    "A", "", "", "", "", "",
    "B", text("X", red), "", "", "", "",
    "C", "", text("X", red), "", "", "",
    "D", text("X", green), text("X", green), text("X", green), "", "",
    "E", text("X", purple), text("X", purple), text("X", purple), text("X", purple), "",
  )
]

填表顺序通过颜色区分: #text("紫色", purple) > #text("绿色", green) > #text("红色", red). 最小化结果已经在 T5 中给出.

#showybox(
  title: "T9",
  frame: frameSettings,
)[
  使用填表法极小化如下 DFA
  #align(center)[
    #automaton(
      (
        Q0: (Q1: "0", Q2: "1"),
        Q1: (Q3: "0", Q4: "1"),
        Q2: (Q4: "0", Q3: "1"),
        Q3: (Q5: "0,1"),
        Q4: (Q5: "0,1"),
        Q5: (Q5: "0,1"),
      ),
      initial: "Q0",
      final: ("Q1", "Q2", "Q5"),
      layout: finite.layout.custom.with(positions:(
        Q0: (0, 0),
        Q1: (3, 3),
        Q2: (3, -3),
        Q3: (6, 3),
        Q4: (6, -3),
        Q5: (9, 0),
      ))
    )
  ]
]


#align(center)[
  #table(
    columns: (auto, auto, auto, auto, auto, auto, auto),
    inset: 10pt,
    align: horizon,
    " ", $Q_0$, $Q_1$, $Q_2$, $Q_3$, $Q_4$, $Q_5$,
    $Q_0$, "", "", "", "", "", "",  
    $Q_1$, text("X", purple), "", "", "", "", "",
    $Q_2$, text("X", purple), "", "", "", "", "",
    $Q_3$, text("X", red), text("X", purple), text("X", purple), "", "", "",
    $Q_4$, text("X", red), text("X", purple), text("X", purple), "", "", "",
    $Q_5$, text("X", purple), text("X", green), text("X", green), text("X", purple), text("X", purple), "",
  )
]

填表顺序通过颜色区分: #text("绿色", green) > #text("紫色", purple) > #text("红色", red). 最小化结果已经在 T6 中给出.


#showybox(
  title: "T10",
  frame: frameSettings,
)[
  判断如下两个 DFA 是否等价
  #align(center)[
    #automaton(
      (
        A: (B: "a", C: "b"),
        B: (B: "a", D: "b"),
        C: (B: "a", C: "b"),
        D: (B: "a", E: "b"),
        E: (B: "a", C: "b"),
      ),
      initial: "A",
      final: ("E",),
      layout: finite.layout.custom.with(positions:(
        A: (0, 0),
        B: (3, 0),
        C: (3, 3),
        D: (6, 0),
        E: (10, 3),
      ))
    )
  ],

  #align(center)[
    #automaton(
      (
        AC: (B: "a", AC: "b"),
        B: (B: "a", D: "b"),
        D: (B: "a", E: "b"),
        E: (B: "a", AC: "b"),
      ),
      initial: "AC",
      final: ("E",),
      layout: finite.layout.custom.with(positions:(
        AC: (0, 0),
        B: (3, 0), 
        D: (6, 0),
        E: (3, -3),
      ))
    )
  ]
]

显然是等价的, 因为第二个 DFA 是第一个 DFA 的极小化结果.