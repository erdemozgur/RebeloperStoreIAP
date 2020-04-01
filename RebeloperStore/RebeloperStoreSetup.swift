//
//  RebeloperStoreSetup.swift
//
//  Created by Alex Nagy on 22/09/2016.
//  Copyright © 2016 Rebeloper. All rights reserved.
//
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.


/*
 
 When creating your IAP ID make sure it conforms to the following formula:
 
 "AppBundleID.IAPName"
 
 Ex. "com.Rebeloper.SwiftySubscriptions.autoRenewablePurchase"
 
 where "com.Rebeloper.SwiftySubscriptions" is the AppBundleID
   and "autoRenewablePurchase" is the IAPName
 
 */

// provide your Shared Secret if you use Renewable purchases
let SharedSecret = "3ffcd26bef2b4ea4bc2b9a25e2a6bff9"

let KeychainSecret = "ea4bc2b9a25e2a6bff93ffcd26bef2b4" // IMPORTANT: once your app is on the App Store DO NOT CHANGET this because users who update your app with the new value will lose all of their Virtual Purchases
let resetKeychainToDefaultValues = false // IMPORTANT: set this to 'false' before release
let shouldLogRebeloperStoreKeychainAccount = true

// set up your In-app Purchases and Virtual Purchases

// -------------------------- IAPs --------------------------

// non renewable subscription purchases
enum NonRenewablePurchaseName : String {
  
  case nonRenewableSubscription1 = "nonRenewableSubscription1"
  
}

let NonRenewablePurchases = [NonRenewablePurchaseName.nonRenewableSubscription1]

// set the duration of the non-renewing subscription(s): '3600 * 24 * 30' is one month in seconds
let NonRenewablePurchasesSubscritionAmount = [3600 * 24 * 30]

// renewable purchases
enum RenewablePurchaseName : String {
  
  case autoRenewableSubscription1 = "group1.autoRenewableSubscription1"
  case autoRenewableSubscription2 = "group1.autoRenewableSubscription2"
  case autoRenewableSubscription3 = "group1.autoRenewableSubscription3"
  
  case autoRenewableSubscription4 = "group2.autoRenewableSubscription1"
  
}

let RenewablePurchases = [RenewablePurchaseName.autoRenewableSubscription1,
                          RenewablePurchaseName.autoRenewableSubscription2,
                          RenewablePurchaseName.autoRenewableSubscription3,
                          RenewablePurchaseName.autoRenewableSubscription4]


// regular purchases
enum RegularPurchaseName : String {
  
  case nonConsumable1 = "nonConsumable1"
  case nonConsumable2 = "nonConsumable2"
  
}

let RegularPurchases = [RegularPurchaseName.nonConsumable1,
                        RegularPurchaseName.nonConsumable2]

// Virtual currency purchases
enum VirtualCurrencyPurchaseName : String {
  
  case virtualCurrencyPackConsumable1 = "virtualCurrencyPackConsumable1"
  case virtualCurrencyPackConsumable2 = "virtualCurrencyPackConsumable2"
  
}

let VirtualCurrencyPurchases = [VirtualCurrencyPurchaseName.virtualCurrencyPackConsumable1,
                                VirtualCurrencyPurchaseName.virtualCurrencyPackConsumable2]

let VirtualCurrencyPurchasesAmount = ["30",
                                      "60"]

// -------------------------- VPs --------------------------
// virtual purchases
enum VirtualPurchasesName : String {
  
  case virtualGood1 = "virtualNonConsumableGood1"
  case virtualGood2 = "virtualConsumableGood2"
  case virtualGood3 = "virtualNonConsumableGood3"
  
}

let VirtualPurchases = [VirtualPurchasesName.virtualGood1,
                        VirtualPurchasesName.virtualGood2,
                        VirtualPurchasesName.virtualGood3]

let VirtualPurchasesAmountToGiveOnFirstLaunch = ["0",
                                                 "10",
                                                 "0"]

// virtual currencies
enum VirtualCurrenciesName : String {
  
  case primaryVirtualCurrency = "primaryVirtualCurrency"
  case secondaryVirtualCurrency = "secondaryVirtualCurrency"
  
}

let VirtualCurrencies = [VirtualCurrenciesName.primaryVirtualCurrency,
                         VirtualCurrenciesName.secondaryVirtualCurrency]

let VirtualCurrenciesAmountToGiveOnFirstLaunch = ["1000",
                                                  "50"]
















