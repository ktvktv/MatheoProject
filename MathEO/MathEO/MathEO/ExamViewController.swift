//
//  ExamViewController.swift
//  MathEO
//
//  Created by Kevin Tigravictor on 06/09/18.
//  Copyright © 2018 Binus University. All rights reserved.
//

import UIKit

class ExamViewController: UIViewController {

    @IBOutlet weak var A: UIImageView!
    
    @IBOutlet weak var B: UIImageView!
    
    @IBOutlet weak var C: UIImageView!
    
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let myPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(myPanAction))
        
        let myPanGestureRecognizer2 = UIPanGestureRecognizer(target: self, action: #selector(myPanAction))
        
        let myPanGestureRecognizer3 = UIPanGestureRecognizer(target: self, action: #selector(myPanAction))
        
        A.addGestureRecognizer(myPanGestureRecognizer)
        B.addGestureRecognizer(myPanGestureRecognizer2)
        C.addGestureRecognizer(myPanGestureRecognizer3)
    }
    
    var value : Int = 0
    
    @objc func myPanAction(recognizer : UIPanGestureRecognizer){
        let translation = recognizer.translation(in: self.view)
        
        if let myView = recognizer.view {
            myView.center = CGPoint(x: myView.center.x + translation.x, y: myView.center.y + translation.y)
        }
        
        recognizer.setTranslation(CGPoint(x: 0, y: 0), in: self.view)
        
        let points = CGPoint(x: 211, y: 482)
        
        if recognizer.state == UIGestureRecognizerState.ended {
            if (recognizer.view?.frame.contains(points))! && (recognizer.view == A){
                showAnswer("A")
            }
            else if (recognizer.view?.frame.contains(points))! && (recognizer.view == B) {
                showAnswer("B")
            }
            else if (recognizer.view?.frame.contains(points))! && (recognizer.view == C){
                showAnswer("C")
            }
        }
        else{
            if answer != nil {
                answer.alpha = 0
            }
        }
    }
    
    @IBOutlet weak var examView: UIView!
    @IBOutlet weak var answer: UIImageView!
    
    func showAnswer(_ string : String){
        if string == "A" {
            answer.image = UIImage(named: "answerA")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                let transition = CATransition()
                transition.duration = 0.5
                transition.type = kCATransitionPush
                transition.subtype = kCATransitionFromRight
                transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
                self.view.window!.layer.add(transition, forKey: kCATransition)
                let VC = self.storyboard!.instantiateViewController(withIdentifier: "TeacherComingViewController")
                self.present(VC, animated: false, completion: nil)
                
                self.nextView()
            }
        }
        else if string == "B" {
            answer.image = UIImage(named: "answerB")
        }
        else if string == "C" {
            answer.image = UIImage(named: "answerC")
        }
        
        UIView.animate(withDuration: 2) {
            self.answer.alpha = 1.0
        }
    }
    
    func nextView() {
        UIView.animateKeyframes(withDuration: 1.5, delay: 0, options: .calculationModeCubic, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
                self.examView.transform = CGAffineTransform(translationX: -self.examView.bounds.width, y: 0)
            }
        }, completion: {(finished: Bool) in
            self.performSegue(withIdentifier: "goToTeacherComing", sender: nil)
        })
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
