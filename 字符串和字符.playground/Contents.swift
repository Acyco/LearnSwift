import UIKit

//单行

var hello = "Hello, playground"

// 多行
let qoutation = """
Acyco
hello world!
swift
"""

print(qoutation)

let singleLineString = "These are the same."
let multiLineString = """
These are the same.
"""
print(singleLineString)
print(multiLineString)

//续行符
let softWrappedQoutation = """
Hello \
World!\
Acyco.
"""
print(softWrappedQoutation)

//特殊字符
/*
 \0 空字符
 \\ 反斜线
 \t 制表符
 \n 换行符
 \r 回车符
 \" 双引号
 \' 单引号
 */

let wiseWords = "\"Imaginatioin is more important than Knowledge\" - Enistein"
print(wiseWords)

// Unicode标量，写成 \u{n} u要小写 n：一到八位十六进制且可用的Unicode位码

let dollarSign = "\u{24}"
print(dollarSign) // $
let blackHeart = "\u{2665}"
print(blackHeart) // ♥
let sparkingHeart = "\u{1F496}"
print(sparkingHeart) // 💖

// 由于多行是使用“”“ 里面的”不用这样（\"） 直接用双引号 但要在里面使用“”“  则要 \""" 我看的5.1教程 但在swift5.6好像不能这样了 具体情况再分析，而且也很少用到这种写法

//let threeDoubleQuotes = """
//Escaping the first quote \"""
//Escaping all three quotes \"\"\"
//"""
//print(threedoubleQoutes)

//扩展字符串分隔符
let threeMoreDoubleQuotationMarks = #"""
Here are three more double quotes: """
"""#
print(threeMoreDoubleQuotationMarks) //Here are three more double quotes: """

// 初始化空字符串
var emptyString = ""
var anotherEmptyString = String()


// 字符串可变性

var varibleString = "Horse"
varibleString += " and carriage"
print(varibleString) //Horse and carriage

// 但常量字符串是不可以被修改的

//遍历
for character in "Dog!🐶"{
    print(character)
}

let catCharacters: [Character] = ["C","a","t", "!" ,"🐱"]
let catStirng = String(catCharacters)
print(catStirng) // Cat!🐱

//连接字符串和字符
// 使用+ 连接
let string1 = "Hello"
let string2 = " there"
var welcome = string1 + string2
print(welcome)
//使用 +=
var instruction = "look over"
instruction += string2
print(instruction)
// append()
let exclamtionMark: Character = "!"
welcome.append(exclamtionMark)
print(welcome)

//PS: 不能将一个字符或字符串添加到一个字符串常量上

// 字符串插值
let multiplier = 3
let message = "\(multiplier) times 2.5 is \(Double(multiplier) * 2.5)"
print(message) // 3 times 2.5 is 7.5

// 计算字符数量
let unusualMenagerie = "Koala 🐨, Snail 🐌, Penguin 🐧, Dromedary 🐪"
print("unusualMenagerie has \(unusualMenagerie.count) characters") // unusualMenagerie has 40 characters

// 字符串索引

let greeting = "Guten Tag!"
greeting[greeting.startIndex]  // G
greeting[greeting.index(before: greeting.endIndex)] // !
greeting[greeting.index(after: greeting.startIndex)] // u

let index = greeting.index(greeting.startIndex, offsetBy: 7)
greeting[index] // a

//ps: 不能越界 error

// 插入和删除
var welcome2 = "Hello"
welcome2.insert("!", at: welcome2.endIndex) //插入 在尾部插入！
print(welcome2) // Hello!
welcome2.insert(contentsOf: " there", at: welcome2.index(before: welcome2.endIndex))
print(welcome2) // Hello there!

welcome2.remove(at: welcome2.index(before: welcome2.endIndex))
print(welcome2)  // hello there

let range = welcome2.index(welcome2.endIndex,offsetBy: -6)..<welcome2.endIndex
welcome2.removeSubrange(range)
print(welcome2) // hello

// 子字符串
// 当要在短时间内操作可以用子字符串来操作， 但要长期保存结果还是要转化为String
let greeting2 = "Hello, World!"
let index2 = greeting2.firstIndex(of: ",") ?? greeting2.endIndex
let beginning = greeting2[..<index2] // Hello

let newString = String(beginning) // SubString 转化 String
print(newString)
//SubString 是在原来的String的内存空间操作 并不适合长期保存。应转化为String重新生成新的字符串以长期保存

// 比较字符串
//可用 == 或 != 来比较两个字符串是否相等
let quotation = "We're a lot alike, you and I."
let sameQuotation = "We're a lot alike, you and I."
if quotation == sameQuotation {
    print("These two strings are considered equal")
}

// 前后缀相等

let romeoAndJuliet = [
    "Act 1 Scene 1: Verona, A public place",
    "Act 1 Scene 2: Capulet's mansion",
    "Act 1 Scene 3: A room in Capulet's mansion",
    "Act 1 Scene 4: A street outside Capulet's mansion",
    "Act 1 Scene 5: The Great Hall in Capulet's mansion",
    "Act 2 Scene 1: Outside Capulet's mansion",
    "Act 2 Scene 2: Capulet's orchard",
    "Act 2 Scene 3: Outside Friar Lawrence's cell",
    "Act 2 Scene 4: A street in Verona",
    "Act 2 Scene 5: Capulet's mansion",
    "Act 2 Scene 6: Friar Lawrence's cell"
]

var act1SceneCount = 0
for scene in romeoAndJuliet {
    if scene.hasPrefix("Act 1 ") {
        act1SceneCount += 1
    }
}
print("There are \(act1SceneCount) scenes in Act 1") // 打印输出“There are 5 scenes in Act 1”

var mansionCount = 0
var cellCount = 0
for scene in romeoAndJuliet {
    if scene.hasSuffix("Capulet's mansion") {
        mansionCount += 1
    } else if scene.hasSuffix("Friar Lawrence's cell") {
        cellCount += 1
    }
}
print("\(mansionCount) mansion scenes; \(cellCount) cell scenes") // 打印输出“6 mansion scenes; 2 cell scenes”






