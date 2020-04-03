//
//  RebeloperStorePro.swift
//  RebeloperStore5
//
//  Created by Alex Nagy on 02/08/2019.
//  Copyright © 2019 Alex Nagy. All rights reserved.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import DuckUI
import ReactiveKit
import SwiftyStoreKit
import StoreKit

extension RebeloperStore {
    
    static func verifyReceipt(completion: @escaping (Bool?) -> Void) {
        
        if !isRebeloperStoreStarted {
            log.warning(rebeloperStoreIsNotStartedMessage)/
            return
        }
        
        verifyTheReceipt { result in
            logForVerifyReceipt(result)
            switch result {
            case .success(_):
                completion(true)
            case .error(_):
                completion(false)
            }
        }
    }
    
    fileprivate static func verifyTheReceipt(completion: @escaping (VerifyReceiptResult) -> Void) {
        
        if !isRebeloperStoreStarted {
            log.warning(rebeloperStoreIsNotStartedMessage)/
            return
        }
        
        let appleValidator = AppleReceiptValidator(service: .production, sharedSecret: inAppPurchasesSharedSecret)
        SwiftyStoreKit.verifyReceipt(using: appleValidator, completion: completion)
    }
    
    static func verifyRegularPurchase(_ sufix: PurchaseSufix, completion: @escaping (Result<VerifyPurchaseResult, Error>) -> ()) {
        
        if !isRebeloperStoreStarted {
            log.warning(rebeloperStoreIsNotStartedMessage)/
            return
        }
        
        verifyTheReceipt { result in
            
            switch result {
            case .success(let receipt):
                
                let productId = D_InfoPlistParser.getBundleId() + "." + sufix
                
                let purchaseResult = SwiftyStoreKit.verifyPurchase(
                    productId: productId,
                    inReceipt: receipt)
                logForVerifyPurchase(purchaseResult, productId: productId)
                completion(.success(purchaseResult))
                
            case .error(let err):
                logForVerifyReceipt(result)
                completion(.failure(err))
            }
        }
    }
    
    static func verifyRenewablePurchase(_ sufix: PurchaseSufix, validDuration: TimeInterval = 0, completion: @escaping (Result<VerifySubscriptionResult, Error>) -> ()) {
        
        if !isRebeloperStoreStarted {
            log.warning(rebeloperStoreIsNotStartedMessage)/
            return
        }
        
        verifyTheReceipt { result in
            
            switch result {
            case .success(let receipt):
                
                let productId = D_InfoPlistParser.getBundleId() + "." + sufix
                
                if validDuration != 0 {
                    let purchaseResult = SwiftyStoreKit.verifySubscription(
                        ofType: .nonRenewing(validDuration: validDuration),
                        productId: productId,
                        inReceipt: receipt)
                    logForVerifySubscriptions(purchaseResult, productIds: [productId])
                    completion(.success(purchaseResult))
                    
                } else {
                    
                    let purchaseResult = SwiftyStoreKit.verifySubscription(
                        ofType: .autoRenewable,
                        productId: productId,
                        inReceipt: receipt)
                    logForVerifySubscriptions(purchaseResult, productIds: [productId])
                    completion(.success(purchaseResult))
                }
            case .error(let err):
                logForVerifyReceipt(result)
                completion(.failure(err))
            }
        }
    }
    
    static func verifySubscriptions(_ sufixes: Set<PurchaseSufix>, completion: @escaping (Result<VerifySubscriptionResult, Error>) -> ()) {
        
        if !isRebeloperStoreStarted {
            log.warning(rebeloperStoreIsNotStartedMessage)/
            return
        }
        
        verifyTheReceipt { result in
            
            switch result {
            case .success(let receipt):
                let productIds = Set(sufixes.map { D_InfoPlistParser.getBundleId() + "." + $0 })
                let purchaseResult = SwiftyStoreKit.verifySubscriptions(productIds: productIds, inReceipt: receipt)
                logForVerifySubscriptions(purchaseResult, productIds: productIds)
                completion(.success(purchaseResult))
            case .error(let err):
                logForVerifyReceipt(result)
                completion(.failure(err))
            }
        }
    }
}
