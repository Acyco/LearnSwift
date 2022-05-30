import UIKit

// 属性 可以将值与特定的类、结构体或枚举联系起来，分为存储属性和计算属性

// 存储属性会存储常量或变量作为实例的一部分

struct FixedLengthRange{
    var firstValue: Int
    let length: Int
}

var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
rangeOfThreeItems.firstValue = 6

let rangeOfFourItems = FixedLengthRange(firstValue: 0, length: 4)
// rangeOfFourItems.firstValue = 6
// rangeOfFourItems 是常量， 所以我们不能改变firstValue属性，即使firstValue是一个变量属性


// 延迟存储属性

class DataImporter {
    var fileName = "data.txt"
}

class DataManager {
    // 如果被标记为lazy修饰符的属性同时被多个线程访问并且属性没有被初始化，则无法保证属性只初始化一次。
    lazy var importer = DataImporter()
    var data = [String]()
}

let manager = DataManager()
manager.data.append("Some data")
manager.data.append("Some more data")

print(manager.importer.fileName)

// 计算属性
struct Point {
    var x = 0.0, y = 0.0
}
struct Size {
    var width = 0.0, height = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
    var center:Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            
            return Point(x: centerX, y: centerY)
        }
        set(newCenter) {
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.height / 2)
        }
    }
}

var square = Rect(origin: Point(x: 0.0, y: 0.0), size: Size(width: 10.0, height: 10.0))
let initialSquareCenter = square.center
square.center = Point(x: 15.0, y: 15.0) // 通过计算可以改变origin属性
print("square.origin is now at (\(square.origin.x), \(square.origin.y))")

// 简写设置器(setter)声明
struct AlternativeRect {
    var origin = Point()
    var size = Size()
    var center:Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            
            return Point(x: centerX, y: centerY)
        }
        set{
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}

// 缩写读取器(getter)声明
struct CompactRect {
    var origin = Point()
    var size = Size()
    var center:Point {
        get {
            Point(x: origin.x + (size.width / 2), y: origin.y + (size.height / 2)) // 在getter里省略return
        }
        set{
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}


// 只读计算属性

struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double {
        return width * height * depth
    }
}

let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
print("the volume of forByFiveByTwo is \(fourByFiveByTwo.volume)")

// 属性观察者
// willSet 会在该值被存储之前被调用
// didSet 会在一个新值被存储后被调用

struct StepCounter {
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) {
            print("About to set totalSteps to \(newTotalSteps)")
        }
        didSet {
            if totalSteps > oldValue {
                print("Added \(totalSteps - oldValue) steps")
            }
        }
    }
}

var stepCounter = StepCounter()
stepCounter.totalSteps = 200
// About to set totalSteps to 200
// Added 200 steps
stepCounter.totalSteps = 360
// About to set totalSteps to 360
// Added 160 steps
stepCounter.totalSteps = 896
// About to set totalSteps to 896
// Added 536 steps


// 属性包装

@propertyWrapper
struct TwelveOrLess {
    private var number = 0
    var wrappedValue: Int {
        get { return number }
        set { number = min(newValue, 12) } //保证了新值小于等于12，
    }
}

struct SmallRectangle {
    @TwelveOrLess var height: Int
    @TwelveOrLess var width: Int
}

var rectangle = SmallRectangle()
print(rectangle.height) // 0

rectangle.height = 10
print(rectangle.height) // 10

rectangle.height = 24
print(rectangle.height) // 12


// 下面是自己写的属性包装行为的代码，而不是用 @TwelveOrLess 这个特性
struct SmallRectangle2 {
    private var _height = TwelveOrLess()
    private var _width = TwelveOrLess()
    var height: Int {
        get { return _height.wrappedValue }
        set { _height.wrappedValue = newValue }
    }
    var width: Int {
        get { return _width.wrappedValue }
        set { _width.wrappedValue = newValue }
    }
}

// 设定包装属性的初始值

