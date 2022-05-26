import UIKit

// 空数组
var someInts = [Int]()
print(someInts)
someInts.append(3)
print(someInts)
someInts = []
print(someInts)

// 使用默认值创建数组
var threeDoubles = Array(repeating: 0.0, count: 3)
print(threeDoubles)

// 通过连接两个数组来创建数组
var anotherThreeDouble = Array(repeating: 2.5, count: 3)
var sixDouble = threeDoubles + anotherThreeDouble
print(sixDouble)

// 使用数组字面量来创建数组
var shoppingList: [String] = ["Eggs", "Milk"]
print(shoppingList)

// 访问和修改数组
print("The shopping list contais \(shoppingList.count) items.")  // count
if( shoppingList.isEmpty){ // 使用isEmpty来检测count是否为0
    print("The shopping list is empty.")
}else{
    print("The shopping list is not empty.")
}

shoppingList.append("Flour") //使用append()在数组末尾添加新元素

shoppingList += ["Baking Power"] // +=
print(shoppingList)

shoppingList += ["Chocolate Spread", "Cheese", "Butter"]
print(shoppingList)

// 通过下标索引来获取数组里对应的值
var firstItem = shoppingList[0]
print(firstItem)

// 通过下标索引来修改数组里对应的值
shoppingList[0] = "Six eggs"
print(shoppingList)
shoppingList[4...6] = ["Bananas", "Apple"]
print(shoppingList)

// 插入 insert
shoppingList.insert("Maple Syrup", at: 0)
print(shoppingList)

//删除 remove
shoppingList.remove(at: 0)
print(shoppingList)

//移除最后一个元素 removeLast
let apples = shoppingList.removeLast()
print(apples)
print(shoppingList)

//遍历数组
for item in shoppingList{
    print(item)
}

// 遍历 值 和 整数索引
for (index, value) in shoppingList.enumerated()
{
    print("Item \(index + 1): \(value)")
}



// 集合 Set

var letters = Set<Character>()
print(letters)

letters.insert("a")
print(letters)

letters = [] // 虽然是没有元素， 但它的类型还是Set
print(letters)

//使用数组字面量创建集合

var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip hop"]

// 访问和修改集合
print(favoriteGenres.count) // count

if(favoriteGenres.isEmpty){
    print("Empty")
}
else{
    print("No empty")
}

favoriteGenres.insert("Jazz")
print(favoriteGenres)

// 删除集合元素 remove removeAll

if let removedGenre = favoriteGenres.remove("Rock"){
    print("\(removedGenre)? I'm over it.")
}else{
    print("I never much cared for that.")
}

// 检查是否包含特定元素
if (favoriteGenres.contains("Funk"))
{
    print("包含")
} else {
    print("不包含")
}

// 遍历集合 因为无序 使用sorted()方法
for genre in favoriteGenres.sorted(){
    print(genre)
}

// 基本集合的操作
let oddDigits: Set = [1, 3, 5, 7, 9]
let evenDigits: Set = [0, 2, 4, 6, 8]
let singleDigitPrimeNumbers: Set = [2, 3, 5, 7]
 
oddDigits.union(evenDigits).sorted() // 创建一个包含两个集合的所有值的新集合
// [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
oddDigits.intersection(evenDigits).sorted() // 创建只包含两个共有值的新集合
// []
oddDigits.subtracting(singleDigitPrimeNumbers).sorted() // 创建只包含两个集合各自有的非共有值的新集合
// [1, 9]
oddDigits.symmetricDifference(singleDigitPrimeNumbers).sorted() // 创建两个集合当中不包含某个集合值的新集合
// [1, 2, 9]

//集合的成员关系和相等性
// 集合相等 可以用 == 来判断

let houseAnimals: Set = ["🐶", "🐱"]
let farmAnimals: Set = ["🐮", "🐔", "🐑", "🐶", "🐱"]
let cityAnimals: Set = ["🐦", "🐭"]

houseAnimals.isSubset(of: farmAnimals) // 确定一个集合的所有值是被某集合包含
// true
farmAnimals.isSuperset(of: houseAnimals) // 确定一个集合是否包含某个集合的所有值
// true
farmAnimals.isDisjoint(with: cityAnimals) // 判断两个集合是否拥有完全不同的值
// true


// 字典

//创建一个空字典
var namesOfIntegers = [Int:String]()
print(namesOfIntegers)

namesOfIntegers[16] = "sixteen"
print(namesOfIntegers)

// 使用字典字面量来创建字典

var airports:[String:String] = ["YYZ":"Toronto Pearson", "DUB": "Dublin"]

// 访问和修改
print(airports.count) // count
if airports.isEmpty{
    print("empty")
} else {
    print("no empty")
}

//添加元素
airports["LHR"] = "London"
print(airports)

//修改元素
airports["LHR"] = "London Heathrow"
print(airports)

if let oldValue = airports.updateValue("Dublin Airport", forKey: "DUB") {
    print("The old value for DUB was \(oldValue).")
}

if let airportName = airports["DUB"] {
    print("The name of the airport is \(airportName).")
} else {
    print("That airport is not in the airports dictionary.")
}

// 移除元素
airports["APL"] = "Apple International"
print(airports)
airports["APL"] = nil // 赋值nil来给字典移除一对键值对
print(airports)

if let removedValue = airports.removeValue(forKey: "DUB") { // removeValue
    print("The removed airport's name is \(removedValue).")
} else {
    print("The airports dictionary does not contain a value for DUB.")
}

// 遍历字典
print("---------遍历-----------")
for (airportCode, airportName) in airports {
    print("\(airportCode): \(airportName)")
}

for airportCode in airports.keys {
    print("Airport code: \(airportCode)")
}

for airportName in airports.values {
    print("Airport name: \(airportName)")
}

let airportCodes = [String](airports.keys)
// airportCodes is ["YYZ", "LHR"]
let airportNames = [String](airports.values)
// airportNames is ["Toronto Pearson", "London Heathrow"]
    
