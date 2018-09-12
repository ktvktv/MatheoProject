//
//  ExplanationViewController.swift
//  MathEO
//
//  Created by Kevin Tigravictor on 06/09/18.
//  Copyright © 2018 Binus University. All rights reserved.
//

import UIKit
import AVFoundation

class ExplanationViewController: UIViewController {

    @IBOutlet weak var explanationView: UIView!
    
    @IBOutlet weak var mouthView: UIImageView!
    
    @IBOutlet weak var legView: UIImageView!
    
    @IBOutlet weak var blinkOne: UIImageView!
    
    @IBOutlet weak var blinkTwo: UIImageView!
    
    @IBOutlet weak var nextButton: UIButton!
    
    var timer : Timer!
    
    enum state {
        case on, off
    }
    
    var mouthState = state.off
    
    var audioPlayer : AVAudioPlayer!
    
    var blinkState = state.on
    
    override func viewWillAppear(_ animated: Bool) {
        legView.animationImages = [UIImage(named: "run1.jpg"), UIImage(named: "run2.jpg")] as? [UIImage]
        
        mouthView.animationImages = [UIImage(named: "mouthteacher2.jpg"), UIImage(named: "mouthteacher1.jpg")] as? [UIImage]
        
        mouthView.animationDuration = 0.8
        
        legView.animationDuration = 0.5
        
        timer.fire()
        
        audioPlayer.play()
        mouthView.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + audioPlayer.duration + 1) {
            self.nextView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true, block: {(timer) in
            if self.blinkState == .on {
                self.blinkOne.isHidden = false
                self.blinkTwo.isHidden = false
                self.blinkState = .off
            }
            else {
                self.blinkTwo.isHidden = true
                self.blinkOne.isHidden = true
                self.blinkState = .on
            }
        })
        
        let path: String! = Bundle.main.resourcePath?.appending("/PEspeaking1.mp3")
        let mp3URL = URL.init(string: path)
        do
        {
            self.audioPlayer = try AVAudioPlayer(contentsOf: mp3URL!)
            self.audioPlayer.numberOfLoops = 0
        }
        catch
        {
            print("An error occurred while trying to extract audio file")
        }
    }
    
    func nextView() {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        self.view.window!.layer.add(transition, forKey: kCATransition)
        let VC = self.storyboard!.instantiateViewController(withIdentifier: "FieldViewController")
        self.present(VC, animated: false, completion: nil)
        
        UIView.animateKeyframes(withDuration: 1.5, delay: 0, options: .calculationModeCubic, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
                self.explanationView.transform = CGAffineTransform(translationX: -self.explanationView.bounds.width, y: 0)
            }
        }, completion: {(finished: Bool) in
            self.performSegue(withIdentifier: "goToField", sender: nil)
        })
    }
    
    @IBAction func nextPage(_ sender: UIButton) {
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
