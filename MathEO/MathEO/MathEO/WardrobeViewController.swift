//
//  WardrobeViewController.swift
//  MathEO
//
//  Created by Kevin Tigravictor on 10/09/18.
//  Copyright © 2018 Binus University. All rights reserved.
//

import UIKit

class WardrobeViewController: UIViewController {
    
    enum state {
        case on, off
    }
    
    @IBOutlet weak var nextButton: UIButton!
    
    var nextState = state.off
    
    @IBOutlet weak var wardrobeImage: UIImageView!
    
    @IBOutlet weak var shirtOne: UIImageView!
    
    @IBOutlet weak var shirtTwo: UIImageView!
    
    @IBOutlet weak var pantsOne: UIImageView!
    
    @IBOutlet weak var pantsTwo: UIImageView!
    
    var shirt = ""
    var pants = ""
    
    override func viewWillAppear(_ animated: Bool) {
        wardrobeImage.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + wardrobeImage.animationDuration) {
            self.wardrobeImage.stopAnimating()
            
            UIView.animate(withDuration: 2, animations: {
                self.shirtOne.alpha = 1
                self.shirtTwo.alpha = 1
                self.pantsOne.alpha = 1
                self.pantsTwo.alpha = 1
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        wardrobeImage.animationImages = [UIImage(named: "wardrobe1.jpg"), UIImage(named: "wardrobe2.jpg")] as? [UIImage]
        
        wardrobeImage.animationDuration = 1
        wardrobeImage.animationRepeatCount = 1
        
        var tapGestures = UITapGestureRecognizer(target: self, action: #selector(tapShirt))
        
        shirtOne.addGestureRecognizer(tapGestures)
        
        tapGestures = UITapGestureRecognizer(target: self, action: #selector(tapShirt))
        shirtTwo.addGestureRecognizer(tapGestures)
        
        var tapGestures2 = UITapGestureRecognizer(target: self, action: #selector(tapPants))
        
        pantsOne.addGestureRecognizer(tapGestures2)
        
        tapGestures2 = UITapGestureRecognizer(target: self, action: #selector(tapPants))
        pantsTwo.addGestureRecognizer(tapGestures2)
        
        nextButton.isHidden = true
    }
    
    var bols = true
    var timer : Timer!
    
    var timer2 : Timer!
    var timer3 : Timer!
    var timer4 : Timer!
    var timer5 : Timer!
    
    var shirtState = state.on
    var shirtTwoState = state.on
    var pantsState = state.on
    var pantsTwoState = state.on
    
    @objc func tapShirt(recognizer : UITapGestureRecognizer) {
        if recognizer.view == shirtOne {
            shirt = "1"
            if timer2 != nil {
                timer2.invalidate()
            }
            
            if timer3 != nil {
                timer3.invalidate()
                shirtTwo.isHidden = false
            }
                timer2 = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { (timer) in
                    if self.shirtState == .on {
                        self.shirtOne.isHidden = false
                        self.shirtState = .off
                    }
                    else {
                        self.shirtOne.isHidden = true
                        self.shirtState = .on
                    }
                })
        }
        else {
            if timer3 != nil {
                timer3.invalidate()
            }
            
            if timer2 != nil {
                timer2.invalidate()
                shirtOne.isHidden = false
            }
            shirt = "2"
            timer3 = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { (timer) in
                if self.shirtTwoState == .on {
                    self.shirtTwo.isHidden = false
                    self.shirtTwoState = .off
                }
                else {
                    self.shirtTwo.isHidden = true
                    self.shirtTwoState = .on
                }
            })
        }
        
        if shirt != "" && pants != "" && bols {
            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { (timer) in
                if self.nextState == .on {
                    self.nextButton.isHidden = false
                    self.nextState = .off
                }
                else {
                    self.nextButton.isHidden = true
                    self.nextState = .on
                }
            })
            bols = false
        }
    }
    
    @objc func tapPants(recognizer : UITapGestureRecognizer) {
        if recognizer.view == pantsOne {
            pants = "1"
            
            if timer4 != nil {
                timer4.invalidate()
            }
            
            if timer5 != nil {
                timer5.invalidate()
                pantsTwo.isHidden = false
            }
            timer4 = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { (timer) in
                if self.pantsState == .on {
                    self.pantsOne.isHidden = false
                    self.pantsState = .off
                }
                else {
                    self.pantsOne.isHidden = true
                    self.pantsState = .on
                }
            })
        }
        else {
            pants = "2"
            
            if timer5 != nil {
                timer5.invalidate()
            }
            
            if timer4 != nil {
                timer4.invalidate()
                pantsOne.isHidden = false
            }
            timer5 = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { (timer) in
                if self.pantsTwoState == .on {
                    self.pantsTwo.isHidden = false
                    self.pantsTwoState = .off
                }
                else {
                    self.pantsTwo.isHidden = true
                    self.pantsTwoState = .on
                }
            })
        }
        
        if shirt != "" && pants != "" && bols {
            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { (timer) in
                if self.nextState == .on {
                    self.nextButton.isHidden = false
                    self.nextState = .off
                }
                else {
                    self.nextButton.isHidden = true
                    self.nextState = .on
                }
            })
            bols = false
        }
    }
    
    @IBOutlet weak var wardrobeView: UIView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDressing" {
            let VC = segue.destination as? DressingViewController
            
            VC?.pants = self.pants
            VC?.shirt = self.shirt
        }
    }
    
    @IBAction func nextPage(_ sender: Any) {
        timer.invalidate()
        if timer2 != nil {
            timer2.invalidate()
        }
        
        if timer3 != nil {
            timer3.invalidate()
        }
        
        if timer4 != nil {
            timer4.invalidate()
        }
        
        if timer5 != nil {
            timer5.invalidate()
        }
        
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        self.view.window!.layer.add(transition, forKey: kCATransition)
        let VC = self.storyboard!.instantiateViewController(withIdentifier: "DressingViewController")
        self.performSegue(withIdentifier: "goToDressing", sender: nil)
        
        //nextView()
        
    }
    
    func nextView() {
        UIView.animateKeyframes(withDuration: 1.5, delay: 0, options: .calculationModeCubic, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
                self.wardrobeView.transform = CGAffineTransform(translationX: -self.wardrobeView.bounds.width, y: 0)
            }
        }, completion: {(finished: Bool) in
            self.performSegue(withIdentifier: "goToDressing", sender: nil)
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
