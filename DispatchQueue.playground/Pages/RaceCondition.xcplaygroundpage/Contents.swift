import Foundation

class ProductListingViewModel {
    
    private let queue = DispatchQueue(label: "view model",
                                      attributes: .concurrent)
    
    var productIDs: [Int]
    
    init(productIDs: [Int]) {
        self.productIDs = productIDs
    }
    
    var numberOfProductIDs: Int {
        return queue.sync {
            return productIDs.count
        }
    }
    
    func addProductID(_ id: Int) {
        queue.sync(flags: .barrier) {
            productIDs.append(id)
        }
    }
    
    func removeProductID(_ id: Int) {
        queue.sync(flags: .barrier) {
            let index = productIDs.firstIndex(of: id)!
            productIDs.remove(at: index)
        }
    }
}

let ids = [1,2,3]
let viewModel = ProductListingViewModel(productIDs: ids)

let concurrentQueue = DispatchQueue(label: "serial queue",
                                    attributes: .concurrent)
let concurrentQueue2 = DispatchQueue(label: "serial queue2",
                                     attributes: .concurrent)
let concurrentQueue3 = DispatchQueue(label: "serial queue3",
                                     attributes: .concurrent)
let concurrentQueue4 = DispatchQueue(label: "serial queue3",
                                     attributes: .concurrent)

concurrentQueue.async {
    print("1 - ", viewModel.numberOfProductIDs)
    concurrentQueue4.async {
        viewModel.addProductID(4)
    }
    print("2 - ", viewModel.numberOfProductIDs)
}

concurrentQueue4.async {
    viewModel.addProductID(5)
}

viewModel.addProductID(6)

concurrentQueue3.async {
    print("3 - ", viewModel.numberOfProductIDs)
}

concurrentQueue2.async {
    print("4 - ", viewModel.numberOfProductIDs)
    viewModel.removeProductID(4)
    print("5 - ", viewModel.numberOfProductIDs)
}


