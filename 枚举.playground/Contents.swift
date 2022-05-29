import UIKit

// 枚举语法

enum SomeEnumeration {
    // enumeration definition goes here
}


// 一个指南针的例子

enum CompassPoint {
    case north
    case south
    case east
    case west
}

// 多个成员值在同一行 用逗号隔开

enum Planet {
    case mercury, venus, earth, mars, jupiter, saturn, uranus, neptune
}

// 给枚举类型起的是一个单数而不是复数的名字  CompassPoint Planet

// 当与枚举类型中可用的某一值进行初始化， 他的变量/常量的类型会被推断出来 一旦变量/常量以枚举类型声明 可用用一个点（.）的语法把它设置不同的枚举类型的值
var dirctionToHead = CompassPoint.west
dirctionToHead = .west
// dirctionToHead的类型是已知的， 所以你当再次设定它的值可以不用写类型，这样使得在操作确定类型的枚举时让代码显得非常易读

// 使用Switch语句来匹配枚举值
dirctionToHead = .south
switch dirctionToHead {
case.north:
    print("Lots of planets have a north")
case .souoth:
    print("Watch out for penguins")
case .east:
    print("Where the sun fises")
case .west:
    print("Where the skies are blue")
}

// 如果Swift没有判断所有成员，那应该提供default来包含其他没被判断到的成员

let somePlanet = Planet.earth
switch somePlanet {
case .earth:
    print("Mostly harmless")
default:
    print("Not a safe place for humans")
}


// 遍历枚举情况（case)
// 在枚举名字后面写： CaseIterable 来允许枚举被遍历，Swift会暴露一个包含对应枚举类型所有尾部的集合名为allCases
enum Beverage: CaseIterable {
    case coffee, tea, juice
}
let numberOfChoices = Beverage.allCases.count
print("\(numberOfChoices) beverages available")

for beverage in Beverage.allCases {
    print(beverage)
}

// 关联值 可以存储不同类型的相关qfhg

enum Barcode {
    case upc (Int, Int, Int, Int)
    case qrCode(String)
}

var productBarcode = Barcode.upc(8, 12345, 12345, 8)
productBarcode = .qrCode("ABCDEFDSDSAFGVA")
// 这时，这里的原来的upc就被qrCode和它的字符串代替了，在给定的时间内只能存储其中一个
// 可以提取每一个相关值来作为常量或变量
switch productBarcode {
case .upc(let numberSystem, let manufacturer, let product, let check):
    print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
case .qrCode(let productCode):
    print("QR code: \(productCode).")
}

//为了简洁， 还能这样写
switch productBarcode {
case let .upc(numberSystem, manufacturer, product, check):
    print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
case let .qrCode(productCode):
    print("QR code: \(productCode).")
}

// 原始值 枚举成员可以用相同类型的默认值预先填充

enum ASCIIControlCharacter: Character {
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}


// 隐式指定的原始值
enum Planet2: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}
// Planet2.mercury有个明确的原始值是1，那么，venus隐式原始值是2, earth是3. 。。。 以此类推

enum CompassPoint2: String {
    case north, south, east, west
}
// 这里的CompassPoint2.south有一个隐式的原始值"south"

// 可以使用rawValue属性来访问枚举成员的原始值

let earthOrder = Planet2.earth.rawValue
print(earthOrder)

let sunsetDirection = CompassPoint2.west.rawValue
print(sunsetDirection)

// 从原始值初始化
let possiblePlanet = Planet2(rawValue: 7)
// possiblePlanet的类型是 Planet2? , 或 “ 可选项 Planet"


let positionToFind = 11
if let somePlanet = Planet2(rawValue: positionToFind) {
    switch somePlanet {
    case .earth:
        print("Mostly harmless")
    default:
        print("Not a safe place for humans")
    }
} else {
    print("There isn't a planet at position \(positionToFind)")
}


// 递归枚举

enum ArithmeticExpression {
    case number(Int)
    indirect case addition(ArithmeticExpression, ArithmeticExpression)
    indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
}

indirect enum ArithmeticExpression2 {
    case number(Int)
    case addition(ArithmeticExpression2, ArithmeticExpression2)
    case multiplication(ArithmeticExpression2, ArithmeticExpression2)
}


let five = ArithmeticExpression.number(5)
let four = ArithmeticExpression.number(4)
let sum = ArithmeticExpression.addition(five, four)
let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))

func evaluate(_ expression: ArithmeticExpression) -> Int {
    switch expression {
    case let .number(value):
        return value
    case let .addition(left, right):
        return evaluate(left) + evaluate(right)
    case let .multiplication(left, right):
        return evaluate(left) * evaluate(right)
    }
}
 
print(evaluate(product))
