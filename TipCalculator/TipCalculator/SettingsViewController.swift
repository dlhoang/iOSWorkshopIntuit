//
//  SettingsViewController.swift
//  TipCalculator
//
//  Created by Di Hoang on 5/3/17.
//  Copyright © 2017 Di Hoang. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var defaultTipField: UITextField!
    
    //Access UserDefaults
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        defaultTipField.becomeFirstResponder()
        
        // Do any additional setup after loading the view.
        let tipValue = defaults.double(forKey: "defaultTip")
        defaultTipField.text = String(describing: tipValue)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func saveDefaultTip(_ sender: Any) {
        
        /* if they entered a number, good to go */
        if Double(self.defaultTipField.text!) != nil {
            
            /* make sure user wants to set tip */
            let alertController = UIAlertController(title: "Set Default Tip?", message:
                "Default tip will be set to \(defaultTipField.text!)%.", preferredStyle: UIAlertControllerStyle.alert)
            
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: {(action: UIAlertAction!) in
                
                let defaultTip = Double(self.defaultTipField.text!)
            
                // Set a Double value for some key.
                self.defaults.set(defaultTip, forKey: "defaultTip")
            
                // Force UserDefaults to save.
                self.defaults.synchronize()
            }))
            
            alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler:nil))
            
            self.present(alertController, animated: true, completion: nil)
        }
        
        /* if they didn't enter number, don't let them save it */
        else {
            let alertController = UIAlertController(title: "Tip must be a number!", message:
                "Enter a number for default tip value.", preferredStyle: UIAlertControllerStyle.alert)
            
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
