//
//  FacialExpression.swift
//  FaceIt
//
//  Created by Chen Richard on 2016/5/9.
//  Copyright © 2016年 Chen Richard. All rights reserved.
//

import Foundation

//UI independnt representation of a facial expression

struct FacialExpression {
    
    enum Eyes: Int{
        case Open
        case Closed
        case Squinting
    }
    
    enum EyeBrows: Int{
        case Relaxed
        case Normal
        case Furrowed
        
        func moreRelaxedBrow() -> EyeBrows{
            return EyeBrows(rawValue: rawValue - 1) ?? .Relaxed
        }
        
        func moreFurrowedBrow() -> EyeBrows{
            return EyeBrows(rawValue: rawValue + 1) ?? .Furrowed
        }
    }
    
    enum Mouth: Int {
        case Frown
        case Smirk
        case Neutral
        case Grin
        case Smile
        
        func sadderMouth() -> Mouth{
            return Mouth(rawValue: rawValue - 1) ?? .Frown
        }
        
        func happierMouth() -> Mouth{
            return Mouth(rawValue: rawValue + 1) ?? .Smile
        }
    }
    
    var eyes: Eyes
    var eyeBrows: EyeBrows
    var mouth: Mouth
    
}