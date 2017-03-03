//
//  ViewController.swift
//  Calculator
//
//  Created by Chen Richard on 2016/5/2.
//  Copyright © 2016年 Chen Richard. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var display: UILabel!
    
    var userIsIntheMiddleOfTyping = false
    
    @IBAction func touchDigit(sender: UIButton){
        let digit = sender.currentTitle!
        if userIsIntheMiddleOfTyping{
            let textCurentlyInDisplay = display.text!
            display.text = textCurentlyInDisplay + digit
        }else{
            display.text = digit
        }
        userIsIntheMiddleOfTyping = true
    }
    
    var displayValue: Double{
        get{
            return Double(display.text!)!
        }
        set{
            display.text = String(newValue)
        }
    }
    
    private var brain = CalculatorBrain()
    @IBAction func performOperation(sender: UIButton) {
        if userIsIntheMiddleOfTyping {
            brain.setOperand(displayValue)
            userIsIntheMiddleOfTyping = false
        }
        if let mathmaticalSymbol = sender.currentTitle{
            brain.performOperation(mathmaticalSymbol)
        }
        displayValue = brain.result
    }

    

}

