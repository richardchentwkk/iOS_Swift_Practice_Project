//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Chen Richard on 2016/5/2.
//  Copyright © 2016年 Chen Richard. All rights reserved.
//

import Foundation

class CalculatorBrain {
    private var accumulator = 0.0
    private var internalProgram = [AnyObject]()
    
    func setOperand(operand: Double){
        accumulator = operand
    }
    
    var operations: Dictionary<String,Operation> = [
        "π":Operation.Constant(M_PI),
        "e":Operation.Constant(M_E),
        "√":Operation.UnaryOperation(sqrt),
        "cos":Operation.UnaryOperation(cos),
        "×":Operation.BinaryOperation({$0 * $1}),
        "÷":Operation.BinaryOperation({$0 / $1}),
        "+":Operation.BinaryOperation({$0 + $1}),
        "−":Operation.BinaryOperation({$0 - $1}),
        "=":Operation.Equals
    ]
    
    enum Operation{
        case Constant(Double)
        case UnaryOperation((Double)->Double)
        case BinaryOperation((Double,Double)->Double)
        case Equals
    }
    
    func performOperation(symbol:String){
        internalProgram.append(symbol)
        if let operation = operations[symbol]{
            switch operation {
            case .Constant(let value):
                accumulator = value
            case .UnaryOperation(let function):
                accumulator = function(accumulator)
            case .BinaryOperation(let function):
                executePendingOpeartion()
                pending = PendingBinaryOperationInfo(binaryOpeation: function, firstOperation: accumulator)
            case .Equals:
                executePendingOpeartion()
            }
        }
    }
    
    private func executePendingOpeartion()
    {
        if pending != nil {
            accumulator = pending!.binaryOpeation(pending!.firstOperation,accumulator)
            pending = nil
        }
    }
    
    private var pending: PendingBinaryOperationInfo?
    
    struct PendingBinaryOperationInfo {
        var binaryOpeation: (Double,Double)->Double
        var firstOperation: Double
    }
    
    typealias ProperityList = AnyObject
    var program: ProperityList{
        get{
            return internalProgram
        }
        set{
            clear()
        }
    }
    
    func clear(){
        accumulator = 0.0
        pending = nil
        internalProgram.removeAll()
    }
    
    var result: Double{
        get{
            return accumulator
        }
    }
}