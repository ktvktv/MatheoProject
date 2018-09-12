//
//  DressingViewController.swift
//  MathEO
//
//  Created by Kevin Tigravictor on 05/09/18.
//  Copyright © 2018 Binus University. All rights reserved.
//

import UIKit

class DressingViewController: UIViewController {
    
    enum state {
        case on, off
    }
    
    var shirt : String = ""
    var pants : String = ""

    @IBOutlet weak var matheoImage: UIImageView!
    
    @IBOutlet weak var dressingView: UIView!
    
    @IBOutlet weak var nextButton: UIButton!
    
    var timer : Timer!
    
    @IBOutlet weak var shirtImage: UIImageView!
    
    @IBOutlet weak var pantsImage: UIImageView!
    
    var nextState = state.on
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        timer = Timer(timeInterval: 0.5, repeats: true, block: { (timer) in
                if self.nextState == .on {
                    self.nextButton.isHidden = false
                    self.nextState = .off
                }
                else {
                    self.nextButton.isHidden = true
                    self.nextState = .on
                }
        })
    }
    
    @IBOutlet weak var shirtImageBlue: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        UIView.animate(withDuration: 3, animations: {
            if self.shirt == "1" {
                self.shirtImage.image = UIImage(named: "shirt3.jpg")
                self.shirtImage.alpha = 1
            }
            else {
                self.shirtImageBlue.alpha = 1
            }
            
            if self.pants == "1" {
                self.pantsImage.image = UIImage(named: "pants4.jpg")
            }
            else {
                self.pantsImage.image = UIImage(named: "pants3.jpg")
            }
            
            self.pantsImage.alpha = 1
        }) { (bool) in
            self.timer.fire()
        }
    }
    
    @IBAction func nextPage(_ sender: Any) {
        timer.invalidate()
        
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        self.view.window!.layer.add(transition, forKey: kCATransition)
        let VC = self.storyboard!.instantiateViewController(withIdentifier: "CarDrivingViewController")
        self.present(VC, animated: false, completion: nil)
        
        nextView()
    }
    
    func nextView() {
        UIView.animateKeyframes(withDuration: 1.5, delay: 0, options: .calculationModeCubic, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
                self.dressingView.transform = CGAffineTransform(translationX: -self.dressingView.bounds.width, y: 0)
            }
        }, completion: {(finished: Bool) in
            self.performSegue(withIdentifier: "drivingToSchool", sender: nil)
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
