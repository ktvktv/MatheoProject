//
//  CarDrivingViewController.swift
//  MathEO
//
//  Created by Kevin Tigravictor on 05/09/18.
//  Copyright © 2018 Binus University. All rights reserved.
//

import UIKit
import AVFoundation
import QuartzCore

class CarDrivingViewController: UIViewController {
    
    enum state {
        case on, off
    }
    
    @IBOutlet weak var background1: UIView!
    
    @IBOutlet weak var backgroundNext: UIImageView!
    
    @IBOutlet weak var currentBackground: UIImageView!
    
    @IBOutlet weak var Car: UIImageView!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var nextButton: UIButton!
    
    var audioPlayer : AVAudioPlayer!
    
    override func viewWillAppear(_ animated: Bool) {
        Car.animationImages = [UIImage(named: "car1.jpg"), UIImage(named: "car2.jpg")] as? [UIImage]
        
        Car.animationRepeatCount = 0
        Car.animationDuration = 0.2
        
        backgroundNext.frame = CGRect(x: background1.bounds.width, y: 0, width: background1.bounds.width, height: background1.bounds.height)
        
        UIView.animate(withDuration: 4, delay: 0, options: [], animations: {
            self.Car.startAnimating()
            self.audioPlayer.play()
            self.currentBackground.transform = CGAffineTransform(translationX: CGFloat(-self.backgroundNext.bounds.width), y: 0)
            self.backgroundNext.transform = CGAffineTransform(translationX: CGFloat(-self.backgroundNext.bounds.width), y: 0)
        }) { (bool) in
            self.Car.stopAnimating()
            self.audioPlayer.stop()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            let transition = CATransition()
            transition.duration = 0.5
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromRight
            transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
            self.view.window!.layer.add(transition, forKey: kCATransition)
            let VC = self.storyboard!.instantiateViewController(withIdentifier: "IpadStory")
            self.present(VC, animated: false, completion: nil)
            
            self.nextView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let path: String! = Bundle.main.resourcePath?.appending("/departurecar.mp3")
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
    }
    
    func nextView() {
        UIView.animateKeyframes(withDuration: 1.5, delay: 0, options: .calculationModeCubic, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
                self.background1.transform = CGAffineTransform(translationX: -self.background1.bounds.width, y: 0)
            }
        }, completion: {(_ : Bool) in
            self.performSegue(withIdentifier: "atCar", sender: nil)
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
