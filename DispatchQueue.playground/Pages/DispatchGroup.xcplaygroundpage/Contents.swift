import Foundation
import Darwin

let group = DispatchGroup()

let concurrentQueue = DispatchQueue(label: "concurrentQueue",
                                    attributes: .concurrent)

func loadProfilePicture() {
    group.enter()
    print("🔥 Profile Picture Start")
    print("🔥 Profile Picture loading")
    
    for _ in 0...1_000_000 {
        
    }
    
    print("🔥 Profile Picture finish")
    defer {
        group.leave()
    }
}

func loadAddresDetail() {
    group.enter()
    print("📢 Addres Detail Start")
    print("📢 Addres Detail loading")
    
    print("📢 Adress Detail for loop start")
    for _ in 0...10_000_000 {
        
    }
    print("📢 Adress Detail for loop finish")
    
    print("📢 Adress Detail finish")
    defer {
        group.leave()
    }
}

concurrentQueue.async {
    loadAddresDetail()
}

concurrentQueue.async {
    loadProfilePicture()
}

group.notify(queue: concurrentQueue) {
    print("Test")
}
