//
//  ViewController.swift
//  Dicee
//
//  Created by Richard on 2019/2/20.
//  Copyright © 2019 Richard Chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var randomDice1: Int = 0;
    var randomDice2: Int = 0;
    var dice = ["dice1", "dice2", "dice3", "dice4", "dice5", "dice6"]
    
    @IBOutlet weak var DiceImageView1: UIImageView!
    @IBOutlet weak var DiceImageView2: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        getRandomDice()
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        getRandomDice()
    }

    fileprivate func getRandomDice() {
        randomDice1 = Int.random(in: 0 ... 5)
        randomDice2 = Int.random(in: 0 ... 5)
        DiceImageView1.image = UIImage(named:dice[randomDice1] )
        DiceImageView2.image = UIImage(named:dice[randomDice2] )
    }
    
    @IBAction func ButtonPressed(_ sender: UIButton) {
        getRandomDice()
    }
    
}

