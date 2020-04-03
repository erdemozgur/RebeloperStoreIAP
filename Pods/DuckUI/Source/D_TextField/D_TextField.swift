//
//  D_TextField.swift
//  DuckUI
//
//  Created by Alex Nagy on 16/06/2019.
//

import UIKit

open class D_TextField: UITextField {
    
    public let insets: UIEdgeInsets
    
    public init(insets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)) {
        self.insets = insets
        super.init(frame: .zero)
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}




