#import "@preview/showybox:2.0.4": showybox

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
  title: [Natural Language Processing],
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

= 统计学习方法
== 齐夫定律
在自然语言的大规模文本数据上统计词频时, 词频与词频排名之间存在一种特殊的数学关系, 即词频与其排名的乘积约等于一个常数. 这种现象被称为 *齐夫定律(Zipf's Law)*

$
  f times r = C
$
其中 $f$ 表示词频, $r$ 表示词频排名, $C$ 是一个常数.

== 最大熵模型 (MaxEnt)
最大熵模型是一种判别式模型 (Discriminative Model), 它直接对给定输入 $x$ 时输出 $y$ 的条件概率分布 $P(y|x)$ 进行建模. 最大熵模型的基本思想是, 在所有满足已知约束条件的概率分布中, 选择熵最大的那个分布作为模型.

熵定义了随机变量的不确定性. 当熵最大时, 随机变量最不确定. 如果没有任何先验知识, 最大熵模型导向均匀分布, 体现了对所有可能情况一视同仁, 赋予同等概率的公平、合理策略.

最大熵模型的学习过程等价于求解一个条件约束下的优化问题, 模型需要满足的约束基于训练数据中提取的 *特征函数* $f_j (x, y)$. 
$
  f_j (x, y) = cases(
    1\, quad "if" x "and" y "satisfy feature some condition",
    0\, quad "otherwise"
  )
$
然后我们考虑建立模型分布 $p(y|x)$:
$
  p_w (y | x) = 1/(Z_w (x)) exp (sum_(i = 1)^m w_i f_i (x, y))
$
由此我们构造约束条件为:
$
  EE_(tilde(p)) [f_j] = EE_(p) [f_j]  , quad forall j \
  EE_(tilde(p)) [f_j] = sum_(x, y) tilde(p)(x, y) f_j (x, y) \
  EE_(p) [f_j] = sum_(x, y) tilde(p)(x) p(y | x) f_j (x, y) 
$
这里 $tilde(p)$ 是经验分布 (训练集), $p$ 是模型分布. 这个约束条件确保模型在特征函数的期望上与训练数据一致. 模型就是要在这些约束条件下最大化熵:
$
  max H(p), quad "s.t." quad EE_(p) [f_j] = EE_(tilde(p)) [f_j] , quad forall j
$
=== 使用最大熵模型进行词汇歧义消解 (WSD)
在自然语言处理中, *词汇歧义消解 (Word Sense Disambiguation, WSD)* 是指确定一个多义词在特定上下文中所表达的确切含义的任务. 

1. *特征提取*
MaxEnt WSD 模型的准确性严重依赖于特征工程的质量, 因此需要提取与目标词义相关的各种特征, 包括但不限于:
  - 局部词语搭配: 目标词前后 1 或 2 个位置的特定词汇, 如 'drug' 后面的 'abuse'. 
  - 局部词性序列: 目标词前后 1 或 2 个位置的词性标签, 如 'drug' 前面的 'DT' (限定词).
  - 共现关键词: 在一定窗口内与目标词共现的关键词, 如 'addict', 'substance' 等.
  - 句法依赖关系: 目标词在句法树中的角色, 如主语、宾语等.

2. *模型训练*
使用一个经过人工词义标注的语料库进行有监督学习. 训练过程通过迭代算法 (如 GIS 或 IIS) 来估计每个特征的权重 $lambda_i$. 目标就是找到一组权重, 使得模型的期望和经验分布的期望尽可能接近, 同时最大化熵.

3. *预测与推断*
对于一个新的上下文, 提取相同的特征并计算每个可能词义的条件概率 $P(y|x)$. 选择概率最高的词义作为最终预测结果.

#showybox(
  title: "广义迭代定标 (GIS)",
  frame: frameSettings,
)[
  1. 将所有特征值 $lambda_i$ 设置为初始值 (通常为零). 这使得模型一开始假设所有的分类是等可能的.
  2. 在每次迭代中, 计算当前模型下每个特征函数的期望值 $EE_(p) [f_j]$. 
  3. 更新每个特征值 $lambda_j$:
  $    lambda_j = lambda_j + (1/C) log ((EE_(tilde(p)) [f_j]) / (EE_(p) [f_j])) $
  其中 $C$ 是一个常数, 通常等于每个样本中非零特征函数的最大数量.
  4. 重复步骤 2 和 3, 直到模型收敛, 即特征期望值的变化小于预设的阈值.
]
== 条件随机场及应用
*条件随机场 (Conditional Random Fields, CRF)* 是一种用于序列标注和结构预测的判别式模型. 给定观察序列 $X = (x_1, x_2, ..., x_n)$, 模型直接计算条件概率 $P(Y|X)$, 其中 $Y = (y_1, y_2, ..., y_n)$ 是对应的标注序列. 其核心在于通过链式图结构建模序列元素间的依赖关系, 使相邻标签的转移概率显式纳入计算框架.

