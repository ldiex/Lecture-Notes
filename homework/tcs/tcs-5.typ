
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