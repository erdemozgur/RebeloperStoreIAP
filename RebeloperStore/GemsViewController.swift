//
//  GemsViewController.swift
//  SwiftySubscriptions
//
//  Created by Alex Nagy on 23/09/2016.
//  Copyright © 2016 Rebeloper. All rights reserved.
//

import UIKit

class GemsViewController: UIViewController {
  
  @IBOutlet weak var coinsLabel: UILabel!
  @IBOutlet weak var gemsLabel: UILabel!
  @IBOutlet weak var virtualConsumable1Title: UILabel!
  @IBOutlet weak var virtualConsumable1Description: UILabel!
  @IBOutlet weak var virtualConsumable2Title: UILabel!
  @IBOutlet weak var virtualConsumable2Description: UILabel!

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

  @IBAction func purchaseVirtualConsumableButtonTapped1(_ sender: AnyObject) {
    
  }
  
  @IBAction func purchaseVirtualConsumableButtonTapped2(_ sender: AnyObject) {
    
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
