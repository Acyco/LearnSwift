import UIKit

// 理解内在访问冲突

var one = 1
print("We're number \(one)")

// 典型的内存访问

func oneMore(than number: Int) -> Int {
    return number + 1
}

var myNumber = 1
myNumber = oneMore(than: myNumber)
print(myNumber)

// 输入输出形式参数的访问冲突

var stepSize = 1
func increment(_ number: inout Int) {
    number += stepSize
}

//increment(&stepSize) // Error
// 读写冲突了
var copyOfStepSize = stepSize
increment(&copyOfStepSize)

stepSize = copyOfStepSize

func balance(_ x: inout Int, _ y: inout Int) {
    let sum = x + y
    x = sum / 2
    y = sum - x
}

var playerOneScore = 42
var playerTwoScore = 30
balance(&playerOneScore, &playerTwoScore)
// balance(&playerOneScore, &playerOneScore) // Error 同时两写入重叠了

// 在方法中对self 的访问冲突
struct Player {
    var name: String
    var health: Int
    var energy: Int
    
    static let maxHealth = 10
    mutating func restoreHealth() {
        health = Player.maxHealth
    }
}

// 扩展Player
extension Player {
    mutating func shareHealth(with teammate: inout Player) {
        balance(&teammate.health, &health)
    }
}

var oscar = Player(name: "Oscar", health: 10, energy: 10)
var maria = Player(name: "Maria", health: 5, energy: 10)
oscar.shareHealth(with: &maria) // OK

// oscar.shareHealth(with: &oscar) // ERROR self teammate 引用的都是同一个地址

// 属性的访问冲突

var playerInformation = (health: 10, energy: 20)
// balance(&playerInformation.health, &playerInformation.energy) // ERROR 对元组元素进行重叠写入

var holly = Player(name: "Holly", health: 10, energy: 10)
//balance(&holly.health, &holly.energy)  // Error 对全局结构体属性的重叠写入 全局哦

func someFunction() {
    var oscar = Player(name: "Oscar", health: 10, energy: 10)
    balance(&oscar.health, &oscar.energy) // OK 这里是oscar是局部变量，不会报错， 编译器就可以保证重叠访问结构体的存储属性是安全的
}

// 下面的条件可以满足就说明重叠访问结构体的属性是安全的
// 1. 你只访问实例的存储属性，不是计算属性或者类属性；
// 2. 结构体是局部变量而非全局变量；
// 3. 结构体要么没有被闭包捕获要么只被非逃逸闭包捕获。