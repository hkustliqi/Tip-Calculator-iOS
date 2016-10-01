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
    @IBOutlet weak var TwoWayLabel: UILabel!
    @IBOutlet weak var ThreeWayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // read default tip percent
        let defaults = UserDefaults.standard
        let default_percent = defaults.integer(forKey: "default_tip")
        tipControl.selectedSegmentIndex = default_percent
        doCalu()
        
        let last_bill = defaults.integer(forKey: "last_bill")
        if (last_bill != 0) {
            let formatter = NumberFormatter()
            billField.text = formatter.string(for: last_bill)
        }
        // on start up only show bill
        if (billField.text == "") {
            TipView.alpha = 0
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // show keyboard
        billField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func OnTap(_ sender: AnyObject) {
        //view.endEditing(true)
    }
    
    @IBAction func CalculateTip(_ sender: AnyObject) {
        doCalu()
    }
    
    func doCalu() {
        let tipPercent = [0.18, 0.2, 0.25]
        let bill = Double(billField.text!) ?? 0
        let tip = bill * tipPercent[tipControl.selectedSegmentIndex]
        let total = bill + tip
        let twoWaySplit = total/2
        let threeWaySplit = total/3
        
        let defaults = UserDefaults.standard
        defaults.set(bill, forKey: "last_bill")
        defaults.synchronize()
        
        //  locale specific currency and currency thousands separator
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2 ;
        tipLabel.text = formatter.string(for: tip)
        totalLabel.text = formatter.string(for: total)
        TwoWayLabel.text = formatter.string(for: twoWaySplit)
        ThreeWayLabel.text = formatter.string(for: threeWaySplit)
        
        // animation for TipView
        UIView.animate(withDuration: 0.6, animations: {
            self.TipView.alpha = 1
        })
    }
    
    

}

