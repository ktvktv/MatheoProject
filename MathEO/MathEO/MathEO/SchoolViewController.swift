//
//  schoolViewController.swift
//  MathEO
//
//  Created by Kevin Tigravictor on 05/09/18.
//  Copyright © 2018 Binus University. All rights reserved.
//

import UIKit
import AVFoundation

class SchoolViewController: UIViewController {
    
    enum state {
        case on, off
    }

    @IBOutlet weak var schoolImage: UIImageView!
    
    var audioPlayer : AVAudioPlayer!
    
    @IBOutlet weak var schoolView: UIView!
    
    @IBOutlet weak var carImage: UIImageView!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var pinch: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        carImage.animationImages = [UIImage(named: "car1.jpg"), UIImage(named: "car2.jpg")] as? [UIImage]
        
        schoolImage.image = UIImage(named: "school3.jpg")
        
        UIView.animate(withDuration: 3, animations: {
            self.audioPlayer.play()
            self.carImage.startAnimating()
            self.carImage.transform = CGAffineTransform(translationX: 230, y: 0)
        }) { (bool) in
            self.carImage.stopAnimating()
            self.pinch.isHidden = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let path: String! = Bundle.main.resourcePath?.appending("/arrivalcar.mp3")
        let mp3URL = URL.init(string: path)
        do
        {
            audioPlayer = try AVAudioPlayer(contentsOf: mp3URL!)
            audioPlayer.numberOfLoops = 0
        }
        catch
        {
            print("An error occurred while trying to extract audio file")
        }
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinchIt))
        
        schoolView.addGestureRecognizer(pinchGesture)
        nextButton.isHidden = true
        progressBar.progress = 0
        
        self.pinch.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func nextView() {
        UIView.animateKeyframes(withDuration: 1.5, delay: 0, options: .calculationModeCubic, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
                self.schoolView.transform = CGAffineTransform(translationX: -self.schoolView.bounds.width, y: 0)
            }
        }, completion: {(_ : Bool) in
            self.performSegue(withIdentifier: "MeetTeacher", sender: nil)
        })
    }
    
    var timer : Timer!
    
    var nextState = state.off
    
    @objc func pinchIt(recognizer : UIPinchGestureRecognizer){
        if recognizer.state == .began || recognizer.state == .changed{
            self.pinch.isHidden = true
            
            if recognizer.scale > 2 {
                schoolImage.image = UIImage(named: "school1.jpg")
                progressBar.setProgress(1.0, animated: true)
            }
            else {
                schoolImage.image = UIImage(named: "school2.jpg")
                progressBar.setProgress(0.5, animated: true)
            }
        }
        else if recognizer.state == .ended {
            if schoolImage.image == UIImage(named: "school1.jpg")
            {
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
        let VC = self.storyboard!.instantiateViewController(withIdentifier: "MeetTeacherViewController")
        self.present(VC, animated: false, completion: nil)
            
        self.nextView()
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
