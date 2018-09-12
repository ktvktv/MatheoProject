//
//  FieldExerciseViewController.swift
//  MathEO
//
//  Created by Kevin Tigravictor on 06/09/18.
//  Copyright © 2018 Binus University. All rights reserved.
//

import UIKit

class FieldExerciseViewController: UIViewController{

    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var answerField: UITextField!
    
    @IBOutlet weak var fieldExerciseView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        nextButton.isHidden = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(editEnd))
        
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func editEnd(){
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func nextView() {
        UIView.animateKeyframes(withDuration: 1.5, delay: 0, options: .calculationModeCubic, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
                self.fieldExerciseView.transform = CGAffineTransform(translationX: -self.fieldExerciseView.bounds.width, y: 0)
            }
        }, completion: {(finished: Bool) in
            self.performSegue(withIdentifier: "Ending", sender: nil)
        })
    }
    
    
    
    @IBAction func checkIt(_ sender: UITextField) {
        sender.keyboardType = UIKeyboardType.default
        sender.keyboardAppearance = .dark
        
        if sender.hasText {
            if let value = Int(sender.text!) {
                if value == 30 {
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
                }
                else {
                    if timer != nil {
                        timer.invalidate()
                        nextButton.isHidden = true
                    }
                }
            }
        }
    }
    
    var timer : Timer!
    
    enum state {
        case on, off
    }
    
    var nextState = state.off
    
    @IBAction func nextPage(_ sender: UIButton) {
        timer.invalidate()
        
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        self.view.window!.layer.add(transition, forKey: kCATransition)
        let VC = self.storyboard!.instantiateViewController(withIdentifier: "EndingStory")
        self.present(VC, animated: false, completion: nil)
        
        nextView()
    }
    
    @IBAction func previousPage(_ sender: Any) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        self.view.window!.layer.add(transition, forKey: kCATransition)
        let VC = self.storyboard!.instantiateViewController(withIdentifier: "FieldViewController")
        self.present(VC, animated: false, completion: nil)
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
