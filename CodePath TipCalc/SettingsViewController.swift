//
//  SettingsViewController.swift
//  CodePath TipCalc
//
//  Created by Timothy Lee on 8/24/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit



class SettingsViewController: UIViewController {
    
    @IBOutlet var confirmationLabel: UILabel!
    @IBOutlet var defaultTipOutlet: UISegmentedControl!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
            var prefs = NSUserDefaults.standardUserDefaults()
                    
            if let currentSetting: AnyObject = prefs.valueForKey("defaultTipSetting") {
                self.defaultTipOutlet.selectedSegmentIndex = prefs.integerForKey("defaultTipSetting")
                }
        confirmationLabel.alpha = 0
        
    }
    
    @IBAction func defaultTipAction(sender: UISegmentedControl) {
        
        var tipIndex = self.defaultTipOutlet.selectedSegmentIndex
        
        var prefs = NSUserDefaults.standardUserDefaults()
        
        prefs.setInteger(self.defaultTipOutlet.selectedSegmentIndex, forKey: "defaultTipSetting")
        
        self.confirmationLabel.alpha = 0
        UIView.animateWithDuration(0.8, animations: {
        self.confirmationLabel.alpha = 1
        })
        
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    


}
