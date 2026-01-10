
#import "@preview/showybox:2.0.4": showybox
#import "@preview/equate:0.3.2": equate
#import "@preview/ilm:1.4.1": *
#import "@preview/finite:0.5.0": automaton
#import "@preview/finite:0.5.0"
#import "@preview/tdtr:0.3.0": *
#import "@preview/physica:0.9.7": *

#set text(font: ("Libertinus Serif", "Source Han Serif SC"))

#show heading.where(level: 1): set text(navy.lighten(0%))
#show heading.where(level: 2): set text(navy.lighten(20%))
#show heading.where(level: 3): set text(navy.lighten(40%))

#show ref: it => {
  text(purple, it)
}

#show: ilm.with(
  title: [理论计算机科学作业 L3.8 - L3.11],
  date: datetime.today(),
  author: "潘天麟 2023K8009908023",
  table-of-contents: none,
)

#show: equate.with(breakable: true, sub-numbering: true)
#set math.equation(numbering: "(1.1)")

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

#let colMath(x, color) = text(fill: color)[$#x$]
#let apair(..args) = {
  if args.pos().len() == 1 {
    let x = args.pos().at(0, default: none)
    $chevron.l #x chevron.r$
  } else {
    let x = args.pos().at(0, default: none)
    let y = args.pos().at(1, default: none)
    $chevron.l #x, #y chevron.r$
  }
}

#let prob(title, body) = showybox(
  title: title,
  frame: frameSettings,
  body,
)

#prob(
  "T1",
)[
  1. 设 $E_"TM" = {apair(M) | M "is TM and" L(M) = emptyset}$. 证明 $E_"TM"$ 的补 $overline(E_"TM")$ 是图灵可识别的.
  2. 设 $A = {apair(R, S) | R, S "are REX and" L(R) subset.eq L(S)}$. 证明 $A$ 是可判定的.
  3. 设 $A = {apair(M) | M "is DFA and" forall w in L(M), N_1 (w) mod 2 = 0}$. 证明 $A$ 是可判定的.
]

*1.* 为了防止图灵机陷入无限循环, 我们借用 IDA 搜索算法的思想.

构造图灵机 $M'$ 识别 $overline(E_"TM")$, 对于给定的输入 $apair(M)$:

#[
  #set enum(numbering: "a)")
  + 遍历 $i = 1, 2, 3, ...$
  + 生成长度 *最多* 为 $i$ 的所有可能字符串的列表 ${s_1, s_2, ..., s_k}$
  + 对于列表中的每一个字符串 $s_j$, 用 $M$ 模拟它, 但在 $i$ 步之后停止模拟
  + 如果在上述任何模拟步骤中, $M$ 接受了某个字符串 $s_j$, 则 $M'$ 接受并停机
  + 如果没有发现接受状态, 则继续下一个 $i$
]

对于任意的 TM $M$ 满足 $L(M) != emptyset$, $M'$ 能在有限时间内接受 $apair(M)$, 因此 $overline(E_"TM")$ 是图灵可识别的.

*2.*
因为
#[
  #set enum(numbering: "a)")
  + $L(R) subset.eq L(S) <==> L(R) inter overline(L(S)) = emptyset$
  + 把 REX 转化为一个等价的 DFA 是算法可行的
  + 已知一个 DFA, 构造一个识别其语言的补集的 DFA 也是算法可行的
  + 已知两个 DFA $M_1, M_2$, 构造一个识别 $L(M_1) inter L(M_2)$ 的新 DFA 也是算法可行的
  + DFA 空集问题 $E_"DFA"$ 是可判定的
]

综上, $A$ 是可判定的.

*3.*
设 $L_"odd"= {w in Sigma^* | N_1(w) mod 2 = 1}$. 那么 $A$ 等价于判定 $L(M) inter L_"odd" = emptyset$.

考虑到容易构造一个 DFA $M'$ 使得 $L(M') = L_"odd"$, $A$ 等价于判定 $L(M) inter L(M') = emptyset$, 这显然是可以实现的. 因此 $A$ 是可判定的.


#prob(
  "T2",
)[
  1. 设 $T = {apair(M) | M "is TM and" forall w in L(M), w^R in L(M)}$. 证明 $T$ 是不可判定的.
  2. 考虑这样的问题: 一个双带图灵机, 当它在输入 $w$ 上运行时, 检查它是否在第二条带子上写下一个非空白符. 将这个问题形式化为一个语言, 证明它是不可判定的
  3. 考虑这样的问题: 一个双带图灵机, 检查在计算任意输入串的过程中它是否在第二条带子上写下一个非空白符. 将这个问题形式化为一个语言, 并证明它是不可判定的.
]

