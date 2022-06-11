import UIKit

// 访问级别
// Open public
// Internal
// File-private
// private
// open 访问是最高的（限制最少）访问级别， private是最低的（限制最多）访问级别

// open 只适用于类和类成员

// 默认访问级别
// 不指明访问级别 默认为internal级别

// 单目标应用的访问级别
// 默认的internal访问级别 就已经匹配这种单目标应用需求

// 框架的访问级别
// 那就应该装饰要面向公众的接口标注为open或public

// 单元测试目标的访问级别

// 访问控制语法

public class SomePublicClass {}
internal class SomeInternalClass {}
fileprivate class SomeFilePrivateClass {}
private class SomeClass {}

public var somePublicVariable = 0
internal var someInternalVariable = 0
fileprivate func someFilePrivateFunction() {}
private func somePrivateFunction() {}

// 除非已经标注过访问级别 否则都会使用默认的internal的访问级别


// 自定类型

public class SomePublicClass2 {
    public var somePublicProperty = 0
    var someInternalProperty = 0
    fileprivate func someFilePrivateMethod() {}
}

class SomeInternalClass2{
    var someInternalProperty = 0
    fileprivate func someFileProvateMethod() {}
    private func someProivateMethod() {}
}

fileprivate class SomeFilePrivateClass2 {
    func someFilePrivateMethod() {}
    private func SomePrivateMothod() {}
}

private class SomePrivateClass {
    func somePrivateMethod() {}
}

// 元组类型
// 元组类型的访问级别是所有类型里最严格的，只要在元组里面有一个元素的访问级别是private那么这个元组类型就是private访问级别，因为他不能像其他类型或类、枚举、结构体等可以单独定义

// 函数类型

// func someFunction() -> (SomeInternalClass2, SomePrivateClass) {}  // ERROR 无法通过编译的
private  func someFunction() -> (SomeInternalClass2, SomePrivateClass) {
    //
    return (SomeInternalClass2(), SomePrivateClass())
}


// 枚举类型

public enum CompassPoint {
    case north
    case south
    case east
    case west
}

// 枚举的类型是一个public，那么，里面的成员north, south, east, west都是 public

// 嵌套类型
// private 级别的类型中定义的嵌套类型自动为 private 级别。fileprivate 级别的类型中定义的嵌套类型自动为 fileprivate 级别。public 或 internal 级别的类型中定义的嵌套类型自动为 internal 级别。如果你想让嵌套类型是 public 级别的，你必须将其显式指明为 public。

// 子类
// 重写可以让一个继承类成员比它的父类中的更容易访问
public class A {
    fileprivate func someMethod() {}
}

internal class B: A {
    override internal func someMethod() {
        // 允许调用父类的更低一点的成员方法或属性，我也不知道是不是这样
        super.someMethod()
        
    }
}
// 常量， 变量， 属性和下标
// 常量， 变量， 属性不能拥有比它们 类型更高的访问级别。下标也同理
private var privateInstance = SomePrivateClass()


// Getters 和 Setters

struct TrackedString {
    private(set) var numberOfEdits = 0
    var value: String = "" {
        didSet {
            numberOfEdits += 1
        }
    }
    public init() {}
}


var stringToEdit = TrackedString()
stringToEdit.value = "This string will be tracked."
stringToEdit.value += " This edit will increment numberOfEdits."
stringToEdit.value += " So will this one."
print("The number of edits is \(stringToEdit.numberOfEdits)")

// 初始化器

// 默认初始化器

// 默认初始化器和所属类的访问级别一致，除非是类定义为public 那么他的默认初始化器方法为internal级别

// 结构体的默认成员初始化器
// 如果存储属性为private时 那么他默认的初始化器方法为private级别 如果存储属性为fileprivate时那么等同。



// 协议
// 访问级别要一致

// 协议继承
// 如果继承一个已有的协议 那么新协议也要和继承的协议 访问级别也要一致

// 协议遵循
// 最好是一致。
// 一个类不可能在一个程序中用不同方法遵循一个协议的

// 扩展

// 保持一致

// 扩展中的私有成员

protocol SomeProtocol {
    func doSoething()
}

struct SomeStruct {
    private var privateVariable = 12
}

extension SomeStruct: SomeProtocol {
    func doSoething() {
        print(privateVariable)
    }
}

// 泛型
// 泛指类型和泛指函数的访问级别取泛指类型或函数以及泛型类型参数的访问级别的最小值。


// 类型别名
// 类型可以向上 不可以向下 同样协议也是如此
