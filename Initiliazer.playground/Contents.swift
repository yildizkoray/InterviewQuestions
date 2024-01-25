import UIKit

class Vehicle {
    let name: String
    let isElectricty: Bool
    
    init(name: String, isElectricty: Bool) {
        self.name = name
        self.isElectricty = isElectricty
    }
    
    convenience init() {
        self.init(name: "From Vehicle", isElectricty: false)
    }
}

class Truck: Vehicle {
    let hasDamper: Bool
    
    init(hasDamper: Bool) {
        self.hasDamper = hasDamper
        super.init(name: "Volvo", isElectricty: false)
    }
    
    convenience init() {
        self.init(hasDamper: false)
    }
    
    convenience init(what: String) {
        self.init()
    }
}
