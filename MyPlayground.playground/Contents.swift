import UIKit


// 变量
var greeting = "Hello, playground"
print(greeting)

// 常量

let hello = "Hello World!"

print(hello)

// ps: 如果你的代码中有不需要改变的值，请使用 let 关键字将它声明为常量。只将需要改变的值声明为变量。

//类型注解。   变量名：类型注解
var welcomeMessage:String = "Hello"
var intNum:Int = 1;
var floatPI:Float = 3.14
var doubleDou:Double = 1.234567
var chatC:Character = "你"
/*
基础数据类型
整型： Int Int8 Int16 Int32 Int64 UInt UInt8.....
浮点型： Float Float16 .... Double ...
布尔型： Bool
文本型： String
 
基本集合类型:数组(Array)、集合（Set）、字典（Dictionary）
 */

let π = 3.14159
let 你好 = "你好世界"
let 🐶🐮 = "dogcow"


// 这是一条单行注释

/* 这是第一个多行注释的开头
/* 这是第二个被嵌套的多行注释 */
这是第一个多行注释的结尾 */

//通过运用嵌套多行注释，你可以快速方便的注释掉一大段代码，即使这段代码之中已经含有了多行注释块。



//swift不强制要在每条语句结尾处用分号（；），你自己想加上分号也可以
//但你想在一行中写两条或两条以上的语句，要使用分号隔开
let cat = "🐱"; print(cat)



//整数范围
print(UInt8.min) //0
print(UInt8.max) //255

// 在32位系统 Int和Int32长度相同， 在64位系统 Int和Int64长度相同，
// 无符号整数类型也是如此 在32位系统 UInt和UInt32长度相同， 在64位系统 UInt和UInt64长度相同


// 类型安全&类型推断
let meaningOfLife = 42
// meaningOfLife 会被推测为 Int 类型
let pi = 3.14159
// pi 会被推测为 Double 类型
//浮点型，都会推断为Double,而不是Float

// 数值型字面量
let decimalInteger = 17
let binaryInteger = 0b10001       // 二进制的17
let octalInteger = 0o21           // 八进制的17
let hexadecimalInteger = 0x11     // 十六进制的17

//数值类型转换
/*
 1. 超出类型范围则会编译报错
 2. 转换成相同类型进行运算，someType(value)
 */

// 类型别名
typealias u8 = UInt8
let u8_12:u8 = 12
print(u8_12)
print(u8.max)

// 布尔值
let T_value = true
let F_value = false


//元组 多个值可以不同数据类型

let http404Err = (404,"Not Found!")

let (code, msg) = http404Err
print("code: \(code)") // code: 404
print("message: \(msg)") // message: Not Found!

// 可选类型
let possibleNumber = "123"
let contverteNumber = Int(possibleNumber)
print(contverteNumber) // Optional(123)

//nil
var optional:String? // 如果声明一个常量或变量没有赋值，自动设置为nil
print(optional)

// nil 可以用来比较判断一个可选值是否包含值 通过相等（==）或不等（!=)来进行比较

if(contverteNumber != nil){
    print("convertedNumber contains some integer value.")
}

// 可选绑定
if let actualNumber = Int(possibleNumber) {
    print("\'\(possibleNumber)\' has an integer value of \(actualNumber)")
} else {
    print("\'\(possibleNumber)\' could not be converted to an integer")
}

//隐式解析可选类型

let possibleString: String? = "An optional string."
let forcedString: String = possibleString! // 需要感叹号来获取值

let assumedString: String! = "An implicitly unwrapped optional string."
let implicitString: String = assumedString  // 不需要感叹号





