//
//  VirtualGood.swift
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

struct VirtualGood {
    
    var imageUrl: String
    var name: String
    var description: String
    var type: VirtualGoodType
    
    var dictionary: [String: Any] {
        return [
            "imageUrl": imageUrl,
            "name": name,
            "description": description,
            "type": type
        ]
    }
    
}

extension VirtualGood: DocumentSerializable {
    init?(documentData: [String : Any]) {
        let imageUrl = documentData["imageUrl"] as? String ?? ""
        let name = documentData["name"] as? String ?? ""
        let description = documentData["description"] as? String ?? ""
        let type = documentData["type"] as! VirtualGoodType
        
        self.init(imageUrl: imageUrl,
                  name: name,
                  description: description,
                  type: type)
    }
}

extension VirtualGood: CustomDebugStringConvertible {
    var debugDescription: String {
        return "VirtualGood(dictionary: \(dictionary))"
    }
}

