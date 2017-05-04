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
    
    // Access UserDefaults
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        billField.becomeFirstResponder()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }

    @IBAction func calculateTip(_ sender: AnyObject) {
        
        // Get a Double value.
        let defaultTipValue = defaults.double(forKey: "defaultTip")
        
        let tipPercentages = [defaultTipValue/100, 0.15, 0.18, 0.2]
        
        /* Double conversion returns nil, default to 0 */
        let bill = Double(billField.text!) ?? 0
        
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
        
        /* anything inside parenthesis, change into its value */
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        calculateTip(self)
        billField.becomeFirstResponder()
    }
}

