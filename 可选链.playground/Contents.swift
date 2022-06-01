import UIKit

// 可选链代替强制展开

class Person {
    var residence:Residence?
}

class Residence {
    var numberOfRooms = 1
}

let john = Person()
// let roomCount = john.residence!.numberOfRooms // error

if let roomCount = john.residence?.numberOfRooms { // 返回 nil
    print("John's residence has \(roomCount) room(s)")
} else {
    print("Unable to retrieve the number of rooms") // 打印这里
}

john.residence = Residence()

if let roomCount2 = john.residence?.numberOfRooms { // 返回 1
    print("John's residence has \(roomCount2) room(s)") // 打印这里
} else {
    print("Unable to retrieve the number of rooms")
}

// 为可选链定义模型类
class Room {
    let name: String
    init (name: String) { self.name = name }
}

class Address {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    func buildingIdentifier() -> String? {
        if buildingName != nil {
            return buildingName
        } else if buildingNumber != nil && street != nil {
            return "\(buildingNumber) \(street)"
        } else {
            return nil
        }
    }
}

class Residence2 {
    var rooms = [Room]()
    var numberOfRooms: Int {
        return rooms.count
    }
    subscript(i: Int) -> Room {
        get {
            return rooms[i]
        }
        set {
            rooms[i] = newValue
        }
    }
    func printNumberOfRooms() {
        print("The number of rooms is \(numberOfRooms)")
    }
    var address: Address?
}
class Person2 {
    var residence: Residence2?
}



// 通过可选链访问属性
print("------------------------------------")
let john2 = Person2()
if let roomCount3 = john2.residence?.numberOfRooms {
    print("John's residence has \(roomCount3) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}
let someAddress = Address()
someAddress.buildingNumber = "29"
someAddress.street = "Acacia Road"
john2.residence?.address = someAddress //失败 因为residence为nil
john2.residence?.address?.buildingIdentifier()

func createAddress() -> Address {
    print("Function was called.")
    let someAddress = Address()
    someAddress.buildingNumber = "29"
    someAddress.street = "Acacia Road"
    
    return someAddress
}

john2.residence?.address = createAddress() // createAddress() 此时并没有调用。因为什么都不没有打印

// 通过可选链调用方法

if john2.residence?.printNumberOfRooms() != nil {
    print("It was possible to print the number of rooms.")
} else {
    print("It was not possible to print the number of rooms.") // 打印这里
}


if (john2.residence?.address = someAddress) != nil {
    print("It was possible to set the address.")
} else {
    print("It was not possible to set the address.") // 因为reisdence? 目前还是nil
}

// 通过可选链访问下标
if let firstRoomName = john2.residence?[0].name {
    print("The first room name is \(firstRoomName).")
} else {
    print("Unable to retrieve the first room name.") // 目前还是没有数据
}

// 通过下标来设置一个新值
john2.residence?[0] = Room(name: "Bathroom") // 设置失败： residence 还是nil

let johnsHouse = Residence2()
johnsHouse.rooms.append(Room(name: "Living Room"))
johnsHouse.rooms.append(Room(name: "Kitchen"))
john2.residence = johnsHouse

if let firstRoomName = john2.residence?[0].name {
    print("The first room name is \(firstRoomName).")
} else {
    print("Unable to retrieve the first room name.")
}
// 访问可选类型的下标
var testScores = ["Dave": [86, 82, 84], "Bev": [79, 94, 81]]
testScores["Dave"]?[0] = 91
testScores["Bev"]?[0] += 1
testScores["Brian"]?[0] = 72

// 链的多层连接

if let johnsStreet = john2.residence?.address?.street { // john2.residence?.address 的值目前为nil
    print("John's street name is \(johnsStreet).")
} else {
    print("Unable to retrieve the address.")
}

let johnsAddress = Address()
johnsAddress.buildingName = "The Larches"
johnsAddress.street = "Laurel Street"
john2.residence?.address = johnsAddress
 
if let johnsStreet = john2.residence?.address?.street {
    print("John's street name is \(johnsStreet).")
} else {
    print("Unable to retrieve the address.")
}


// 用可选返回值连接方法

if let buildingIdentifier = john2.residence?.address?.buildingIdentifier() {
    print("John's building identifier is \(buildingIdentifier).")
}

if let beginsWithThe =
    john2.residence?.address?.buildingIdentifier()?.hasPrefix("The") {
        if beginsWithThe {
            print("John's building identifier begins with \"The\".")
        } else {
            print("John's building identifier does not begin with \"The\".")
        }
}