*1.* 假设这个问题是可判定的, 那么我们根据 $apair(M, w)$ 构造如下图灵机 $M'$ 来判断 $A_"TM"$ 问题.
#[
  #set enum(numbering: "a)")
  + 如果输入 $x = "01"$, 则接受它
  + 否则, 在 $M$ 上运行 $w$, 如果 $M$ 接受 $w$, 则 $M'$ 直接接受输入的 $x$ (不管其内容), 否则 $M'$ 拒绝 $x$
]
那么, 如果 $M$ 接受 $w$ 那么 $L(M') = Sigma^*$, 它必然是对称的; 否则 $L(M') = "01"$, 它显然是不对称的. 如果我们存在一个题设的图灵机能判断一个图灵机接受的语言是否是对称的, 我们就可以用 $M'$ 来解决 $A_"TM"$ 问题. 但是因为 $A_"TM"$ 是不可判定的, 所以假设错误, $T$ 是不可判定的.

*2.* 假设这个问题是可判定的, 那么我们可以构造出如下一个图灵机 $M'$ 来判定 $A_"TM"$ 问题:

#[
  #set enum(numbering: "a)")
  + $M'$ 是一个双带图灵机, 它的第一条带完全模拟单带图灵机 $M$ 的操作
  + $M'$ 在 $M$ 进入接受状态时, 在第二条带子上写下一个非空白符
  + 根据假设条件, $M'$ 是否在第二条带子上写下非空白符是可判定的, 那么 $M$ 是否接受 $w$ 也是可判定的
]
但是已知 $A_"TM"$ 是不可判定的, 因此假设错误, $T$ 是不可判定的.

*3.* 因为 3. 比 2. 更强, 如果 3. 是可判定的, 那么 2. 肯定也是可判定的. 所以 3. 也是不可判定的.

#prob(
  "T3",
)[
  证明 $E Q_"CFG"$ 是不可判定的
]

已知 $"ALL"_"CFG"$ 是不可判定的. 假设 $E Q_"CFG"$ 是可判定的, 我们可以手动构造一个语法 $G'$ 使得 $L(G') = Sigma^*$ (这很容易构造), 那么我们就可以通过判断 $G$ 和 $G'$ 是否等价来解决 $"ALL"_"CFG"$ 的判定. 这和假设矛盾, 所以 $E Q_"CFG"$ 是不可判定的.

#prob(
  "T4",
)[
  1. 请找出如下波斯特问题实例中的一个匹配:
  $
    {[(a b)/(a b a b)], [b / a], [(a b a) / a], [(a a) / a]}
  $
  2. 证明波斯特对应问题 $P$ 在一元字母表 $Sigma = {1}$ 上是可判定的
  3. 证明波斯特对应问题 $P$ 在二元字母表 $Sigma = {0, 1}$ 上是不可判定的
]

*1.* 选择 $[(a b)/(a b a b)]$ 和 $[(a b a) / a]$ 就可以. 这样上下两面都是 $a b a b a$.

*2.* 设骨牌集合为 $(x_1, y_1), ..., (x_n, y_n)$. 由于字母表只有 ${1}$, 我们只关心每个骨牌上下字符串的长度差. 定义 $d_i = |x_i| - |y_i|$.

PCP 问题是否有解, 等价于是否存在非负整数 $c_1, ..., c_n$ (代表每个骨牌被选中的次数, 且 $sum c_i > 0$), 使得
$
  sum c_i abs(x_i) = sum c_i abs(y_i) <==> sum c_i d_i = 0
$
我们可以用如下方法判断这个方程是否存在解:
#[
  #set enum(numbering: "a)")
  + 如果存在某个骨牌 $k$ 使得 $d_k = 0$, 那么直接选择该骨牌一次即可构成匹配
  + 如果存在两个骨牌 $i$ 和 $j$，使得 $d_i > 0$ 且 $d_j < 0$, 我们可以构造 $ |d_j| times d_i + |d_i| times d_j = 0 $
  + 如果存在两个骨牌 $i$ 和 $j$, 使得 $d_i > 0$ 且 $d_j < 0$, 那么就不可能有解.
]

*3.* 已知在任意有限字母表 $Gamma$ 上的 PCP 问题是不可判定的. 考虑到我们可以将 $Gamma$ 中的每个字符编码为 $Sigma = 0, 1$ 上的二进制字符串 (如使用 Huffman 等前缀码), 那么 $Gamma$ 上的 PCP 问题等价于 $Sigma$ 上的 PCP 问题, 因此 $Sigma$ 上的 PCP 问题是不可判定的.