模型的条件概率采用指数形式定义：
$
  P(Y|X) = 1/(Z(X)) exp( sum_(j=1)^m lambda_j F_j (Y, X))
$
其中 $Z(X)$ 是归一化因子，$F_j (Y, X)$ 为全局特征函数. 这些特征分为两类: 
- *状态函数* 捕捉单个位置 $(x_i, y_i)$ 的局部特征 (如当前字的词性); 
- *转移函数* 描述相邻标签 $(y_(i-1), y_i)$ 间的转移约束 (如"动词后接名词" 的语法规律). 特征权重 $lambda_j$ 通过最大化训练数据的对数似然估计获得.

与最大熵模型相比, 两者虽共享指数族分布形式, 但本质差异在于预测目标. 最大熵模型针对孤立样本预测单点标签 (如词义消解), 而 CRF 优化整条序列的联合概率. 这使 CRFs 能避免局部最优陷阱, 在分词、词性标注等任务中捕捉长距离依赖.

预测阶段需寻找全局最优标注序列 $Y^*$. *Viterbi 算法* 通过动态规划高效求解: 从序列起点递推计算每个位置各标签的最优路径得分, 最终回溯得到整体最优解. 该过程的时间复杂度为 $O(n dot.c k^2)$, $k$ 为标签集大小

在中文分词任务中, CRF 将文本视为字序列, 为每个字分配词位标签: *B* (词首), *M* (词中), *E* (词尾), *S* (单字词). 模型同时利用字形特征 (如偏旁部首)、上下文窗口 (前后字符) 及转移约束 (如"B后不可接S"), 显著提升切分准确率. 

= $N$ 元文法模型
== 模型定义: 基于 Markov 假设
*核心问题*: 对于一个由词序列 ($s = w_1, w_2, ..., w_n$) 组成的句子, 我们如何计算其出现的概率 $P(s)$? 这很重要, 我们假设一个符合语法, 语义自然的句子的出现概率应该更高:
- *机器翻译* 中, 我们希望选择最有可能的翻译结果: $P("Good Translation") > P("Bad Translation")$
- *语音识别* 中, 我们希望选择最有可能的词序列作为识别结果 (尤其针对同音词): $P("I scream at you") > P("Ice cream at you")$

一个句子的联合概率可以被分解为条件概率的乘积:
$
  P(w_1, w_2, ..., w_n) &= P(w_1) P(w_2 | w_1) \ &P(w_3 | w_1, w_2) dots.c P(w_n | w_1, w_2, ..., w_(n-1))
$

但是, 直接估计这些条件概率是不可行的, 因为数据稀疏问题使得大部分长条件概率无法从有限语料中可靠估计. 为了解决这个问题, 我们引入 *$N$ 元文法模型 (N-gram Language Model)*, 通过 *马尔可夫假设 (Markov Assumption)* 简化条件概率, 即当前词的出现只依赖于前面 $N-1$ 个词:
$
  P(w_i | w_1, w_2, ..., w_(i-1)) approx P(w_i | w_(i-N+1), ..., w_(i-1))
$
由此我们可以将句子的概率近似表示为:
$
  P(w_1, w_2, ..., w_n) approx product_(i=1)^n P(w_i | w_(i-N+1), ..., w_(i-1))
$

