//
//  ViewController.swift
//  CodePath TipCalc
//
//  Created by Timothy Lee on 8/24/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    @IBOutlet var billField: UITextField!
    @IBOutlet var tipLabel: UILabel!
    @IBOutlet var totalLabel: UILabel!
    @IBOutlet var tipControl: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //load NSUser and select default tip setting
        let prefs = NSUserDefaults.standardUserDefaults()
        tipControl.selectedSegmentIndex = prefs.integerForKey("defaultTipSetting")
        
        // test if a previous total exists within the last 10 minutes
        if (prefs.valueForKey("SavedDateTime")?.timeIntervalSinceNow) > -600 {
            tipLabel.text = prefs.stringForKey("tipLabelSaved")
            totalLabel.text = prefs.stringForKey("totalLabelSaved")
            tipControl.selectedSegmentIndex = prefs.integerForKey("tipPercentageSaved")
        } else {
            totalLabel.text = "00.00"
            tipLabel.text = "00.00"
        }
        
        // select billField on load
        self.billField.becomeFirstResponder()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onEditingChanged(sender: AnyObject) {
        var tipPercentages = [0.18, 0.2, 0.22]
        var tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        
        var billAmount = (billField.text as NSString).doubleValue
        var tip = billAmount * tipPercentage
        var total = billAmount + tip
        
        tipLabel.text = "$\(tip)"
        totalLabel.text = "$\(total)"
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        
        //save tip, total and current time
        var prefs = NSUserDefaults.standardUserDefaults()
        prefs.setValue(tipLabel.text, forKey: "tipLabelSaved")
        prefs.setValue(totalLabel.text, forKey: "totalLabelSaved")
        prefs.setValue(tipControl.selectedSegmentIndex, forKey: "tipPercentageSaved")
        prefs.setObject(NSDate(), forKey: "SavedDateTime")
        
    }
    
    override func viewDidAppear(animated: Bool) {
        //set tipControl to default (if >10 mins)
        let prefs = NSUserDefaults.standardUserDefaults()
        if (prefs.valueForKey("SavedDateTime")?.timeIntervalSinceNow) < -599 {
            tipControl.selectedSegmentIndex = prefs.integerForKey("defaultTipSetting")
            }
    }   

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
}

