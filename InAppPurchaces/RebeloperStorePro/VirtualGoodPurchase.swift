//
//  VirtualGoodPurchase.swift
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

import Foundation

struct VirtualGoodPurchase {
    
    var imageUrl: String
    var title: String
    var description: String
    var virtualGood: VirtualGood
    var forVirtualGood: VirtualGood
    var amount: Int
    var forAmount: Int
    
    var dictionary: [String: Any] {
        return [
            "imageUrl": imageUrl,
            "title": title,
            "description": description,
            "virtualGood": virtualGood,
            "forVirtualGood": forVirtualGood,
            "amount": amount,
            "forAmount": forAmount
        ]
    }
    
}

extension VirtualGoodPurchase: DocumentSerializable {
    init?(documentData: [String : Any]) {
        let imageUrl = documentData["imageUrl"] as? String ?? ""
        let title = documentData["title"] as? String ?? ""
        let description = documentData["description"] as? String ?? ""
        let virtualGood = documentData["virtualGood"] as! VirtualGood
        let forVirtualGood = documentData["forVirtualGood"] as! VirtualGood
        let amount = documentData["amount"] as? Int ?? 0
        let forAmount = documentData["forAmount"] as? Int ?? 0
        
        self.init(imageUrl: imageUrl,
                  title: title,
                  description: description,
                  virtualGood: virtualGood,
                  forVirtualGood: forVirtualGood,
                  amount: amount,
                  forAmount: forAmount)
    }
}

extension VirtualGoodPurchase: CustomDebugStringConvertible {
    var debugDescription: String {
        return "VirtualGoodPurchase(dictionary: \(dictionary))"
    }
}
