//
//  RegisteredPurchase.swift
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

struct RegisteredPurchase {
    
    var imageUrl: String
    var sufix: PurchaseSufix
    var purchaseType: RebeloperStore.PurchaseType
    
    var dictionary: [String: Any] {
        return [
            "imageUrl": imageUrl,
            "sufix": sufix,
            "purchaseType": purchaseType
        ]
    }
    
}

extension RegisteredPurchase: DocumentSerializable {
    init?(documentData: [String : Any]) {
        let imageUrl = documentData["imageUrl"] as? String ?? ""
        let sufix = documentData["sufix"] as? PurchaseSufix ?? ""
        let purchaseType = documentData["purchaseType"] as! RebeloperStore.PurchaseType
        
        self.init(imageUrl: imageUrl,
                  sufix: sufix,
                  purchaseType: purchaseType)
    }
}

extension RegisteredPurchase: CustomDebugStringConvertible {
    var debugDescription: String {
        return "RegisteredPurchase(dictionary: \(dictionary))"
    }
}

