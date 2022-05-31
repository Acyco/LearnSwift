import UIKit

// 初始化
// 初始化是为类、结构体或者枚举准备实例的过程，可以通过定义初始化器来实现初始化过程

// 为存储属性设置初始化值

struct Fahrenheit {
    var temperature: Double
    init() { // 定义初始化器
        temperature = 32.0
    }
}

var f = Fahrenheit()
print("The default temperature is \(f.temperature)° Fahrenheit")

// 默认的属性值

struct Fahrenheit1 {
    var temperature = 32.0 // 这样结构更简单
}


// 自定义初始化

// 初始化形式参数
struct Celsius {
    var temperatureInCelsius: Double
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
}

let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
print(boilingPointOfWater.temperatureInCelsius)
let freezingPointOfWater = Celsius(fromKelvin: 273.15)
print(freezingPointOfWater.temperatureInCelsius)

// 形式参数名和实际参数标签

struct Color {
    let red, green, blue: Double
    init(red: Double, green: Double, blue: Double){
        self.red = red
        self.green = green
        self.blue = blue
    }
    init (white: Double) {
        red = white
        green = white
        blue = white
    }
}

let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
let halfGray = Color(white: 0.5)
// let veryGreen = Color(0.0, 1.0, 0.0) // 编译时会报错


// 无实际参数标签的初始化器形式参数
// 如果不想为初始化器形式参数使用实际参数标签， 可以写一个下划线（ _ ）替代明确的实际参数标签以重写默认行为

struct Celsius2 {
    var temperatureInCelsius: Double
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
    init(_ celsius: Double) {
        temperatureInCelsius = celsius
    }
}
let bodyTemperature = Celsius2(37.0)


// 可选属性类型

class SurveyQuestion {
    var text: String
    var response: String? // “可选String” 类型
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}
let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?")
cheeseQuestion.ask()
cheeseQuestion.response = "Yes, I do like cheese."

// 在初始化中分配常量属性
class SurveyQuestion2 {
    let text: String // 常量属性
    var response: String?
    init(text: String) {
        self.text = text // 尽管text的属性是常量，但依然能在可以在类的初始化器中设置值
    }
    func ask() {
        print(text)
    }
}
let beetsQuestion = SurveyQuestion2(text: "How about beets?")
beetsQuestion.ask()
beetsQuestion.response = " I also like beets. (But not with cheese.)"

// 默认初始化器
// Swift 为所有没有提供初始化器的结构体和类都提供了一个默认初始化器来给所有的属性提供了默认值
class ShoppingListItem2 {
    var name: String?
    var quantity = 1
    var purchased = false
}

var item = ShoppingListItem2()

// 结构体类型的成员初始化器
// 如果结构体类型中没有定义任何自定义初始化器，它会自动获得一个成员初始化器， 不同于默认初始化器， 结构体会接收成员初始化器，即使结构体的存储属性没有默认值

struct Size {
    var width = 0.0, height = 0.0
}
let twoByTwo = Size(width: 2.0, height: 2.0)
let zeroByTwo = Size(height:2.0)
print(zeroByTwo.width, zeroByTwo.height)


