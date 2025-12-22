#import "@preview/showybox:2.0.4": showybox

#import "@preview/ilm:1.4.1": *
#import "@preview/finite:0.5.0": automaton
#import "@preview/finite:0.5.0"

#set text(font: ("Libertinus Serif", "Source Han Serif SC"))

#show heading.where(level: 1): set text(navy.lighten(0%))
#show heading.where(level: 2): set text(navy.lighten(20%))
#show heading.where(level: 3): set text(navy.lighten(40%))

#show ref: it => {
  text(purple, it)
}

#show: ilm.with(
  title: [Complex 作业1],
  date: datetime.today(),
  author: "潘天麟 2023K8009908023",
  table-of-contents: none,
)

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
#let argmin(x) = $limits(op("argmin"))_#x$

#let prob(title, body) = showybox(
  title: title,
  frame: frameSettings,
  body,
)

由于 $Q$ 和 $R$ 都是单位矩阵, 所以优化目标可以写成
$
  L(x, u) = 1/2 (x_1^2 + x_2^2) + 1/2 (u_1^2 + u_2^2)
$
对应的约束条件可以写成
$
  x_1 + 2u_1 + 1 = 0, quad x_2 + u_2 + 2 = 0
$
由此可以解出
$
  x_1 = -2u_1 - 1, quad x_2 = -u_2 - 2
$
代入原优化目标, 可得
$
  L(u) = 1/2 (5u_1^2 + 4u_1 + 2u_2^2 + 4u_2 + 5)
$
分别对 $u_1$ 和 $u_2$ 求导并令导数为零, 可得
$
  10 u_1 + 4 = 0 ==> u_1 = -2/5 \
  4 u_2 + 4 = 0 ==> u_2 = -1
$
对应的 $x_1 = -1/5, x_2 = -1$. 代入原优化目标, 可得最小值为
$
L(x, u) = 1/2 ((-1/5)^2 + (-1)^2) + 1/2 ((-2/5)^2 + (-1)^2) = 1.1
$