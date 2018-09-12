//
//  ChangeClothesViewController.swift
//  MathEO
//
//  Created by Kevin Tigravictor on 06/09/18.
//  Copyright © 2018 Binus University. All rights reserved.
//

import UIKit

class ChangeClothesViewController: UIViewController {

    @IBOutlet weak var changeClothesView: UIView!
    
    enum state {
        case zero, one
    }
    
    var shirtState = state.zero
    var pantsState = state.zero

    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var shirtImage: UIImageView!
    
    @IBOutlet weak var pantsImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let tapShirtGesture = UITapGestureRecognizer(target: self, action: #selector(tapShirt))
        
        let tapPantsGesture = UITapGestureRecognizer(target: self, action: #selector(tapPants))
        
        shirtImage.addGestureRecognizer(tapShirtGesture)
        pantsImage.addGestureRecognizer(tapPantsGesture)
        
        nextButton.isHidden = true
        progressBar.progress = 0
    }
    
    @objc func tapShirt(recognizer : UITapGestureRecognizer){
        
        if shirtState == .zero {
            UIView.animate(withDuration: 2) {
                self.shirtImage.alpha = 1
            }
            
            shirtState = .one
            
            progressBar.addProgress(+0.5)
        }
        else {
            UIView.animate(withDuration: 2) {
                self.shirtImage.alpha = 0.02
            }
            
            self.shirtState = state.zero
            
            progressBar.addProgress(-0.5)
        }
        
        if progressBar.progress == 1 {
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
            }
            nextButton.isHidden = true
        }
    }
    
    @objc func tapPants(recognizer : UITapGestureRecognizer){
        
        if pantsState == .zero {
            UIView.animate(withDuration: 2) {
                self.pantsImage.alpha = 1
            }
            
            pantsState = .one
            
            progressBar.addProgress(+0.5)
        }
        else {
            UIView.animate(withDuration: 2) {
                self.pantsImage.alpha = 0.02
            }
            
            self.pantsState = state.zero
            
            progressBar.addProgress(-0.5)
        }
        
        if progressBar.progress == 1 {
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
            }
            nextButton.isHidden = true
        }
    }
    
    var timer : Timer!
    
    enum NextState {
        case on, off
    }
    
    var nextState = NextState.off
    
    func nextView() {
        UIView.animateKeyframes(withDuration: 1.5, delay: 0, options: .calculationModeCubic, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
                self.changeClothesView.transform = CGAffineTransform(translationX: -self.changeClothesView.bounds.width, y: 0)
            }
        }, completion: {(finished: Bool) in
            self.performSegue(withIdentifier: "goToExplanationView", sender: nil)
        })
    }
    
    @IBAction func nextButton(_ sender: UIButton) {
        timer.invalidate()
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        self.view.window!.layer.add(transition, forKey: kCATransition)
        let VC = self.storyboard!.instantiateViewController(withIdentifier: "ExplanationViewController")
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
