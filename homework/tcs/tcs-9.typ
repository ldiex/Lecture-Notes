
#import "@preview/showybox:2.0.4": showybox
#import "@preview/equate:0.3.2": equate
#import "@preview/ilm:1.4.1": *
#import "@preview/finite:0.5.0": automaton
#import "@preview/finite:0.5.0"
#import "@preview/tdtr:0.3.0" : *

#set text(font:("Libertinus Serif", "Source Han Serif SC"))

#show heading.where(level: 1): set text(navy.lighten(0%))
#show heading.where(level: 2): set text(navy.lighten(20%))
#show heading.where(level: 3): set text(navy.lighten(40%))

#show ref: it => {
  text(purple, it)
}

#show: ilm.with(
  title: [理论计算机科学作业 L2.12 - L2.13],
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

#let colMath(x, color) = text(fill: color)[$#x$]

#let prob(title, body) = showybox(
  title: title,
  frame: frameSettings, 
  body
)

#prob(
  "T1"
)[
  构造 PDA 接受由文法
  $
    S -> a S b b | a a b
  $
  产生的语言
]

我们构造一个 PDA, 其只有一个状态 $q$, 输入符号为 ${a, b}$, 栈符号为 ${a, b, S}$, 初始栈符号为 $S$. 转移函数定义如下:
- $delta(q, epsilon, S) = {(q, a S b b), (q, a a b)}$
- $delta(q, a, a) = {(q, epsilon)}$
- $delta(q, b, b) = {(q, epsilon)}$

#prob(
  "T2"
)[
  构造 PDA 接受由文法
  $
    S -> a S S S | a b
  $
  产生的语言
]

同理, 可以构造一个 PDA, 其只有一个状态 $q$, 输入符号为 ${a, b}$, 栈符号为 ${a, b, S}$, 初始栈符号为 $S$. 转移函数定义如下:
- $delta(q, epsilon, S) = {(q, a S S S), (q, a b)}$
- $delta(q, a, a) = {(q, epsilon)}$
- $delta(q, b, b) = {(q, epsilon)}$


#prob(
  "T3"
)[
  构造 PDA 接受由文法
  $
    S -> a A B B | a A A \
    A -> a B B | a \
    B -> b B B | A
  $
  产生的语言
]

同理构造一个 PDA, 其只有一个状态 $q$, 输入符号为 ${a, b}$, 栈符号为 ${a, b, S, A, B}$, 初始栈符号为 $S$. 转移函数定义如下:
- $delta(q, epsilon, S) = {(q, a A B B), (q, a A A)}$
- $delta(q, epsilon, A) = {(q, a B B), (q, a)}$
- $delta(q, epsilon, B) = {(q, b B B), (q, A)}$
- $delta(q, a, a) = {(q, epsilon)}$
- $delta(q, b, b) = {(q, epsilon)}$


#prob(
  "T4"
)[
  构造 PDA 接受由文法
  $
    S -> A A | a \
    A -> S A | b
  $
  产生的语言
]

同理构造一个 PDA, 其只有一个状态 $q$, 输入符号为 ${a, b}$, 栈符号为 ${a, b, S, A}$, 初始栈符号为 $S$. 转移函数定义如下:
- $delta(q, epsilon, S) = {(q, A A), (q, a)}$
- $delta(q, epsilon, A) = {(q, S A), (q, b)}$
- $delta(q, a, a) = {(q, epsilon)}$
- $delta(q, b, b) = {(q, epsilon)}$

