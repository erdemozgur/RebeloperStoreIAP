//
//  VirtualGoodExchange.swift
//  RebeloperStore5
//
//  Created by Alex Nagy on 01/08/2019.
//  Copyright © 2019 Alex Nagy. All rights reserved.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import Foundation
import KeychainSwift
import DuckUI

struct GiveVirtualGoodOnFirstLaunch {
    let virtualGood: VirtualGood
    let amount: Int
}

enum VirtualGoodType: String {
    case consumable
    case nonConsumable
}

enum VirtualGoodPurchaseType: String {
    case consumable
    case nonConsumable
}

enum ExchangeResult: String {
    case insuficientFunds
    case nonConsumableIsOnlyOneItem
    case nonConsumableAlreadyBought
    case success
    case failure
}

struct VirtualGoodExchange {
    
    static var isVirtualGoodExchangeStarted = false
    static let virtualGoodExchangeIsNotStartedMessage = "VirtualGoodExchange is not started! Please add 'VirtualGoodExchange.start()' to your 'application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?)' in AppDelegate.swift"
    
    fileprivate static let keychain = KeychainSwift()
    
    static func start() {
        isVirtualGoodExchangeStarted = true
        if !isNotFirstLaunch() {
            giveFirstLauchVirtualGoods()
            setIsNotFirstLaunchAnyMore()
        } else {
            if shouldLogVirtualGoodExchange {
                log.ln("It's not first launch")/
            }
        }
        
        logKeychainCurrentState()
    }
    
    fileprivate static func giveFirstLauchVirtualGoods() {
        
        if !isVirtualGoodExchangeStarted {
            log.warning(virtualGoodExchangeIsNotStartedMessage)/
            return
        }
        
        if shouldLogVirtualGoodExchange {
            log.ln("Reseting keychain...")/
        }
        for giveVirtualCurrecyOnFirstLaunch in giveVirtualCurreciesOnFirstLaunch {
            var amountToGive = giveVirtualCurrecyOnFirstLaunch.amount
            if shouldLogVirtualGoodExchange {
                log.ln("Reset ~> Amount to give: \(amountToGive) of \(giveVirtualCurrecyOnFirstLaunch.virtualGood.name)")/
            }
            
            if giveVirtualCurrecyOnFirstLaunch.virtualGood.type == .nonConsumable, amountToGive > 1 {
                if shouldLogVirtualGoodExchange {
                    log.warning("Reset ~> Trying to give more of non-consumable \(giveVirtualCurrecyOnFirstLaunch.virtualGood.name). Not allowed! Giving only: 1")/
                }
                amountToGive = 1
            }
            
            save(virtualGood: giveVirtualCurrecyOnFirstLaunch.virtualGood, amount: amountToGive) { (success) in
                if shouldLogVirtualGoodExchange {
                    log.ln("Reset ~> Given \(amountToGive) of \(giveVirtualCurrecyOnFirstLaunch.virtualGood) with success: \(success)")/
                }
            }
        }
    }
    
