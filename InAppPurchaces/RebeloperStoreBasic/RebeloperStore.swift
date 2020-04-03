//
//  RebeloperStore.swift
//  RebeloperStore5
//
//  Created by Alex Nagy on 31/07/2019.
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

typealias PurchaseSufix = String

struct RebeloperStore {
    fileprivate static let emptyInAppPurchases: [InAppPurchase] = []
    static let inAppPurchases = Property(emptyInAppPurchases)
    
    static var isRebeloperStoreStarted = false
    static let rebeloperStoreIsNotStartedMessage = "Rebeloper Store is not started! Please add 'RebeloperStore.start()' to your 'application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?)' in AppDelegate.swift"
    
    enum PurchaseType: String {
        case regular
        case autoRenewable
        case nonRenewing
    }
    
    static func start() {
        isRebeloperStoreStarted = true
        setupInAppPurchases()
        fetchInAppPurchases()
    }
    
    static func setupInAppPurchases() {
        
        if shouldLogRebeloperStore {
            log.ln("Completing transactions...")/
        }
        
        SwiftyStoreKit.completeTransactions(atomically: true) { purchases in
            
            for purchase in purchases {
                switch purchase.transaction.transactionState {
                case .purchased, .restored:
                    let downloads = purchase.transaction.downloads
                    if !downloads.isEmpty {
                        SwiftyStoreKit.start(downloads)
                    } else if purchase.needsFinishTransaction {
                        // Deliver content from server, then:
                        SwiftyStoreKit.finishTransaction(purchase.transaction)
                    }
                    log.success("\(purchase.transaction.transactionState.debugDescription): \(purchase.productId)")/
                case .failed, .purchasing, .deferred:
                break // do nothing
                @unknown default:
                    break // do nothing
                }
            }
        }
        
        SwiftyStoreKit.updatedDownloadsHandler = { downloads in
            
            // contentURL is not nil if downloadState == .finished
            let contentURLs = downloads.compactMap { $0.contentURL }
            if contentURLs.count == downloads.count {
                print("Saving: \(contentURLs)")
                SwiftyStoreKit.finishTransaction(downloads[0].transaction)
            }
        }
    }
    
    static func fetchInAppPurchases() {
        
        if !isRebeloperStoreStarted {
            log.warning(rebeloperStoreIsNotStartedMessage)/
            return
        }
        
        if shouldLogRebeloperStore {
            log.ln("Fetching registered in-app purchases...")/
        }
        
        for registeredPurchase in registeredPurchases {
            getInfo(registeredPurchase.sufix) { (product) in
                guard let product = product,
                    let price = product.localizedPrice else { return }
                let id = "\(D_InfoPlistParser.getBundleId()).\(registeredPurchase.sufix)"
                let title = product.localizedTitle
                let description = product.localizedDescription
                let iap = InAppPurchase(id: id, imageUrl: registeredPurchase.imageUrl, registeredPurchase: registeredPurchase, title: title, description: description, price: price)
                inAppPurchases.value.append(iap)
            }
        }
    }
    
    static func getInfo(_ sufix: PurchaseSufix, completion: @escaping (SKProduct?) -> Void) {
        
        if !isRebeloperStoreStarted {
            log.warning(rebeloperStoreIsNotStartedMessage)/
            return
        }
        
        SwiftyStoreKit.retrieveProductsInfo([D_InfoPlistParser.getBundleId() + "." + sufix]) { result in
            logForProductRetrievalInfo(result)
            if let product = result.retrievedProducts.first {
                completion(product)
            } else {
                completion(nil)
            }
        }
    }
    
    static func purchase(_ sufix: PurchaseSufix, completion: @escaping (Bool) -> Void) {
        
        if !isRebeloperStoreStarted {
            log.warning(rebeloperStoreIsNotStartedMessage)/
            return
        }
        
        SwiftyStoreKit.purchaseProduct(D_InfoPlistParser.getBundleId() + "." + sufix, atomically: true) { result in
            logForPurchaseResult(result)
            switch result {
            case .success(_):
                completion(true)
            case .error(_):
                completion(false)
            }
        }
    }
    
    static func restorePurchases(completion: @escaping (Bool?) -> Void) {
        
        if !isRebeloperStoreStarted {
            log.warning(rebeloperStoreIsNotStartedMessage)/
            return
        }
        
        SwiftyStoreKit.restorePurchases(atomically: true) { results in
            logForRestorePurchases(results)
            if results.restoreFailedPurchases.count > 0 {
                completion(false)
            } else if results.restoredPurchases.count > 0 {
                completion(true)
            } else {
                completion(nil)
            }
        }
    }
    
}

