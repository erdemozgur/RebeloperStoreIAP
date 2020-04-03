//
//  RebeloperStoreSetup.swift
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

import Foundation

extension RebeloperStore {
    
    // -----------------------------------------------------------------------------
    // First save your in-app purchase ids in App Store Connect like:
    //
    // com.yourCompany.yourApp.sufix
    //
    // ex: com.Rebeloper.RebeloperStore5Example.nonConsumable
    //     ^- Bundle Identifier                 ^- sufix
    //
    // IMPORTANT: in the Rebeloper Store code the "com.yourCompany.yourApp" part
    // is fetched from your Info.plist file Bundle Identifier.
    // To create a "RegisteredPurchase" you have to add only the sufix.
    //
    // Notes:
    // 1. In RegisteredPurchase "consumable" and "non-consumable" in-app purchases
    // are added as ".regular"
    //
    // 2. Image urls are optional. They can be:
    //  a). none -> enter an emty String: ""
    //  b). in an asset catalog -> enter the name / path of the image
    //  c). a url -> enter the url of the image; has to be https!
    //
    // Now add your purchases below usig your in-app purchase sufixes.
    
    static let nonConsumable = RegisteredPurchase(imageUrl: "Icon-1024", sufix: "nonConsumable", purchaseType: .regular)
    static let consumable = RegisteredPurchase(imageUrl: "Icon-1024", sufix: "consumable", purchaseType: .regular)
    static let nonRenewing = RegisteredPurchase(imageUrl: "Icon-1024", sufix: "nonRenewing", purchaseType: .nonRenewing)
    static let autoRenewableWeekly = RegisteredPurchase(imageUrl: "Icon-1024", sufix: "autoRenewableWeekly", purchaseType: .autoRenewable)
    static let autoRenewableMonthly = RegisteredPurchase(imageUrl: "Icon-1024", sufix: "autoRenewableMonthly", purchaseType: .autoRenewable)
    static let autoRenewableYearly = RegisteredPurchase(imageUrl: "Icon-1024", sufix: "autoRenewableYearly", purchaseType: .autoRenewable)
    
    // -----------------------------------------------------------------------------
    // Create a list of your purchases if needed.
    // This can be useful if you're displaying them in a list.
    
    static var registeredPurchases: [RegisteredPurchase] = [
        nonConsumable,
        consumable,
        nonRenewing,
        autoRenewableWeekly,
        autoRenewableMonthly,
        autoRenewableYearly
    ]
    
    // -----------------------------------------------------------------------------
    // If you're having auto-renewable in-app purchases
    // you must provide your app specific shared secret form App Store Connect.
    
    static let inAppPurchasesSharedSecret = "686913af9c2d46baa506b0b160069d72"
    
    // -----------------------------------------------------------------------------
    // When set to "true" you will find detailed logs in your console
    // when you're testing your in-app purchases.
    // Very usefull for debugging! Set it to "false" to turn it off.
    
    static let shouldLogRebeloperStore = true
}


