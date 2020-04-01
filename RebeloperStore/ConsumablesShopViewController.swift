//
//  ConsumablesShopViewController.swift
//  SwiftySubscriptions
//
//  Created by Alex Nagy on 23/09/2016.
//  Copyright © 2016 Rebeloper. All rights reserved.
//

import UIKit

class ConsumablesShopViewController: UIViewController {
  
  @IBOutlet weak var coinsLabel: UILabel!
  @IBOutlet weak var consumable1Title: UILabel!
  @IBOutlet weak var consumable1Description: UILabel!
  @IBOutlet weak var consumable2Title: UILabel!
  @IBOutlet weak var consumable2Description: UILabel!
  //test

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

  @IBAction func purchaseConsumableButtonTapped1(_ sender: AnyObject) {
    
  }
  
  @IBAction func purchaseConsumableButtonTapped2(_ sender: AnyObject) {
    
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
