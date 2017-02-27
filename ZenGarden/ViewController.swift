//
//  ViewController.swift
//  ZenGarden
//
//  Created by Flatiron School on 6/30/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var rakeImage: UIImageView!
    @IBOutlet weak var rockImage: UIImageView!
    @IBOutlet weak var swordInRockImage: UIImageView!
    @IBOutlet weak var shrubImage: UIImageView!
    @IBOutlet var rakeOutlet: UIPanGestureRecognizer!
    @IBOutlet var swordInRockOutlet: UIPanGestureRecognizer!
    @IBOutlet var rockOutlet: UIPanGestureRecognizer!
    @IBOutlet var bushOutlet: UIPanGestureRecognizer!
    
    var checkShrubAndRakes: Bool = false
    var checkSword: Bool = false
    var checkRock: Bool = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rakeImage.isUserInteractionEnabled = true
        rockImage.isUserInteractionEnabled = true
        swordInRockImage.isUserInteractionEnabled = true
        shrubImage.isUserInteractionEnabled = true
        rakeOutlet.delegate = self
        rockOutlet.delegate = self
        swordInRockOutlet.delegate = self
        bushOutlet.delegate = self

    }


    
    @IBAction func rakeGesture(_ sender: UIPanGestureRecognizer) {
        if sender.state == .began || sender.state == .changed {
            let translation = sender.translation(in: self.view)
            sender.view!.center = CGPoint(x: sender.view!.center.x + translation.x, y: sender.view!.center.y + translation.y)
            sender.setTranslation(CGPoint.zero, in: self.view)
            checkShrubAndRake()
            checkForWin()
        }
    }
   
    @IBAction func rockGesture(_ sender: UIPanGestureRecognizer) {
        if sender.state == .began || sender.state == .changed {
            let translation = sender.translation(in: self.view)
            sender.view!.center = CGPoint(x: sender.view!.center.x + translation.x, y: sender.view!.center.y + translation.y)
            sender.setTranslation(CGPoint.zero, in: self.view)
            checkRockLocation()
            print(checkRock)
            checkForWin()
        }
    }
    @IBAction func swordInRockGesture(_ sender: UIPanGestureRecognizer) {
        if sender.state == .began || sender.state == .changed {
            let translation = sender.translation(in: self.view)
            sender.view!.center = CGPoint(x: sender.view!.center.x + translation.x, y: sender.view!.center.y + translation.y)
            sender.setTranslation(CGPoint.zero, in: self.view)
            checkSwordLocation()
            checkRockLocation()
            print(checkRock)
            checkForWin()
        }
    }

    @IBAction func shrubGesture(_ sender: UIPanGestureRecognizer) {
        if sender.state == .began || sender.state == .changed {
            let translation = sender.translation(in: self.view)
            sender.view!.center = CGPoint(x: sender.view!.center.x + translation.x, y: sender.view!.center.y + translation.y)
            sender.setTranslation(CGPoint.zero, in: self.view)
            checkShrubAndRake()
            checkForWin()
        }
    }
    
    func checkSwordLocation () {
        let location = swordInRockOutlet.location(in: self.view)
        if location.x < 150 && location.y < 200 {
            checkSword = true
        } else if location.x < 150 && location.y > 600 {
            checkSword = true
        } else {
            checkSword = false
        }
    }
    
    
    func checkShrubAndRake() {
        let differenceOne = distance(a: bushOutlet.location(in: self.view), b: rakeOutlet.location(in: self.view))
        let differenceTwo = distance(a: rakeOutlet.location(in: self.view), b: bushOutlet.location(in: self.view))
        print("distance A is \(differenceOne)")
        print("distance B is \(differenceTwo)")
        if (differenceOne > 0 && differenceOne < 300) || (differenceTwo > 0 && differenceTwo < 300){
            checkShrubAndRakes = true
        } else {
            checkShrubAndRakes = false
        }
    }
    
    func checkRockLocation() {
        let distanceOne = distance(a: rockOutlet.location(in: self.view), b: swordInRockOutlet.location(in: self.view))
        let distanceTwo = distance(a: swordInRockOutlet.location(in: self.view), b: rockOutlet.location(in: self.view))
        print(distanceTwo)
        print(distanceOne)
        if distanceOne > 500 || distanceTwo > 500 {
            checkRock = true
        } else {
            checkRock = false
        }
    }
    
    func checkForWin () {
        if checkRock == true && checkShrubAndRakes == true && checkSword == true {
            let alert = UIAlertController(title: "Winner", message: "Congratulations! You have won!", preferredStyle: .alert)
            let oKAction = UIAlertAction(title: "Ok", style: .default) {
                oKAction in self.reset()
            }
            alert.addAction(oKAction)
            self.present(alert, animated: true, completion: nil) }
        
    }
    
    
    
    
}


extension ViewController {
    func distance (a:CGPoint, b:CGPoint) -> CGFloat{
    let xDistance = a.x - b.x
    let yDistance = a.y - b.y
        return CGFloat(sqrt((xDistance * xDistance) + (yDistance * yDistance)))
    }
    
    func reset () {
        rockImage.frame = CGRect(x: Int(arc4random_uniform(UInt32(300))), y: Int(arc4random_uniform(UInt32(500))), width:Int(rockImage.bounds.width), height: Int(rockImage.bounds.height))
        shrubImage.frame = CGRect(x: Int(arc4random_uniform(UInt32(300))), y: Int(arc4random_uniform(UInt32(500))), width:Int(rockImage.bounds.width), height: Int(rockImage.bounds.height))
        swordInRockImage.frame = CGRect(x: Int(arc4random_uniform(UInt32(300))), y: Int(arc4random_uniform(UInt32(500))), width:Int(rockImage.bounds.width), height: Int(rockImage.bounds.height))
        rakeImage.frame = CGRect(x: Int(arc4random_uniform(UInt32(300))), y: Int(arc4random_uniform(UInt32(500))), width:Int(rockImage.bounds.width), height: Int(rockImage.bounds.height))
        checkRock = false
        checkSword = false
        checkShrubAndRakes = false
        
        }
}

