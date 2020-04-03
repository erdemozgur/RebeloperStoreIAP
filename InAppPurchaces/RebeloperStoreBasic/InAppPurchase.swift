//
//  InAppPurchase.swift
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

struct InAppPurchase {
    
    var id: String
    var imageUrl: String
    var registeredPurchase: RegisteredPurchase
    var title: String
    var description: String
    var price: String
    
    var dictionary: [String: Any] {
        return [
            "id": id,
            "imageUrl": imageUrl,
            "registeredPurchase": registeredPurchase,
            "title": title,
            "description": description,
            "price": price
        ]
    }
    
}

extension InAppPurchase: DocumentSerializable {
    init?(documentData: [String : Any]) {
        let id = documentData["id"] as? String ?? ""
        let imageUrl = documentData["imageUrl"] as? String ?? ""
        let registeredPurchase = documentData["registeredPurchase"] as! RegisteredPurchase
        let title = documentData["title"] as? String ?? ""
        let description = documentData["description"] as? String ?? ""
        let price = documentData["price"] as? String ?? ""
        
        self.init(id: id,
                  imageUrl: imageUrl,
                  registeredPurchase: registeredPurchase,
                  title: title,
                  description: description,
                  price: price)
    }
}

extension InAppPurchase: CustomDebugStringConvertible {
    var debugDescription: String {
        return "InAppPurchase(dictionary: \(dictionary))"
    }
}
