//
//  BathroomViewController.swift
//  MathEO
//
//  Created by Kevin Tigravictor on 05/09/18.
//  Copyright © 2018 Binus University. All rights reserved.
//

import UIKit
import AVFoundation

class BathroomViewController: UIViewController {
    
    enum bathroomState {
        case hot, off, cold
    }
    
    enum NextState {
        case on, off
    }
    
    @IBOutlet weak var showerImage: UIImageView!
    
    @IBOutlet weak var bathroomView: UIView!
    
    @IBOutlet weak var onOffImage: UIImageView!
    
    @IBOutlet weak var newButton: UIButton!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    var audioPlayer : AVAudioPlayer!
    
    var state = bathroomState.off
    
    var nextState = NextState.on
    
    var timerState = true
    
    var go : Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        showerImage.image = UIImage(named: "bathroom4.jpg")
        
        let path: String! = Bundle.main.resourcePath?.appending("/shower.mp3")
        let mp3URL = URL.init(string: path)
        do
        {
            audioPlayer = try AVAudioPlayer(contentsOf: mp3URL!)
            audioPlayer.numberOfLoops = -1
        }
        catch
        {
            print("An error occurred while trying to extract audio file")
        }
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(onShower))
        swipeRight.direction = .right
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(onShower))
        swipeLeft.direction = .left
        
        onOffImage.addGestureRecognizer(swipeRight)
        onOffImage.addGestureRecognizer(swipeLeft)
        
        newButton.isHidden = true
        progressBar.progress = 0
    }
    
    @objc func onShower(recognizer : UISwipeGestureRecognizer) {
        
        progressBar.addProgress(0.5)
        if progressBar.progress == 1 {
            if timerState {
                go = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { (timer) in
                    if self.nextState == .on {
                        self.newButton.isHidden = false
                        self.nextState = .off
                    }
                    else {
                        self.newButton.isHidden = true
                        self.nextState = .on
                    }
                }
                
                timerState = false
            }
        }
        
        if recognizer.direction == .left {
            if state == .cold {
                state = .off
            }
            else if state == .off {
                state = .hot
            }
        }
        else if recognizer.direction == .right {
            if state == .hot {
                state = .off
            }
            else if state == .off {
                state = .cold
            }
        }
        
        if state == .cold {
            onOffImage.image = UIImage(named: "bathKnob 2.jpg")
            showerImage.animationImages = [UIImage(named: "bathroom1.jpg"), UIImage(named: "bathroom2.jpg")] as? [UIImage]
            
            showerImage.animationDuration = 0.2
            
            showerImage.startAnimating()
            
            audioPlayer.play()
        }
        else if state == .hot {
            onOffImage.image = UIImage(named: "bathKnob 3.jpg")
            
            showerImage.animationImages = [UIImage(named: "bathroom1.jpg"), UIImage(named: "bathroom2.jpg")] as? [UIImage]
            
            showerImage.animationDuration = 0.2
            
            showerImage.startAnimating()
            
            audioPlayer.play()
        }
        else if state == .off {
            onOffImage.image = UIImage(named: "bathKnob 1.jpg")
            
            self.showerImage.stopAnimating()
            
            self.showerImage.image = UIImage(named: "bathroom3.jpg")
                
            audioPlayer.stop()
        }
    }

    @IBAction func goToNextPage(_ sender: Any) {
        audioPlayer.stop()
        go.invalidate()
        
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        self.view.window!.layer.add(transition, forKey: kCATransition)
        let VC = self.storyboard!.instantiateViewController(withIdentifier: "WardrobeStory")
        self.present(VC, animated: false, completion: nil)
        
        nextView()
    }
    
    func nextView() {
        UIView.animateKeyframes(withDuration: 1.5, delay: 0, options: .calculationModeCubic, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
                self.bathroomView.transform = CGAffineTransform(translationX: -self.bathroomView.bounds.width, y: 0)
            }
        }, completion: {(finished: Bool) in
            self.performSegue(withIdentifier: "goToWardrobe", sender: nil)
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

extension UIProgressView {
    func addProgress(_  value : Float) {
        if value > 0 {
            if progress + value <= 1 {
                progress += value
            }
            else {
                progress = 1
            }
        }
        else {
            if progress + value >= 0 {
                progress += value
            }
            else {
                progress = 0
            }
        }
    }
}
