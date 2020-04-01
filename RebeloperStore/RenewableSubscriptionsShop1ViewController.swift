//
//  RenewableSubscriptionsShop1ViewController.swift
//  SwiftySubscriptions
//
//  Created by Alex Nagy on 21/09/2016.
//  Copyright © 2016 Rebeloper. All rights reserved.
//

import UIKit

class RenewableSubscriptionsShop1ViewController: UIViewController {

  @IBOutlet weak var contentStatusLabel: UILabel!
  @IBOutlet weak var contentImageView: UIImageView!
  @IBOutlet weak var autoRenewableSubscriptionTitle: UILabel!
  @IBOutlet weak var autoRenewableSubscriptionDescription: UILabel!
  @IBOutlet weak var subscriptionAvailabilityDateLabel1: UILabel!
  @IBOutlet weak var subscriptionAvailabilityDateLabel2: UILabel!
  @IBOutlet weak var subscriptionAvailabilityDateLabel3: UILabel!
  @IBOutlet weak var subscriptionAvailabilityDateLabel4: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
  }
  
  func updateUI() {
    
  }
  
  @IBAction func backButtonTapped(_ sender: AnyObject) {
    self.dismiss(animated: true) {
      print("Going Back")
    }
  }

  @IBAction func purchaseAutoRenewableSubscriptionButtonTapped1(_ sender: AnyObject) {
    
  }
  
  @IBAction func purchaseAutoRenewableSubscriptionButtonTapped2(_ sender: AnyObject) {
    
  }
  
  @IBAction func purchaseAutoRenewableSubscriptionButtonTapped3(_ sender: AnyObject) {
    
  }
  
  @IBAction func purchaseNonRenewableSubscriptionButtonTapped(_ sender: AnyObject) {
    
  }

}

