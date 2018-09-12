//
//  IpadViewController.swift
//  MathEO
//
//  Created by Kevin Tigravictor on 10/09/18.
//  Copyright © 2018 Binus University. All rights reserved.
//

import UIKit

class IpadViewController: UIViewController {

    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var upvoteImage: UIImageView!
    
    @IBOutlet weak var downvoteImage: UIImageView!
    
    var value : Float = 0
    
    var timer : Timer!
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
                self.value += 0.1
                self.progressView.setProgress(self.value, animated: true)
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapNow))
        
        upvoteImage.addGestureRecognizer(tapGesture)
        
         tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapNow))
        
        downvoteImage.addGestureRecognizer(tapGesture)

        // Do any additional setup after loading the view.
        progressView.transform = CGAffineTransform(rotationAngle: 1.5708)
    }
    
    var Bools = true

    @objc func tapNow(recognizer : UITapGestureRecognizer) {
        
        if recognizer.view == upvoteImage {
                upvoteImage.image = UIImage(named: "upvote2.jpg")
        }
        else if recognizer.view == downvoteImage {
                downvoteImage.image = UIImage(named: "downvote2.jpg")
            }
        
        if Bools {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.timer.invalidate()
                    
                let transition = CATransition()
                transition.duration = 0.5
                transition.type = kCATransitionPush
                transition.subtype = kCATransitionFromRight
                transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
                self.view.window!.layer.add(transition, forKey: kCATransition)
                let VC = self.storyboard!.instantiateViewController(withIdentifier: "SchoolViewController")
                self.present(VC, animated: false, completion: nil)
                
                self.nextView()
            }
        }
    }
    
    @IBOutlet weak var ipadView: UIView!
    
    func nextView() {
        UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: .calculationModeCubic, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
                self.ipadView.transform = CGAffineTransform(translationX: -self.ipadView.bounds.width, y: 0)
            }
        }, completion: {(_ : Bool) in
            self.performSegue(withIdentifier: "arriveAtSchool", sender: nil)
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