    static func change(virtualGood: VirtualGood, amount: Int, completion: @escaping (Result<ExchangeResult, Error>) -> () = {_ in }) {
        
        if !isVirtualGoodExchangeStarted {
            log.warning(virtualGoodExchangeIsNotStartedMessage)/
            return
        }
        
        fetch(virtualGood: virtualGood) { (result) in
            switch result {
            case .success(let currentAmount):
                if amount < 0 {
                    if currentAmount < -amount {
                        if shouldLogVirtualGoodExchange {
                            log.ln("Not enough funds")/
                        }
                        completion(.success(.insuficientFunds))
                        return
                    }
                }
                
                let updatedAmount = currentAmount + amount
                
               
                
                if virtualGood.type == .nonConsumable, updatedAmount != 1, updatedAmount != 0  {
                    completion(.success(.nonConsumableIsOnlyOneItem))
                    return
                }
                
                save(virtualGood: virtualGood, amount: updatedAmount, completion: { (success) in
                    if success {
                        completion(.success(.success))
                    } else {
                        completion(.success(.failure))
                    }
                })
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }
    
    static func exchange(virtualGood: VirtualGood, amount: Int, forVirtualGood: VirtualGood, forAmount: Int, completion: @escaping (Result<ExchangeResult, Error>) -> () = {_ in }) {
        
        if !isVirtualGoodExchangeStarted {
            log.warning(virtualGoodExchangeIsNotStartedMessage)/
            return
        }
        
        var currentAmount = 0
        var forCurrentAmount = 0
        
        fetch(virtualGood: virtualGood) { (result) in
            switch result {
            case .success(let fetchedCurrentAmount):
                currentAmount = fetchedCurrentAmount
                
                fetch(virtualGood: forVirtualGood) { (result) in
                    switch result {
                    case .success(let fetchedForCurrentAmount):
                        forCurrentAmount = fetchedForCurrentAmount
                        
                        if virtualGood.type == .nonConsumable, fetchedCurrentAmount > 1 {
                            if shouldLogVirtualGoodExchange {
                                log.warning("Triyng to exchange more than one non-consumable \(virtualGood.name). Not allowed!")/
                            }
                            completion(.success(.nonConsumableIsOnlyOneItem))
                            return
                        }
                        
                        if forVirtualGood.type == .nonConsumable, fetchedForCurrentAmount > 1 {
                            if shouldLogVirtualGoodExchange  {
                                log.warning("Triyng to exchange more than one non-consumable \(forVirtualGood.name). Not allowed!")/
                            }
                            completion(.success(.nonConsumableAlreadyBought))
                            return
                        }
                        
                        if currentAmount < amount {
                            if shouldLogVirtualGoodExchange {
                                log.ln("Not enough funds")/
                            }
                            completion(.success(.insuficientFunds))
                            return
                        }
                        let newAmount = currentAmount - amount
                        let newForAmount = forCurrentAmount + forAmount
                        
                        saveExchange(virtualGood: virtualGood, currentAmount: currentAmount, newAmount: newAmount, forVirtualGood: forVirtualGood, newForAmount: newForAmount, completion: { (result) in
                            switch result {
                                
                            case .success(let success):
                                if success {
                                    if shouldLogVirtualGoodExchange {
                                        log.success("Successfully completed exchange!")/
                                    }
                                    completion(.success(.success))
                                } else {
                                    if shouldLogVirtualGoodExchange {
                                        log.error("Failed to save exchange!")/
                                    }
                                    completion(.success(.failure))
                                }
                            case .failure(let err):
                                if shouldLogVirtualGoodExchange {
                                    log.error("Failed to save exchange with err: \(err)")/
                                }
                                completion(.failure(err))
                            }
                        })
                        
                    case .failure(let err):
                        completion(.failure(err))
                    }
                }
                
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }
    
    static func fetch(virtualGood: VirtualGood, completion: @escaping (Result<Int, Error>) -> ()) {
        
        if !isVirtualGoodExchangeStarted {
            log.warning(virtualGoodExchangeIsNotStartedMessage)/
            return
        }
        
        guard
            let amountString = keychain.get(virtualGood.name)
            else {
                guard let osStatusError = keychain.lastResultCode.error else { return }
                completion(.failure(osStatusError))
                return
        }
        guard let amount = Int(amountString) else {
            if shouldLogVirtualGoodExchange {
                log.error("Failed to convert from String to Int")/
            }
            return
        }
        completion(.success(amount))
    }
    
    static func delete(virtualGood: VirtualGood, completion: @escaping (Bool) -> () = {_ in }) {
        
        if !isVirtualGoodExchangeStarted {
            log.warning(virtualGoodExchangeIsNotStartedMessage)/
            return
        }
        
        if shouldLogVirtualGoodExchange {
            log.warning("Deleting Virtual Good: \(virtualGood.name)")/
        }
        completion(keychain.delete(virtualGood.name))
    }
    
    static func clear(completion: @escaping (Bool) -> () = {_ in }) {
        
        if !isVirtualGoodExchangeStarted {
            log.warning(virtualGoodExchangeIsNotStartedMessage)/
            return
        }
        
        if shouldLogVirtualGoodExchange {
            log.warning("Clearing keychain")/
        }
        completion(keychain.clear())
    }
    
    static func reset() {
        
        if !isVirtualGoodExchangeStarted {
            log.warning(virtualGoodExchangeIsNotStartedMessage)/
            return
        }
        
        clear { (success) in
            if success {
                giveFirstLauchVirtualGoods()
            } else {
                if shouldLogVirtualGoodExchange {
                    log.error("Failed to clear keychain, but reseting anyway")/
                }
                giveFirstLauchVirtualGoods()
            }
        }
        
    }
    
    static func logKeychainCurrentState() {
        
        if !isVirtualGoodExchangeStarted {
            log.warning(virtualGoodExchangeIsNotStartedMessage)/
            return
        }
        
        if !shouldLogVirtualGoodExchange { return }
        log.warning("Keychain Log - Beginning")/
        for virtualGood in virtualGoods {
            fetch(virtualGood: virtualGood) { (result) in
                switch result {
                case .success(let amount):
                    log.success("Found Virtual Good: \(virtualGood.name) ~> \(amount)")/
                case .failure(let err):
                    log.error(err.localizedDescription)/
                }
            }
        }
        log.warning("Keychain Log - End")/
    }
    
    // MARK: - Fileprivate functions
    
    fileprivate static func saveExchange(virtualGood: VirtualGood, currentAmount: Int, newAmount: Int, forVirtualGood: VirtualGood, newForAmount: Int, completion: @escaping (Result<Bool, Error>) -> ()) {
        
        if !isVirtualGoodExchangeStarted {
            log.warning(virtualGoodExchangeIsNotStartedMessage)/
            return
        }
        
        save(virtualGood: virtualGood, amount: newAmount, completion: { (success) in
            if success {
                save(virtualGood: forVirtualGood, amount: newForAmount, completion: { (success) in
                    if success {
                        completion(.success(true))
                    } else {
                        if shouldLogVirtualGoodExchange {
                            log.error("Could not save \(forVirtualGood) amount. Trying to revert exchange...")/
                        }
                        save(virtualGood: virtualGood, amount: currentAmount, completion: { (success) in
                            if shouldLogVirtualGoodExchange {
                                if success {
                                    log.success("Successfully reverted exchange!")/
                                } else {
                                    log.error("Could not revert exchange!")/
                                }
                            }
                            completion(.success(false))
                        })
                    }
                })
            } else {
                completion(.success(false))
            }
        })
    }
    
    fileprivate static func save(virtualGood: VirtualGood, amount: Int, completion: @escaping (Bool) -> ()) {
        
        if !isVirtualGoodExchangeStarted {
            log.warning(virtualGoodExchangeIsNotStartedMessage)/
            return
        }
        
        let stringUpdatedAmount = String(amount)
         completion(keychain.set(stringUpdatedAmount, forKey: virtualGood.name))
    }
    
    fileprivate static func isNotFirstLaunch() -> Bool {
        
        if !isVirtualGoodExchangeStarted {
            log.warning(virtualGoodExchangeIsNotStartedMessage)/
            return false
        }
        
        if let isNotFirstLaunch = keychain.getBool("isNotFirstLaunch") {
            return isNotFirstLaunch
        } else {
            return false
        }
    }
    
    fileprivate static func setIsNotFirstLaunchAnyMore() {
        
        if !isVirtualGoodExchangeStarted {
            log.warning(virtualGoodExchangeIsNotStartedMessage)/
            return
        }
        
        keychain.set(true, forKey: "isNotFirstLaunch")
    }
    
}

