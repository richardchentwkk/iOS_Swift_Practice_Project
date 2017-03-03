//
//  ViewController.swift
//  FaceIt
//
//  Created by Chen Richard on 2016/5/7.
//  Copyright © 2016年 Chen Richard. All rights reserved.
//

import UIKit

class FaceViewController: UIViewController {
    
    //Default expression
    var expression = FacialExpression(eyes: .Closed, eyeBrows: .Normal, mouth: .Frown){
        didSet{
            updateUI()
        }
    
    }
    
    @IBAction func toogleEyes(recognizer: UITapGestureRecognizer) {
        if recognizer.state == .Ended{
            switch expression.eyes {
            case .Open: expression.eyes = .Closed
            case .Closed: expression.eyes = .Open
            case .Squinting: break
            }
        }
    }
    @IBOutlet weak var faceView: FaceView!{
        didSet{
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(
                target: faceView,
                action: #selector(FaceView.changeScale(_:))
                ))
            
            let happierSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(FaceViewController.increaseHappines)
            )
            happierSwipeGestureRecognizer.direction = .Up
            faceView.addGestureRecognizer(happierSwipeGestureRecognizer)
            
            let sadderSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(FaceViewController.decreaseHappines)
            )
            sadderSwipeGestureRecognizer.direction = .Down
            faceView.addGestureRecognizer(sadderSwipeGestureRecognizer)
            
            updateUI()
        }
    }
    
    func increaseHappines(){
        expression.mouth = expression.mouth.happierMouth()
    }
    
    func decreaseHappines(){
        expression.mouth = expression.mouth.sadderMouth()
    }
    
    private var mouthCurvatures =
    [ FacialExpression.Mouth.Frown:-1.0,
                            .Grin:0.5,
                            .Smile:1.0,
                            .Smirk:-0.5,
                            .Neutral:0.0]
    
    private var eyeBrowTilts =
        [ FacialExpression.EyeBrows.Relaxed : 0.5,
        .Furrowed : -0.5,
        .Normal : 0.0
        ]
    
    private func updateUI(){
        switch expression.eyes{
        case .Open: faceView.eyesOpen = true
        case .Closed: faceView.eyesOpen = false
        case .Squinting: faceView.eyesOpen = false
        }
        faceView.mouthCurvature = mouthCurvatures[expression.mouth] ?? 0.0
        faceView.eyeBrowTilt = eyeBrowTilts[expression.eyeBrows] ?? 0.0
    }

}

