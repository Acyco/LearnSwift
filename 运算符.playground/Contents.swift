import UIKit

var greeting = "Hello, playground"

// 运算符分为一元、二元、三元
// 一元： !a , -b +c
// 二元： a+b d-c
// 三元： a?b:c

// 赋值运算符 a =b
let b = 5
var a = 3
a = b;
print(b) //5

// 算术运算符 + - * / %

// 比较运算符 == != > < >= <=
1 == 1
1 != 2
5 > 3
3 < 5
1 >= 1
5 <= 9

// 三元运算符

let contentHeight = 40
let hasHeader = true
let rowHeight = contentHeight + (hasHeader ? 50 : 20)

// 空合运算符
let defaultColorName = "red"
var userDefinedColorName: String?   //默认值为 nil

var colorNameToUse = userDefinedColorName ?? defaultColorName
// userDefinedColorName 的值为空，所以 colorNameToUse 的值为 "red"

userDefinedColorName = "green"
colorNameToUse = userDefinedColorName ?? defaultColorName
// userDefinedColorName 非空，因此 colorNameToUse 的值为 "green"

// 区间运算符
// 闭区间  eg: 1...5
// 半开区间 有g 1..<5
for i in 1...5{
    print("\(i)")
}

for i in 10..<15{
    print("\(i)")
}

let names = ["Acyco", "Alex", "Steve", "John", "Joye"]

let count = names.count;

for i in 0..<count {
    print("第\(i + 1)个人叫\(names[i])")
}

// 单侧区间
for name in names[2...]{
    print(name)
}
print("-------------------------")
for name in names[...2]{
    print(name)
}

// 逻辑运算符
// 逻辑非 !a
// 逻辑与 （a && b)
// 逻辑或。(a || b)

var tA = true;
var fA = false
!tA
!fA

tA && fA

fA || tA
