//
//  ViewController.swift
//  Swift Tip Calculator
//
//  Created by Mirko Cukich on 8/3/19.
//  Copyright © 2019 Digital Mirko. All rights reserved.
//
//  Swift Tip Calculator - Demo 3 of 30

import UIKit

class ViewController: UIViewController {
    
    // Entered Amount
    @IBOutlet weak var mainAmountTextField: UITextField!
    // Tip Amount
    @IBOutlet weak var tipAmountLabel: UILabel!
    // Total Amount
    @IBOutlet weak var totalAmountLabel: UILabel!
    // Segmented Control
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    
    // number formatter
    var numberFormatter = NumberFormatter()
    // tip model
    var tipModel = TipModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // type of currency - U.S. Dollars
        numberFormatter.currencySymbol = "$"
        // floats can be used with NumberFormatter
        numberFormatter.allowsFloats = true
        
        // dismiss keyboard, tap gesture
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapOnScreen(_:)))
        // add gesture to view
        self.view.addGestureRecognizer(tapGesture)
        
    }
    
    
    @objc func didTapOnScreen(_ sender: UITapGestureRecognizer){
        self.view.endEditing(true)
    }
  
    
    func setTipsToUI(tipTouple:(tipAmount: Double, totalAmount: Double)) {
        self.tipAmountLabel.text = String.init(format: "$%0.2f", tipTouple.tipAmount)
        self.totalAmountLabel.text = String.init(format: "$%0.2f", tipTouple.totalAmount)
        
    }
    
    // gives us the percentage back, returns a double
    func segmentToTipPercent(index: Int) -> Double {
        switch index {
        case 0:
            return 0.10
        case 1:
            return 0.15
        case 2:
            return 0.18
        case 3:
            return 0.20
        default:
            return 0.18
        }
    }
    
    @IBAction func didChangeSegment(_ sender: UISegmentedControl) {
        if let number = numberFormatter.number(from: mainAmountTextField.text!) {
            tipModel.mainAmount = number.doubleValue
            tipModel.tipPercentage = segmentToTipPercent(index: sender.selectedSegmentIndex)
            setTipsToUI(tipTouple: tipModel.calculateTipAmount())
        }
    }
    
    // slider action
    @IBAction func valueChangedSlider(_ sender: UISlider) {
        if let number = numberFormatter.number(from: mainAmountTextField.text!) {
            tipModel.mainAmount = number.doubleValue
            tipModel.tipPercentage = Double(sender.value)
            setTipsToUI(tipTouple: tipModel.calculateTipAmount())
        }
        
    }
        
        @IBAction func didEnterAmount(_ sender: UITextField){
            if let number = numberFormatter.number(from: mainAmountTextField.text!) {
                tipModel.mainAmount = number.doubleValue
                tipModel.tipPercentage = segmentToTipPercent(index: segmentControl.selectedSegmentIndex)
                setTipsToUI(tipTouple: tipModel.calculateTipAmount())
        }
    
}


class TipModel {
    
    var mainAmount: Double?
    
    var tipPercentage: Double?
    
    // calculation returns tuple
    func calculateTipAmount() -> (tipAmount: Double, totalAmount: Double) {
        guard let mainAmount = mainAmount, let tipPercent = tipPercentage else {
            return(0.0,0.0)
        }
        // returns Tip Amount and Total Amount
        return(mainAmount * tipPercent, (mainAmount * tipPercent) + mainAmount)
    }
    
  }
}

