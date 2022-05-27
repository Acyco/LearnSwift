import UIKit


let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

func backward( _ s1: String, _ s2: String) -> Bool {
    return s1 > s2
}

var reversedNames = names.sorted(by: backward)
print(reversedNames)


// 闭包表达式语法
/*
 
 { (parameters) -> (return type) in
    statements
 }
 
 */

reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in
    return s1 > s2
})

print(reversedNames)

// 如果函数体特别短， 可以使用一行来写
reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in return s1 > s2})

// 从语境中推断类型
reversedNames = names.sorted(by: { s1, s2 in return s1 > s2})

// 从单表达式中隐式返回 可省略return
reversedNames = names.sorted(by: { s1, s2 in s1 > s2})

// 简写的实际参数名  可以通过$0,$1, $2 .... 来引用闭包的实际参数值
reversedNames = names.sorted(by: { $0 > $1})

// 运算符函数。 由于swift 对 > 的特定字符实现， 其他运算符也可以  > 刚好返回的是Bool
reversedNames = names.sorted(by: >)

// 尾随闭包
// 写在括号外面
reversedNames = names.sorted() { $0 > $1}

// 省略括号
reversedNames = names.sorted { $0 > $1 }


let digitNames = [
    0: "Zero",1: "One",2: "Two",  3: "Three",4: "Four",
    5: "Five",6: "Six",7: "Seven",8: "Eight",9: "Nine"
 ]

 let numbers = [16,58,510]


let strings = numbers.map{ (number) -> String in
    var number = number
    var output = ""
    repeat {
        output = digitNames[number % 10]! + output
        number /= 10
    } while number > 0
    
    return output
}

print(strings) // ["OneSix", "FiveEight", "FiveOneZero"]

// 捕获值

func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func incrementer() -> Int {
        runningTotal += amount // 能根据上下文捕获 runningTotal, amount 在incrementer函数是没有这两个变量的， 通过捕获主函数来得到
        return runningTotal
    }
    return incrementer
}

// 使用makeIncrementer
let incrementByTen = makeIncrementer(forIncrement: 10)
incrementByTen() // 10
incrementByTen() // 20
incrementByTen() // 30
let incrementBySeven = makeIncrementer(forIncrement: 7)
incrementBySeven() // 7 不会影响到
incrementByTen() // 40

// 闭包是引用类型
let alsoIncrementByTen = incrementByTen
alsoIncrementByTen() // 50 变成50说明他是引用类型的。

// 闭包逃逸

var completionHandlers: [() -> Void] = []
func someFunctionWithEscapingClosure( completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler)
}

func someFunctionWithNonescapingClosure(closure: () -> Void) {
    closure()
}

class SomeClass {
    var x = 10
    func doSomething() {
        someFunctionWithEscapingClosure { self.x = 100 }
        someFunctionWithNonescapingClosure { x = 200 }
    }
}
 
let instance = SomeClass()
instance.doSomething()
print(instance.x)
// Prints "200"
 
completionHandlers.first?()
print(instance.x)

class SomeOtherClass {
    var x = 10
    func doSomething() {
        someFunctionWithEscapingClosure { [self] in x = 100 } // 将self放在闭包捕获列表来捕获self
        someFunctionWithNonescapingClosure { x = 200 }
    }
}

// 如果是self是结构体或枚举实例时， 可以隐式地引用self  但逃逸闭包是不可能捕获可修改的self的引用 结构体和枚举是不允许可共享修改性的
struct SomeStruct {
    var x = 10
    mutating func doSomething() {
        someFunctionWithNonescapingClosure { x = 200 }  // Ok
      //  someFunctionWithEscapingClosure { x = 100 }     // Error
    }
}
// 逃逸闭包是一种异变的方法 所以self是可编辑的， 这就违反了逃逸闭包不能捕获结构体的可编辑引用的规则


//自动闭包

var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
print(customersInLine.count)
// Prints "5"
 
let customerProvider = { customersInLine.remove(at: 0) }
print(customersInLine.count)
// Prints "5"
 
print("Now serving \(customerProvider())!")  // 只有在闭包调用的时候才执行的， 如果永远不调用，那么就永远不执行
// Prints "Now serving Chris!"
print(customersInLine.count)
// Prints "4"


// customersInLine is ["Alex", "Ewa", "Barry", "Daniella"]
func serve(customer customerProvider: () -> String) {
    print("Now serving \(customerProvider())!")
}
serve(customer: { customersInLine.remove(at: 0) } )
// Prints "Now serving Alex!"

// customersInLine is ["Ewa", "Barry", "Daniella"]
func serve(customer customerProvider: @autoclosure () -> String) {
    print("Now serving \(customerProvider())!")
}
serve(customer: customersInLine.remove(at: 0))
// Prints "Now serving Ewa!"


// PS: 还是不要滥用自动闭包， 这种方式会代码难以读懂， 上下文或函数名应该写清楚未值是延迟的




// 自动闭包允许逃逸

// customersInLine is ["Barry", "Daniella"]
var customerProviders: [() -> String] = []
func collectCustomerProviders(_ customerProvider: @autoclosure @escaping () -> String) {
    customerProviders.append(customerProvider)
}
collectCustomerProviders(customersInLine.remove(at: 0))
collectCustomerProviders(customersInLine.remove(at: 0))
 
print("Collected \(customerProviders.count) closures.")
// Prints "Collected 2 closures."
for customerProvider in customerProviders {
    print("Now serving \(customerProvider())!")
}
// Prints "Now serving Barry!"
// Prints "Now serving Daniella!"



