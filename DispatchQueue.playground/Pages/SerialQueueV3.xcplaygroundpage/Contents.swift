import Foundation
// Async vs Sync in Serial Queue

let serialQueue = DispatchQueue(label: "serial queue")
let newSerialQueue = DispatchQueue(label: "new serial queue")

func loadProfilePicture() {
    print("🔥 Profile Picture Start")
    print("🔥 Profile Picture loading")
    
    for _ in 0...1_000_000 {
        
    }
    
    print("🔥 Profile Picture finish")
}

func loadAddresDetail() {
    print("📢 Addres Detail Start")
    print("📢 Addres Detail loading")
    
    newSerialQueue.async {
        print("📢 Adress Detail for loop start")
        for _ in 0...10_000_000 {
            
        }
        print("📢 Adress Detail for loop finish")
    }
    
    print("📢 Adress Detail finish")
}

serialQueue.async {
    loadAddresDetail()
}

serialQueue.async {
    loadProfilePicture()
}
