import UIKit

// 定义语法

class SomeClass{
    
}

struct SomeStruct{
    
}

struct Resolution{
    var width = 0
    var height = 0
}

class VideoMode {
    var resolution = Resolution()
    var intrlaced = false
    var frameRate = 0.0
    var name: String?
}

// 类与结构体实例
let someResolution = Resolution()
let someVideoMode = VideoMode()


// 访问属性

print("The width of someResolution is \(someResolution.width)")

// 结构休类型的成员初始化器
let vga = Resolution(width: 640, height: 480)

// 结构体和枚举是值类型
let hd = Resolution(width: 1920, height: 1080)
var cinema = hd

cinema.width = 2048

print("cineme is now \(cinema.width) pixels wide")

print("hd is still \(hd.width) pixels wide")

enum CompassPoint {
    case North, South, East, West
}
var currentDirection = CompassPoint.West
let rememberedDirection = currentDirection
currentDirection = .East
if rememberedDirection == .West {
    print("The remembered direction is still .West")
}

// 类的引用类型
let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.intrlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0

let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0

print("The frameRate property of tenEighty is now \(tenEighty.frameRate)")


// 特征运算符
if tenEighty === alsoTenEighty {
    print("tenEighty and alsoTenEighty refer to the same Videomode instance.")
}

// 结构体的实例是通过值来传递的， 而类的实例是通过引用来传递的

// 字符串，数组和字典的赋值与拷贝行为
// 他们都是作为结构体来实现的， 他们是传递了拷贝
// 这个和基础库中的 NSString , NSArray 和 NSDictionary 是不同的，它们是作为类来实现的，而不是结构体 作为一个已经存在的实例的引用而不是拷贝来赋值和传递。


