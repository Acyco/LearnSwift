import UIKit
import Foundation
////
//listPhotos(inGallery: "Summer Vacatioin") { photoNames
//    in
//    let sortedNames = photoNames.sorted()
//    let name = sortedNames[1]
//    downloadPhoto(named: name) { photo in
//        show(photo)
//    }
//}


// 定义和调用异步函数
//
//func listPhotos(inGallery name: String) async -> [String] {
//    let result:[String] = ["abcdef", "test"]  // 随便的数据
//    return result
//}
//
//let photoNames = await listPhotos(inGallery: "Summer Vacagtion")
//let sortedNames = photoNames.sorted()

func listPhotos(inGallery name: String) async -> [String] {
    let result:[String] = ["IMG001", "IMG99","ImG0404"]  // 随便的数据
    do {
        try  await Task.sleep(nanoseconds: 4_000_000_000)
    } catch is CancellationError {
        print("error")
    } catch {
        print(" unknow error")
    }
    return result
}


 func downloadPhoto(named n: String) async -> String {
     let name = n
     return name
 }
 
 func show(_ name: String) {
     // do something ....
     print(" show \(name)")
 }

func show(_ names: [String]) {
    // do something ....
}

Task.detached {
 

        let photoNames = await listPhotos(inGallery: "Summer Vacagtion")
        let sortedNames = photoNames.sorted()
        let name = sortedNames[1]
        let photo = await downloadPhoto(named: name)
        show(photo)

    // 并行调用异步方法

    let firstPhoto = await downloadPhoto(named: photoNames[0])
    let secondPhoto = await downloadPhoto(named: photoNames[1])
    let thirdPhoto = await downloadPhoto(named: photoNames[2])
    
    let photos = [firstPhoto,secondPhoto,thirdPhoto]
    show(photos)
    
    // 任务和任务组
    
    await withTaskGroup(of: Data.self) { taskGroup in
        let photoNames1 = await listPhotos(inGallery: "Summer Vacation")
        for name in photoNames1 {
         //   taskGroup.async{ await downloadPhoto(named: name)}
            print(name)
        }
        
    }
}


// 如果又要抛出错误和异步。那就在 throws 前加 async
func example() async throws {
    
}



// 异步序列
//
//let handle = FileHandle.standardInput
//for try await line in handle.bytes.lines {
//    print(line)
//}


// 非结构化并发
//let newPhoto = // ... some photo data ...
//let handle = async {
//    return await add(newPhoto, toGalleryNamed: "Spring Adventures")
//}
//let result = await handle.get()


// 任务撤销

// 抛出类似 CancellationError错误
// 返回nil 或 空集合
// 返回部分完成

// 手动传递撤销 调用Task.Handle.cancel()

// 检查撤销， 要么调用 Task.checkCancellation()


// 行为体
actor TemperatureLogger {
    let label: String
    var measurements: [Int]
    private(set) var max: Int
    
    init(label: String, measurement: Int) {
        self.label = label
        self.measurements = [measurement]
        self.max = measurement
    }
}
Task.detached {
    let logger = TemperatureLogger(label: "Outdoors", measurement: 25)
    print(await logger.max)
}

extension TemperatureLogger { // 扩展
    func update(with measurement: Int) {
        measurements.append(measurement)
        if measurement > max {
            max = measurement
        }
    }
}


// print(logger.max) // Error
 
