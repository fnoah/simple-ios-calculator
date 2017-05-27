//
//  ViewController.swift
//  CS193_Calculator
//
//  Created by Noah Fleischmann on 29.04.17.
//  Copyright © 2017 Noah Fleischmann. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var sequence: UILabel!
    
    var userIsTyping = false
    
    var displayValue: Double {
        get {
            let formatter = NumberFormatter()
            formatter.decimalSeparator = "."
            let formatedString = formatter.number(from: display.text!)
            return Double(formatedString!)
        }
        set {
            display.text = String(newValue)
        }
    }
    
    private var logic = CalculatorLogic()
    
    @IBAction func digitTouched(_ sender: UIButton) {
        if let digit = sender.currentTitle {
            if !logic.floatingPointIsSet || digit != "." {
                if userIsTyping {
                    let textInDisplay = display.text!
                    display.text = textInDisplay + digit
                }
                else {
                    display.text = digit
                    userIsTyping = true
                }
            }
            if digit == "." {
               logic.floatingPointIsSet = true
            }
        }
    }

    
    @IBAction func performOperation(_ sender: UIButton) {
        if userIsTyping {
            logic.setOperand(displayValue)
            userIsTyping = false
        }
        if let mathematicalSymbol = sender.currentTitle {
            logic.performOperation(mathematicalSymbol)
            }
        if let result = logic.result {
            displayValue = result
        }
    }
}
