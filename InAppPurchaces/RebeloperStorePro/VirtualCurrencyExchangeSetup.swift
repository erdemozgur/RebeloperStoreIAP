//
//  VirtualGoodExchangeSetup.swift
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

extension VirtualGoodExchange {
    
    // -----------------------------------------------------------------------------
    //
    // 1. Virtual Goods can be of two types "consumable" and "non-consumable".
    // Consumables are most probably going to be some sort of Virtual Currency in your app.
    // Non-consumables are going to be items like shields or swords.
    // Consumables can be consumed, non-consumables cannot!
    //
    // 2. Image urls are optional. They can be:
    //  a). none -> enter an emty String: ""
    //  b). in an asset catalog -> enter the name / path of the image
    //  c). a url -> enter the url of the image; has to be https!
    //
    // Now add your virtual goods below.
    
    static let coin = VirtualGood(imageUrl: "Icon-1024", name: "coin", description: "The primary virtual currency", type: .consumable)
    static let gem = VirtualGood(imageUrl: "Icon-1024", name: "gem", description: "The secondary virtual currency", type: .consumable)
    static let diamond = VirtualGood(imageUrl: "Icon-1024", name: "diamond", description: "Another virtual currency", type: .consumable)
    static let shield = VirtualGood(imageUrl: "Icon-1024", name: "shield", description: "Non-consumable virtual good.", type: .nonConsumable)
    static let sword = VirtualGood(imageUrl: "Icon-1024", name: "sword", description: "Another non-consumable virtual good.", type: .nonConsumable)
    
    // -----------------------------------------------------------------------------
    // Create a list of your virtual goods.
    
    static var virtualGoods: [VirtualGood] = [
        coin,
        gem,
        diamond,
        shield,
        sword
    ]
    
    // -----------------------------------------------------------------------------
    // Create a list of all the virtual goods specifying
    // how much you wan tot give to the user upon first launch.
    
    static let giveVirtualCurreciesOnFirstLaunch = [
        GiveVirtualGoodOnFirstLaunch(virtualGood: coin, amount: 100),
        GiveVirtualGoodOnFirstLaunch(virtualGood: gem, amount: 50),
        GiveVirtualGoodOnFirstLaunch(virtualGood: diamond, amount: 10),
        GiveVirtualGoodOnFirstLaunch(virtualGood: shield, amount: 0),
        GiveVirtualGoodOnFirstLaunch(virtualGood: sword, amount: 0)
    ]
    
    // -----------------------------------------------------------------------------
    // When set to "true" you will find detailed logs in your console
    // when you're testing your virtual good purchases.
    // Very usefull for debugging! Set it to "false" to turn it off.
    
    static let shouldLogVirtualGoodExchange = true
    
}
