//
//  ViewController.swift
//  ZenGarden
//
//  Created by Flatiron School on 6/30/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
// create outlets for images
    @IBOutlet weak var rakeImage: UIImageView!
    @IBOutlet weak var rockImage: UIImageView!
    @IBOutlet weak var swordInRockImage: UIImageView!
    @IBOutlet weak var shrubImage: UIImageView!
    // create panGestureRecognizers which allow user to move photo
    @IBOutlet var rakeOutlet: UIPanGestureRecognizer!
    @IBOutlet var swordInRockOutlet: UIPanGestureRecognizer!
    @IBOutlet var rockOutlet: UIPanGestureRecognizer!
    @IBOutlet var bushOutlet: UIPanGestureRecognizer!
    
    
    
    
    
    
    // create variables that will eventually be used to check if user won game
    // because they are declared here they can be reset
    var checkShrubAndRakes: Bool = false
    var checkSword: Bool = false
    var checkRock: Bool = false
    
    
    //implementing functions that allow user to interact with images
    override func viewDidLoad() {
        super.viewDidLoad()
        rakeImage.isUserInteractionEnabled = true
        rockImage.isUserInteractionEnabled = true
        swordInRockImage.isUserInteractionEnabled = true
        shrubImage.isUserInteractionEnabled = true
        //setting self as delegate for rockOutlet so that have access to UIGestureRecognizer functions
        rakeOutlet.delegate = self
        rockOutlet.delegate = self
        swordInRockOutlet.delegate = self
        bushOutlet.delegate = self
        
        
        let rockTap = UITapGestureRecognizer(target: self, action: #selector(changeBackground))
        rockTap.numberOfTapsRequired = 2
        rockImage.addGestureRecognizer(rockTap)
        
        let rakeTap = UITapGestureRecognizer(target: self, action: #selector(changeBackground))
        rakeTap.numberOfTapsRequired = 2
        rakeImage.addGestureRecognizer(rakeTap)
        
        let swordTap = UITapGestureRecognizer(target: self, action: #selector(changeBackground))
        swordTap.numberOfTapsRequired = 2
        swordInRockImage.addGestureRecognizer(swordTap)
        
        let bushTap = UITapGestureRecognizer(target: self, action: #selector(changeBackground))
        bushTap.numberOfTapsRequired = 2
        shrubImage.addGestureRecognizer(bushTap)
        
        let newPoint = UITapGestureRecognizer(target: self, action: #selector(changeCoordinates))
        view.addGestureRecognizer(newPoint)
        
        

    }


    // each action when press button
    @IBAction func rakeGesture(_ sender: UIPanGestureRecognizer) {
        //if the pan rexognizer start or changed
        if sender.state == .began || sender.state == .changed {
            // how far moving in the view, since it started firing off
            let translation = sender.translation(in: self.view)
            // making the center of the view equal how far the image moved
            sender.view!.center = CGPoint(x: sender.view!.center.x + translation.x, y: sender.view!.center.y + translation.y)
            //sets it back to zero because want translation to equal how much moved from previous, not an accumulation
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
        //taking the location of the swordinrock pan gesture
        let location = swordInRockOutlet.location(in: self.view)
        // if it is part of these locations, set that variable to true or false
        if location.x < 150 && location.y < 200 {
            checkSword = true
        } else if location.x < 150 && location.y > 600 {
            checkSword = true
        } else {
            checkSword = false
        }
    }
    
    
    
    func checkShrubAndRake() {
        // change maybe to different distance formula 
        //check for distance both way depending on which moved first
        let differenceOne = distance(a: bushOutlet.location(in: self.view), b: rakeOutlet.location(in: self.view))
        let differenceTwo = distance(a: rakeOutlet.location(in: self.view), b: bushOutlet.location(in: self.view))
        //if statement to check if reaches criter, but did > 0 , because if it wasn't touched would automatically calculate it as a win since
        //it would not fire off unless one of the two objects moved
        if (differenceOne > 0 && differenceOne < 300) || (differenceTwo > 0 && differenceTwo < 300){
            checkShrubAndRakes = true
        } else {
            checkShrubAndRakes = false
        }
    }
    
    func checkRockLocation() {
        let distanceOne = distance(a: rockOutlet.location(in: self.view), b: swordInRockOutlet.location(in: self.view))
        let distanceTwo = distance(a: swordInRockOutlet.location(in: self.view), b: rockOutlet.location(in: self.view))
        if distanceOne > 500 || distanceTwo > 500 {
            checkRock = true
        } else {
            checkRock = false
        }
    }
    
    func checkForWin () {
        //checking win conditions
        if checkRock == true && checkShrubAndRakes == true && checkSword == true {
            // created an alert
            let alert = UIAlertController(title: "Winner", message: "Congratulations! You have won!", preferredStyle: .alert)
            // created an ok action button and said when it is pressed, initiate reset function
            let oKAction = UIAlertAction(title: "Ok", style: .default) {
                oKAction in self.reset()
            }
            // added the ok button to the alert
            alert.addAction(oKAction)
            //animated the alert
            self.present(alert, animated: true, completion: nil) }
        
    }
    
    
    
    
}


extension ViewController {
    // distance formula
    func distance (a:CGPoint, b:CGPoint) -> CGFloat{
    let xDistance = a.x - b.x
    let yDistance = a.y - b.y
        return CGFloat(sqrt((xDistance * xDistance) + (yDistance * yDistance)))
    }
    
    // reset the board -- did random numbers so that would reset different everytime
    func reset () {
        rockImage.frame = CGRect(x: Int(arc4random_uniform(UInt32(300))), y: Int(arc4random_uniform(UInt32(500))), width:Int(rockImage.bounds.width), height: Int(rockImage.bounds.height))
        shrubImage.frame = CGRect(x: Int(arc4random_uniform(UInt32(300))), y: Int(arc4random_uniform(UInt32(500))), width:Int(rockImage.bounds.width), height: Int(rockImage.bounds.height))
        swordInRockImage.frame = CGRect(x: Int(arc4random_uniform(UInt32(300))), y: Int(arc4random_uniform(UInt32(500))), width:Int(rockImage.bounds.width), height: Int(rockImage.bounds.height))
        rakeImage.frame = CGRect(x: Int(arc4random_uniform(UInt32(300))), y: Int(arc4random_uniform(UInt32(500))), width:Int(rockImage.bounds.width), height: Int(rockImage.bounds.height))
        // reset them all to false, or else would have gotten won condition instantly 
        checkRock = false
        checkSword = false
        checkShrubAndRakes = false
        
        }
}

extension ViewController {
    
    func changeBackground(_ sender: UITapGestureRecognizer) {
        let tappedView = sender.view as! UIImageView
        if tappedView.backgroundColor != UIColor.red {
            tappedView.backgroundColor = UIColor.red
        } else {
            tappedView.backgroundColor = UIColor.white
        }
        
    
    }
    
    
    func changeCoordinates(_ sender: UITapGestureRecognizer) {
        print(sender.location(in: view))
        
    }
}