@propertyWrapper
struct SmallNumber {
    private var maximum: Int
    private var number: Int
    var wrappedValue: Int {
        get { return number }
        set { number = min(newValue, maximum) }
    }
    init() {
        maximum  = 12
        number = 0
    }
    init(wrappedValue: Int) {
        maximum = 12
        number = min(wrappedValue, maximum)
    }
    init(wrappedValue:Int, maximum: Int) {
        self.maximum = maximum
        number = min(wrappedValue, maximum)
    }
}

struct ZeroRectangle {
    @SmallNumber var height: Int
    @SmallNumber var width: Int
}

var zeroRectangle = ZeroRectangle()
print(zeroRectangle.height,zeroRectangle.width) // 0 0

struct UnitRectangle {
    @SmallNumber var height: Int = 1  // 调用init(warppedValue:)初始化器 下同
    @SmallNumber var width: Int = 1
}

var unitRectangle = UnitRectangle()
print(unitRectangle.height, unitRectangle.width) // 1 1

struct NarrowRectangle {
    @SmallNumber(wrappedValue: 2, maximum: 5) var height: Int
    @SmallNumber(wrappedValue: 3, maximum: 4) var width: Int
}

var narrowRectangle = NarrowRectangle()
print(narrowRectangle.height, narrowRectangle.width) // 2 3

narrowRectangle.height  = 100
narrowRectangle.width = 100
print(narrowRectangle.height, narrowRectangle.width) // 5 4

// 混合
struct MixedRectangled {
    @SmallNumber var height: Int = 1
    @SmallNumber(maximum: 9) var width: Int = 2
}

var mixedRectangle = MixedRectangled()
print(mixedRectangle.height) // 1

mixedRectangle.height = 20
print(mixedRectangle.height) // 12


// 通过属性包装映射值

@propertyWrapper
struct SmallNumber2 {
    private var number = 0
    var projectedValue = false
    var wrappedValue: Int {
        get { return number }
        set {
            if newValue > 12 {
                number = 12
                projectedValue = true
            } else {
                number = newValue
                projectedValue = false
            }
        }
    }
    // 下面是我自己写的初始化器， 因为教程的代码没有初始化器在Xcode13.4版本会报错
    init() {
      
    }
}

struct SomeStructure {
    @SmallNumber2 var someNumber: Int
}

var someStructure = SomeStructure()
someStructure.someNumber = 4
print(someStructure.$someNumber) // false

someStructure.someNumber = 55
print(someStructure.$someNumber) // true

// someStructure.$someNumber 来访问包装的映射值

enum Size2 {
    case small, large
}

struct SizedRectangle {
    @SmallNumber2 var height: Int
    @SmallNumber2 var width: Int
    mutating func resize( to size: Size2) -> Bool {
        switch size {
        case .small:
            height = 10
            width = 20
        case .large:
            height = 100
            width = 100
        }
        return $height || $width
    }
}

// 全局和局部变量

// 类型属性

// 类型属性语法

struct SomeStructure1 {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 1
    }
}

enum SomeEnumeration {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 6
    }
}

class SomeClass {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 27
    }
    class var overrideableComputedTypeProperty: Int {
        return 107
    }
}
// 查询和设置类型属性
print(SomeStructure1.storedTypeProperty) // Some value.
SomeStructure1.storedTypeProperty = "Another value."
print(SomeStructure1.storedTypeProperty) // Another value.
print(SomeEnumeration.computedTypeProperty) // 6
print(SomeClass.computedTypeProperty) // 27


struct AudioChannel {
    static let thresholdLevel = 10
    static var maxInputLevelForAllChannels = 0
    var currentLevel: Int = 0 {
        didSet {
            if currentLevel > AudioChannel.thresholdLevel {
                currentLevel = AudioChannel.thresholdLevel
            }
            if currentLevel > AudioChannel.maxInputLevelForAllChannels{
                AudioChannel.maxInputLevelForAllChannels = currentLevel
            }
        }
    }
}

var leftChannel = AudioChannel()
var rightChannel = AudioChannel()

leftChannel.currentLevel = 7
print(leftChannel.currentLevel) // 7
print(AudioChannel.maxInputLevelForAllChannels) // 7

rightChannel.currentLevel = 11
print(rightChannel.currentLevel) // 10
print(AudioChannel.maxInputLevelForAllChannels) // 10

