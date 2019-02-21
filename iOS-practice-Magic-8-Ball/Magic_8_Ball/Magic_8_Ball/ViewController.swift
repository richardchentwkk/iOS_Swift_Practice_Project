//
//  ViewController.swift
//  Magic_8_Ball
//
//  Created by Richard on 2019/2/21.
//  Copyright © 2019 Richard Chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mBallImage: UIImageView!
    var balls = ["ball1","ball2", "ball3", "ball4", "ball5"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        getRandomBall()
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        getRandomBall()
    }
    
    fileprivate func getRandomBall() {
        let randomNumber: Int = Int.random(in: 0...4)
        mBallImage.image = UIImage(named: balls[randomNumber])
    }
    
    @IBAction func askButtonPressed(_ sender: UIButton) {
        getRandomBall()
    }
    
}