extension RebeloperStore {
    
    static func logForProductRetrievalInfo(_ result: RetrieveResults) {
        if !shouldLogRebeloperStore { return }
        if let product = result.retrievedProducts.first {
            let priceString = product.localizedPrice!
            log.success("\(product.localizedTitle) ~> \(product.localizedDescription) - \(priceString)")/
        } else if let invalidProductId = result.invalidProductIDs.first {
            log.warning("Could not retrieve product info ~> Invalid product identifier: \(invalidProductId)")/
        } else {
            let errorString = result.error?.localizedDescription ?? "Unknown error. Please contact support"
            log.error("Could not retrieve product info ~> \(errorString)")/
        }
    }
    
    static func logForPurchaseResult(_ result: PurchaseResult) {
        if !shouldLogRebeloperStore { return }
        switch result {
        case .success(let purchase):
            log.success("Purchase Success ~> \(purchase.productId)")/
        case .error(let error):
            log.error("Purchase Failed ~> \(error)")/
            switch error.code {
            case .unknown:
                log.error("Purchase failed ~> \(error.localizedDescription)")/
            case .clientInvalid: // client is not allowed to issue the request, etc.
                log.error("Purchase failed ~> Not allowed to make the payment")/
            case .paymentCancelled: // user cancelled the request, etc.
                log.error("Purchase failed ~> Payment canceled")/
            case .paymentInvalid: // purchase identifier was invalid, etc.
                log.error("Purchase failed ~> The purchase identifier was invalid")/
            case .paymentNotAllowed: // this device is not allowed to make the payment
                log.error("Purchase failed ~> The device is not allowed to make the payment")/
            case .storeProductNotAvailable: // Product is not available in the current storefront
                log.error("Purchase failed ~> The product is not available in the current storefront")/
            case .cloudServicePermissionDenied: // user has not allowed access to cloud service information
                log.error("Purchase failed ~> Access to cloud service information is not allowed")/
            case .cloudServiceNetworkConnectionFailed: // the device could not connect to the nework
                log.error("Purchase failed ~> Could not connect to the network")/
            case .cloudServiceRevoked: // user has revoked permission to use this cloud service
                log.error("Purchase failed ~> Cloud service was revoked")/
                
            default:
                log.error("Purchase failed ~> \((error as NSError).localizedDescription)")/
            }
        }
    }
    
    static func logForRestorePurchases(_ results: RestoreResults) {
        if !shouldLogRebeloperStore { return }
        if results.restoreFailedPurchases.count > 0 {
            log.error("Restore Failed: \(results.restoreFailedPurchases)")/
        } else if results.restoredPurchases.count > 0 {
            log.success("Restore Success: \(results.restoredPurchases)")/
        } else {
            log.warning("Nothing to Restore")/
        }
    }
    
    static func logForVerifyReceipt(_ result: VerifyReceiptResult) {
        if !shouldLogRebeloperStore { return }
        switch result {
        case .success(let receipt):
            log.success("Verify receipt Success: \(receipt)")/
            log.success("Receipt verified ~> Receipt verified remotely")/
        case .error(let error):
            log.error("Verify receipt Failed: \(error)")/
            switch error {
            case .noReceiptData:
                log.error("Receipt verification ~> No receipt data. Try again.")/
            case .networkError(let error):
                log.error("Receipt verification ~> Network error while verifying receipt: \(error)")/
            default:
                log.error("Receipt verification ~> Receipt verification failed: \(error)")/
            }
        }
    }
    
    static func logForVerifySubscriptions(_ result: VerifySubscriptionResult, productIds: Set<String>) {
        if !shouldLogRebeloperStore { return }
        switch result {
        case .purchased(let expiryDate, let items):
            log.success("\(productIds) is valid until \(expiryDate) - \(items)")/
            log.success("Product is purchased ~> Product is valid until \(expiryDate)")/
        case .expired(let expiryDate, let items):
            log.warning("\(productIds) is expired since \(expiryDate) - \(items)")/
            log.warning("Product expired ~> Product is expired since \(expiryDate)")/
        case .notPurchased:
            log.ln("\(productIds) has never been purchased")/
            log.ln("Not purchased ~> This product has never been purchased")/
        }
    }
    
    static func logForVerifyPurchase(_ result: VerifyPurchaseResult, productId: String) {
        if !shouldLogRebeloperStore { return }
        switch result {
        case .purchased:
            log.success("\(productId) is purchased ~> Product will not expire")/
        case .notPurchased:
            log.warning("\(productId) has never been purchased")/
        }
    }
}