// 值类型的初始化器委托
// struct Size .. 同上
struct Point {
    var x = 0.0, y = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
    init() {}
    init(origin: Point, size: Size) {
        self.origin = origin
        self.size = size
    }
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

let baseRect = Rect() // 返回一个 origin size属性都会初始化为默认值0.0的实例
let originRect = Rect(origin: Point(x: 2.0, y: 2.0), size: Size(width: 5.0, height: 5.0))
let centerRect = Rect(center: Point(x: 4.0, y: 4.0), size: Size(width: 3.0, height: 3.0))


// 类的继承和初始化

// 指定初始化器和便捷初始化器
// 便捷初始化器 要用 convenience 修饰符 放在 init关键字前， 用空格隔开

// 类类型的初始化器委托
// 有三种规则
// 1. 指定初始化器必须从它的直系父类调用指定初始化器。
// 2. 便捷初始化器必须从相同的类里调用另一个初始化器。
// 3. 便捷初始化器最终必须调用一个指定初始化器。
//简单记忆： 指定初始化器必须总是向上委托， 便捷初始化器必须总是横向委托


// 两段式初始化
// Swift在类的初始化是分为两段式过程
// 第一阶段： 分配初始值
// 第二阶段：在第一阶段完成后， 每个类都有机会在新的实例准备使用之前定制它的存储属性
// 好处：让初始化更加安全，还保持了完备的灵活性

// 在两段式初始化过程，Swift编译器执行了四种有效的安全检查来确保整个过程能顺利完成
// 1. 指定初始化器 必须在向上委托父类前，把自己所在类的所有属性初始化完成
// 2. 指定初始化器，必须在先向上委托后，才能继承设置的新值
// 3. 便捷初始化器必须先委托同类中的其他初始化器， 然后再为任意属性赋新值，
// 4. 在两段式的初始化的第一阶段没完成， 不能调用任何实例方法，不能读取任何实例属性的值，也不能引用self作为值



// 初始化器的继承和重写
class Vehicle {
    var numberOfWheels = 0
    var description: String {
        return "\(numberOfWheels) wheel(s)"
    }
}

let vehicle = Vehicle()
print("Vehicle: \(vehicle.description)")

class Bicycle: Vehicle {
    override init() { // 当你子类初始化器匹配父类指定的初始化器时，重写的时，在子类初始化器定义之前必须写override 修饰符
        super.init() // 调用父类的初始化器
        numberOfWheels = 2
    }
}

let bicycle = Bicycle()
print("Bicycle: \(bicycle.description)")

// 初始化器的自动继承
// 有两个规则
// 1. 当子类没有定义任何指定初始化器，会自动继承父类的所有指定初始化器
// 2. 当子类提供了所有父类的指定初始化器的实现，要么能过规则1继承，要么通过在定义中提供自定义实现，那么将子类将自动继承所有父类的便捷初始化器


// 指定和便捷初始化器的实战
class Food {
    var name: String
    init(name: String) {
        self.name = name
    }
    convenience init() {
        self.init(name: "[Unnamed]")
    }
}

let nameMeat = Food(name: "Bacon") // name is Bacon
let MysteryMeat = Food() // name is [Unnamed]

class RecipeIngredient: Food {
    var quantity: Int
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    override convenience init(name: String) {
        self.init(name: name,quantity: 1)
    }
}
let oneMysteryItem = RecipeIngredient()
let oneBacon = RecipeIngredient(name: "Bacon")
let sixEggs = RecipeIngredient(name: "Eggs", quantity: 6)


class ShoppingListItem: RecipeIngredient {
    var purchased = false
    var description: String {
        var output = "\(quantity) x \(name)"
        output += purchased ? " ✔" : " ✘"
        return output
    }
}

var breakfastList = [
    ShoppingListItem(),
    ShoppingListItem(name: "Bacon"),
    ShoppingListItem(name: "Eggs", quantity: 6)
]

breakfastList[0].name = "Orange juice"
breakfastList[0].purchased = true
for item in breakfastList {
    print(item.description)
}


// 可失败的初始化器
// 在无效的参数，缺少某种外部所需资源 或 其他阻止初始化的情况才会使用的
// 在init关键字后面添加问号（？）

let wholeNumber: Double = 12345.0
let pi = 3.14159
if let valueMaintained = Int(exactly: wholeNumber) {
    print("\(wholeNumber) conversion to int mantains value")
}

let valueChanged = Int(exactly: pi)
if valueChanged == nil {
    print("\(pi) conversion to int dese not maintain value")
}

struct Animal {
    let species: String
    init?(species: String) {
        if species.isEmpty { return nil }
        self.species = species
    }
}

let someCreature = Animal(species: "Giraffe")
print(someCreature?.species) // Optional("Giraffe")

if let giraffe = someCreature {
    print("An animal was initialized with a species of \(giraffe.species)")
}

let anonymousCreature = Animal(species: "")
print(anonymousCreature?.species) // nil
if anonymousCreature == nil {
    print("The anonymous creature could not be initialized")
}


// 枚举的可失败初始化器
enum TemperatureUnit {
    case kelvin, Celsius, Fahrenheit
    init?(symbol: Character) {
        switch symbol {
        case "K":
            self = .kelvin
        case "C":
            self = .Celsius
        case "F":
            self = .Fahrenheit
        default:
            return nil
        }
    }
}

let fahrenheitUnit = TemperatureUnit(symbol: "F")
if fahrenheitUnit != nil {
    print("This is a defined temperature unit, so initialization succeeded.")
}

let unknowUnit = TemperatureUnit(symbol: "X")
if unknowUnit == nil {
    print("This is not a defined temperature unit, so initialization, failed.")
}

// 带有原始值枚举的可失败初始化器

enum TemperatureUnit2: Character {
    case Kelvin = "K", Celsiu = "C", Fahrenheit = "F"
}

let fahrenheitUnit2 = TemperatureUnit2(rawValue: "F")

if fahrenheitUnit2 != nil {
    print("This is a defined temperture unit. so initialization succeeded.")
}

let unknowUnit2 = TemperatureUnit2(rawValue: "X")
if unknowUnit == nil {
    print("This is not a defined temperture unit. so initialization failed.")
}

// 初始化失败的传递

class Product {
    let name: String
    init?(name: String) {
        if name.isEmpty { return nil }
        self.name = name
    }
}

class CartItem: Product {
    let quantity: Int
    init?(name: String, quantity: Int) {
        if quantity < 1 { return nil }
        self.quantity = quantity
        super.init(name: name)
    }
}


if let twoSocks = CartItem(name: "sock", quantity: 2){
    print("Item: \(twoSocks.name), quantity: \(twoSocks.quantity)")
}

if let zeroShirts = CartItem(name: "shirt", quantity: 0){
    print("Item: \(zeroShirts.name), quantity: \(zeroShirts.quantity)")
} else {
    print("Unable to initialize zero shirts")
}

if let oneUnnamed = CartItem(name: "", quantity: 1) {
    print("Item: \(oneUnnamed.name), quantity: \(oneUnnamed.quantity)")
} else {
    print("Unable to initialize one unnamed product")
}


// 重写可失败初始化器

class Document {
    var name: String?
    init() {}
    init?(name: String) {
        self.name = name
        if name.isEmpty { return nil }
    }
}

class AutomaticallyNamedDocument: Document {
    override init() {
        super.init()
        self.name = "[Untitled]"
    }
    override init(name: String) {
        super.init()
        if name.isEmpty {
            self.name = "[Untitle]"
        } else {
            self.name = name
        }
    }
}

class UntitledDocument: Document {
    override init() {
        super.init(name: "[Untitled]")!
    }
}

// 必要初始化器

class SomeClass {
    required init() {
        // initializer implementatioin goes here
    }
}

class SomeSubClass: SomeClass {
    required init() {
        // subclass implementation of the required initializer goes here
    }
}



// 通过闭包和函数来设置属性的默认值

struct Chessboard {
    let boardColors: [Bool] = {
        var temporaryBoard = [Bool]()
        var isBlack = false
        for i in 1...8 {
            for j in 1...8 {
                temporaryBoard.append(isBlack)
                isBlack = !isBlack
            }
            isBlack = !isBlack
        }
        return temporaryBoard
    }()
    func squareIsBlackAt(row: Int, column: Int) -> Bool {
        return boardColors[(row * 8) + column]
    }
}

let board = Chessboard()
print(board.squareIsBlackAt(row: 0, column: 1))
print(board.squareIsBlackAt(row: 7, column: 7))
