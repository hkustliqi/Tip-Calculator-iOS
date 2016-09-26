//
//  ViewController.swift
//  tippy
//
//  Created by Qi Li on 9/21/16.
//  Copyright © 2016 Qi Li. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var TipView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // read default tip percent
        let defaults = NSUserDefaults.standardUserDefaults()
        let default_percent = defaults.integerForKey("default_tip")
        tipControl.selectedSegmentIndex = default_percent

        // on start up only show bill
        if (billField.text == "") {
            TipView.alpha = 0
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        // show keyboard
        billField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func OnTap(sender: AnyObject) {
        //view.endEditing(true)
    }
    
    @IBAction func CalculateTip(sender: AnyObject) {
        let tipPercent = [0.18, 0.2, 0.25]
        let bill = Double(billField.text!) ?? 0
        let tip = bill * tipPercent[tipControl.selectedSegmentIndex]
        let total = bill + tip
        
        
        //  locale specific currency and currency thousands separator
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        formatter.maximumFractionDigits = 2 ;
        tipLabel.text = formatter.stringFromNumber(tip)!
        totalLabel.text = formatter.stringFromNumber(total)!
        
        // animation for TipView
        UIView.animateWithDuration(0.6, animations: {
            self.TipView.alpha = 1
        })
    }

}