根据这种标准, 我们可以定义不同阶数的 $N$ 元模型:
- *一元模型 (Unigram Model, N=1)*: 假设每个词的出现独立于其他词, 即 $P(w_i | w_1, ..., w_(i-1)) = P(w_i)$. 句子概率为各词概率的乘积:
$  P(w_1, w_2, ..., w_n) = product_(i=1)^n P(w_i) $
- *二元模型 (Bigram Model, N=2)*: 假设每个词的出现只依赖于前一个词, 即 $P(w_i | w_1, ..., w_(i-1)) = P(w_i | w_(i-1))$. 句子概率为各词在前词条件下的概率乘积:
$  P(w_1, w_2, ..., w_n) = P(w_1) product_(i=2)^n P(w_i | w_(i-1)) $
- *三元模型 (Trigram Model, N=3)*: 假设每个词的出现依赖于前两个词, 即 $P(w_i | w_1, ..., w_(i-1)) = P(w_i | w_(i-2), w_(i-1))$. 句子概率为各词在前两词条件下的概率乘积:
$  P(w_1, w_2, ..., w_n) = P(w_1) P(w_2 | w_1) product_(i=3)^n P(w_i | w_(i-2), w_(i-1)) $

我们可以引入 BOS (Beginning of Sentence) 和 EOS (End of Sentence) 标记来处理句子开头和结尾的边界条件. 例如, 对于二元模型, 我们令 $w_0 = "BOS"$, $w_(n+1) = "EOS"$, 则句子概率表示为:
$
  P(w_1, w_2, ..., w_n) = product_(i=1)^(n+1) P(w_i | w_(i-1))
$

== 参数估计: 最大似然估计 (MLE)
模型参数的概率值, 可以通过其在大型训练语料库 (training corpus) 中的相对频率来估计
$
  P(w_i | w_(i-N+1), ..., w_(i-1)) = C(w_(i-N+1), ..., w_(i-1), w_i) / C(w_(i-N+1), ..., w_(i-1))
$
这里 $C(w_(i-N+1), ..., w_(i-1), w_i)$ 是在语料库中观察到的词序列 $(w_(i-N+1), ..., w_(i-1), w_i)$ 的出现次数, 而 $C(w_(i-N+1), ..., w_(i-1))$ 是前缀词序列 $(w_(i-N+1), ..., w_(i-1))$ 的出现次数.

由此我们就可以用 MLE 方法估计 $N$ 元模型的所有条件概率参数, 使得训练语料库的似然函数最大化.

== 未登录词 (Out-of-Vocabulary, OOV) 和数据稀疏问题

如果一个词序列在训练语料库中未出现, 则其计数为零, 导致条件概率估计为零. 这个是问题是灾难性的, 因为只要有一个词的条件概率为零, 整个句子的概率就为零.
$
  P(w_1, w_2, ..., w_n) = P(...) times P(...) times 0 times P(...) = 0
$
这是不可接受的, 因为测试数据中总能遇到训练数据中未见过的词序列. 

为了解决这个问题, 我们需要使用 *平滑技术 (Smoothing Techniques)* 来调整概率估计, 给未见过的词序列分配一个非零概率. 
=== 加法平滑 (Additive Smoothing) 
也称为拉普拉斯平滑 (Laplace Smoothing), 通过在所有计数上加一个小的常数 (通常为 1) 来避免零计数.
$
  P (w_i | w_(i-N+1), ..., w_(i-1)) = (C(w_(i-N+1), ..., w_(i-1), w_i) + 1) / (C(w_(i-N+1), ..., w_(i-1)) + abs(V))
$
其中 $abs(V)$ 是词汇表的大小.
=== 古德-图灵平滑 (Good-Turing Smoothing)
调整频次为 $r$ 的事件的估计频次为 $r^* = (r + 1) (N_(r+1) / N_r)$, 其中 $N_r$ 是频次为 $r$ 的事件数量.
=== 后备法 (Backoff)
高阶 $N$-gram 模型更精确但是数据稀疏问题更严重, 低阶 $N$-gram 模型更平滑但是信息量较少. 后备法结合了两者的优点

- 如果一个高阶 $N$-gram 的计数非零, 则使用其概率估计.
- 否则, 退回到低阶 $N$-gram 的概率估计, 并进行适当的归一化.
$
  P_"BO" (w_i | w_(i - 2), w_(i - 1)) = cases(
    P (w_i | w_(i - 2), w_(i - 1)) \, quad "if" "count" > 0,
    alpha  P_"BO" (w_i | w_(i - 1)) \, quad "otherwise"
  )
$

无论采用什么平滑方法, 目标都是确保所有可能的词序列都有一个合理的非零概率估计, 需要满足概率归一化条件: $sum_(w_i) P(w_i | w_(i-N+1), ..., w_(i-1)) = 1$.

