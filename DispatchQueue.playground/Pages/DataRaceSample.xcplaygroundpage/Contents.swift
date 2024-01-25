import Foundation

import Foundation

public final class UnfairLock {

  private var unfairLock = os_unfair_lock()

  private func lock() {
    os_unfair_lock_lock(&unfairLock)
  }

  private func unlock() {
    os_unfair_lock_unlock(&unfairLock)
  }

  public func around<T>(_ closure: () -> T) -> T {
    lock(); defer { unlock() }
    return closure()
  }

  public func around(_ closure: () -> Void) {
    lock(); defer { unlock() }
    return closure()
  }
}

let lock = UnfairLock()

let concurrentQueue1 = DispatchQueue(label: "concurrentQueue", attributes: .concurrent)
let concurrentQueue2 = DispatchQueue(label: "concurrentQueue", attributes: .concurrent)

final class BankAccount {
    var balance: Int

    init(balance: Int) {
        self.balance = balance
    }
}

final class Bank {

    private let lockQueue = DispatchQueue(label: "bank.lock.queue")

    @discardableResult
    func transfer(amount: Int, from fromAccount: BankAccount, to toAccount: BankAccount) -> Bool {
        lockQueue.sync {
                guard fromAccount.balance >= amount else {
                    return false
                }
                toAccount.balance += amount
                fromAccount.balance -= amount

                return true
            }
    }
}

let bank = Bank()

let bank1 = BankAccount(balance: 100)
let bank2 = BankAccount(balance: 100)

concurrentQueue1.sync {
    bank.transfer(amount: 50, from: bank1, to: bank2)
}

print(bank1.balance)
print(bank2.balance)

concurrentQueue2.sync {
    bank.transfer(amount: 70, from: bank1, to: bank2)
}

print(bank1.balance)
print(bank2.balance)
