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
- ${w | w "has even number of 0's" or w "has exact two 1's"}$, 6 个状态