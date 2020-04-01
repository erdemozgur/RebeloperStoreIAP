//
//  CustomButton.swift
//  SwiftySubscriptions
//
//  Created by Alex Nagy on 23/09/2016.
//  Copyright © 2016 Rebeloper. All rights reserved.
//

import Foundation
import UIKit

class CustomButton: UIButton {
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)!
    self.layer.cornerRadius = 5.0;
    self.layer.borderColor = UIColor.darkGray.cgColor
    self.layer.borderWidth = 1.5
    self.clipsToBounds = true
  }
}
