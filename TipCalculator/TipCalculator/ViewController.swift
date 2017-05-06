//
//  ViewController.swift
//  TipCalculator
//
//  Created by Di Hoang on 5/3/17.
//  Copyright © 2017 Di Hoang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var splitTipSlider: UISlider!
    @IBOutlet weak var splitNumberLabel: UILabel!
    @IBOutlet weak var totalEachLabel: UILabel!
    @IBOutlet weak var invalidAmountLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    
    // Access UserDefaults
    let defaults = UserDefaults.standard
    let locale = Locale.current
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeCurrencyLabel()

        billField.becomeFirstResponder()
        invalidAmountLabel.text = "Enter bill amount"
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initializeCurrencyLabel() {
        let currencySymbol = locale.currencySymbol
        currencyLabel.text = currencySymbol ?? ""
        tipLabel.text = "\(locale.currencySymbol ?? "") 0.00"
        totalLabel.text = "\(locale.currencySymbol ?? "") 0.00"
        totalEachLabel.text = "\(locale.currencySymbol ?? "") 0.00"
    }

    /* tapping anywhere outside the textfield */
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }

    @IBAction func calculateTip(_ sender: AnyObject) {
        // Get a Double value.
        let defaultTipValue = defaults.double(forKey: "defaultTip")
        
        splitNumberLabel.text = String(describing: Int(splitTipSlider.value))
        
        let tipPercentages = [defaultTipValue/100, 0.15, 0.18, 0.2]
        
        /* Double conversion returns nil, default to 0 */
        
        let bill = Double(billField.text!)
        
        /* if text is empty, don't show error label */
        if (billField.text == "") {
            invalidAmountLabel.text = "Enter bill amount"
            initializeCurrencyLabel()
        }
        
        /* make sure bill is a positive number */
        else if (bill != nil) {
            
            if (bill! > 0.0) {
            
                invalidAmountLabel.text = ""
                
                let tip = bill! * tipPercentages[tipControl.selectedSegmentIndex]
                let total = bill! + tip
        
                /* anything inside parenthesis, change into its value */
                tipLabel.text = String(format: "\(locale.currencySymbol ?? "") %.2f", tip)
                totalLabel.text = String(format: "\(locale.currencySymbol ?? "") %.2f", total)
                totalEachLabel.text = String(format: "\(locale.currencySymbol ?? "") %.2f", total / Double(Int(splitTipSlider.value)))
            }
            
            else {
            invalidAmountAnimation(textField: billField, message: "Amount must be positive")
            }
        }
        /* they entered a nonnumber */
        else {
            invalidAmountAnimation(textField: billField, message: "Amount must be a number")
        }
    }
    
    /* function to animate springing textfield */
    func invalidAmountAnimation(textField: UITextField, message: String) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.08
        animation.repeatCount = 1
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: textField.center.x - 10, y: textField.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: textField.center.x + 10, y: textField.center.y))
        textField.layer.add(animation, forKey: "position")
        
        invalidAmountLabel.text = message
    }
    
    /* update new values after saving default tip */
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        calculateTip(self)
        billField.becomeFirstResponder()
    }
}

