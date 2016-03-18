//
//  ViewController.swift
//  Project 6
//
//  Created by Jackelyn Shen on 11/11/15.
//  Copyright © 2015 test. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollisionBehaviorDelegate {
    
    @IBOutlet weak var rocket: UIImageView!
    var animator: UIDynamicAnimator!
    var attachmentBehavior: UIAttachmentBehavior!
    var gravity: UIGravityBehavior!
    var collision: UICollisionBehavior!
    var timer: NSTimer!

    @IBOutlet weak var gameOver: UILabel!

    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        animator = UIDynamicAnimator(referenceView: view)
        gravity = UIGravityBehavior()
        animator.addBehavior(gravity)
        
        collision = UICollisionBehavior(items: [rocket])
//        collision.translatesReferenceBoundsIntoBoundary = true
        collision.collisionDelegate = self
        animator.addBehavior(collision)
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.3, target: self, selector: "timerFired:", userInfo: nil, repeats: true)
        
    }
    
    func timerFired(sender: NSTimer) {
        let purpleView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        purpleView.center = CGPoint(x: Int(arc4random_uniform(UInt32(self.view.frame.size.width))), y: 0)
        purpleView.backgroundColor = UIColor.purpleColor()
        view.addSubview(purpleView)
        gravity.addItem(purpleView)
        collision.addItem(purpleView)
    }
    

    func collisionBehavior(behavior: UICollisionBehavior, beganContactForItem item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, atPoint p: CGPoint) {
        let purpleView = item as! UIView
        gravity.removeItem(purpleView)
        collision.removeItem(purpleView)
        purpleView.removeFromSuperview()
    }
    
    func collisionBehavior(behavior: UICollisionBehavior, beganContactForItem item1: UIDynamicItem, withItem item2: UIDynamicItem, atPoint p: CGPoint) {
        let endOfGame = "GAME OVER"
        gameOver.text=endOfGame
        rocket.removeFromSuperview()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func handlePan(recognizer:UIPanGestureRecognizer) {
        let translation = recognizer.translationInView(self.view)
        if let view = recognizer.view {
            view.center = CGPoint(x:view.center.x + translation.x,
                y:view.center.y + translation.y)
        }
        recognizer.setTranslation(CGPointZero, inView: self.view)
        animator.updateItemUsingCurrentState(rocket)
    }
    



}

