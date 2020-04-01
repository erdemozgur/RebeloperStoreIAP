//
//  VirtualGoodsShopViewController.swift
//  SwiftySubscriptions
//
//  Created by Alex Nagy on 23/09/2016.
//  Copyright © 2016 Rebeloper. All rights reserved.
//

import UIKit

class VirtualGoodsShopViewController: UIViewController {
  
  @IBOutlet weak var coinsLabel: UILabel!
  @IBOutlet weak var gemsLabel: UILabel!
  @IBOutlet weak var virtualConsumablesLabel: UILabel!
  @IBOutlet weak var virtualNonConsumable1Title: UILabel!
  @IBOutlet weak var virtualNonConsumable1Description: UILabel!
  @IBOutlet weak var virtualNonConsumable1Button: CustomButton!
  @IBOutlet weak var virtualConsumableTitle: UILabel!
  @IBOutlet weak var virtualConsumableDescription: UILabel!
  @IBOutlet weak var virtualNonConsumable2Title: UILabel!
  @IBOutlet weak var virtualNonConsumable2Description: UILabel!
  @IBOutlet weak var virtualNonConsumable2Button: CustomButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  func updateUI() {
    
  }
  
  @IBAction func backButtonTapped(_ sender: AnyObject) {
    self.dismiss(animated: true) {
      print("Going Back")
    }
  }

  @IBAction func purchaseVirtualNonConsumableButtonTapped1(_ sender: AnyObject) {
    
  }
  
  @IBAction func purchaseVirtualConsumableButtonTapped(_ sender: AnyObject) {
    
  }
  
  @IBAction func consumeVirtualConsumable(_ sender: AnyObject) {
    
  }
  
  @IBAction func purchaseVirtualNonConsumableButtonTapped2(_ sender: AnyObject) {
    
  }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
