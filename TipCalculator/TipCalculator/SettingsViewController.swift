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
    @IBOutlet weak var invalidTipLabel: UILabel!
    
    //Access UserDefaults
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        defaultTipField.becomeFirstResponder()
        invalidTipLabel.text = ""
        
        // Do any additional setup after loading the view.
        let tipValue = defaults.double(forKey: "defaultTip")
        defaultTipField.text = String(describing: tipValue)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /* tapping anywhere besides the textfield */
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func saveDefaultTip(_ sender: Any) {
        
        /* if they entered a number, good to go */
        if Double(self.defaultTipField.text!) != nil {
            
            if (Double(self.defaultTipField.text!)! >= 0.0) {
                invalidTipLabel.text = ""
                
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
            else {
                invalidAmountAnimation(textfield: defaultTipField, message: "Amount must be positive")
            }
        }
        
        /* if they didn't enter number, don't let them save it */
        else {
            invalidAmountAnimation(textfield: defaultTipField, message: "Tip amount must be a number")
        }
    }
    
    /* springing animation for invalid textfield */
    func invalidAmountAnimation(textfield: UITextField, message: String) {
        
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.08
        animation.repeatCount = 1
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: textfield.center.x - 10, y: textfield.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: textfield.center.x + 10, y: textfield.center.y))
        textfield.layer.add(animation, forKey: "position")
        
        invalidTipLabel.text = message
        
    }
}
