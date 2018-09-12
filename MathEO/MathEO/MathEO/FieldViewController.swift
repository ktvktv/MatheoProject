//
//  FieldViewController.swift
//  MathEO
//
//  Created by Kevin Tigravictor on 06/09/18.
//  Copyright © 2018 Binus University. All rights reserved.
//

import UIKit

class FieldViewController: UIViewController {

    @IBOutlet weak var matheoHead: UIImageView!
    
    @IBOutlet weak var fieldView: UIView!
    
    @IBOutlet weak var mouthTeacher: UIImageView!
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var perimeterLabel: UILabel!
    
    var perimeter : Int = 0
    
    enum state {
        case on, off
    }
    
    enum MatheoState {
        case down, right, up, left
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeNow))
        swipeGesture.direction = .right
        matheoHead.addGestureRecognizer(swipeGesture)
        
        swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeNow))
        swipeGesture.direction = .left
        matheoHead.addGestureRecognizer(swipeGesture)
        
        swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeNow))
        swipeGesture.direction = .up
        matheoHead.addGestureRecognizer(swipeGesture)
        
        swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeNow))
        swipeGesture.direction = .down
        matheoHead.addGestureRecognizer(swipeGesture)

        // Do any additional setup after loading the view.
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3){
//            self.nextView()
//        }
        
        nextButton.isHidden = true
        progressBar.progress = 0
    }
    
    func nextView() {
        UIView.animateKeyframes(withDuration: 1.5, delay: 0, options: .calculationModeCubic, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
                self.fieldView.transform = CGAffineTransform(translationX: -self.fieldView.bounds.width, y: 0)
            }
        }, completion: {(finished: Bool) in
            self.performSegue(withIdentifier: "goToFieldExerciseView", sender: nil)
        })
    }
    
    var count : Int = 1
    
    var mState = MatheoState.down
    
    @objc func swipeNow(recognizer : UISwipeGestureRecognizer){
        var trf : CGAffineTransform? = nil
        
        if recognizer.direction == .down {
            if mState == .down {
                if count == 0 {
                    count += 1
                    trf = CGAffineTransform.identity
                    
                }
                else {
                    trf = CGAffineTransform(translationX: 0, y: 250)
                    count = 0
                    mState = .right
                    
                }
            }
        }
        else if recognizer.direction == .right {
            if mState == .right {
                trf = CGAffineTransform(translationX: 250, y: 250)
                mState = .up
                
            }
        }
        else if recognizer.direction == .up {
            if mState == .up {
                if count == 0 {
                    count += 1
                    trf = CGAffineTransform(translationX: 250, y: 0)
                    
                }
                else if count == 1 {
                    count = 0
                    trf = CGAffineTransform(translationX: 250, y: -250)
                    mState = .left
                    
                }
            }
        }
        else if recognizer.direction == .left {
            if mState == .left {
                trf = CGAffineTransform(translationX: 0, y: -250)
                mState = .down
            }
        }
        
        if trf != nil {
            UIView.animate(withDuration: 2) {
                self.matheoHead.transform = trf!
            }
            
            perimeter += 5
            perimeterLabel.text = String(perimeter) + " m"
            progressBar.addProgress(0.09)
        }
        
            
            if progressBar.progress == 1 {
                if nextBool {
                    timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { (timer) in
                        if self.nextState == .off {
                            self.nextState = .on
                            self.nextButton.isHidden = false
                        }
                        else {
                            self.nextState = .off
                            self.nextButton.isHidden = true
                        }
                    })

                    nextBool = false
                }
            }
        }
    
    var timer : Timer!
    
    var nextBool = true
    
    var nextState = state.off
    
    @IBAction func nextPage(_ sender: Any) {
        timer.invalidate()

        let transition = CATransition()
        transition.duration = 0.5
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        self.view.window!.layer.add(transition, forKey: kCATransition)
        let VC = self.storyboard!.instantiateViewController(withIdentifier: "FieldExerciseViewController")
        self.present(VC, animated: false, completion: nil)

        nextView()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

